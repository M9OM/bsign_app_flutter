import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:bsign/models/signature_field/signaure_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:pdfx/pdfx.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';
import 'package:bsign/models/signature_field/signature_field_model.dart';

class PdfProcessingService {
  final _client = Supabase.instance.client;
  final _uuid = const Uuid();

  Future<Uint8List> generateSignedPdf({
    required String originalPdfUrl,
    required List<SignatureField> signatureFields,
    required Map<String, Uint8List> signatureImages,
  }) async {
    try {
      // Download original PDF
      final response = await _client.storage
          .from('documents')
          .download(originalPdfUrl);

      // Load PDF document
      final document = await PdfDocument.openData(response);
      
      // Process each page and add signatures
      final List<Uint8List> processedPages = [];
      
      for (int pageIndex = 0; pageIndex < document.pagesCount; pageIndex++) {
        final page = await document.getPage(pageIndex + 1);
        
        // Get page fields for this page
        final pageFields = signatureFields
            .where((field) => field.pageNumber == pageIndex)
            .toList();
        
        if (pageFields.isEmpty) {
          // No signatures on this page, use original
          final pageImage = await page.render(
            width: page.width,
            height: page.height,
          );
          processedPages.add(pageImage!.bytes);
        } else {
          // Render page with signatures
          final processedPage = await _renderPageWithSignatures(
            page: page,
            fields: pageFields,
            signatureImages: signatureImages,
          );
          processedPages.add(processedPage);
        }
        
        await page.close();
      }
      
      await document.close();
      
      // Combine all pages into a single PDF
      return await _combinePagesIntoPdf(processedPages);
      
    } catch (e) {
      print('Error generating signed PDF: $e');
      rethrow;
    }
  }

  Future<Uint8List> _renderPageWithSignatures({
    required PdfPage page,
    required List<SignatureField> fields,
    required Map<String, Uint8List> signatureImages,
  }) async {
    // Render the original page
    final pageImage = await page.render(
      width: page.width * 2, // Higher resolution
      height: page.height * 2,
    );

    if (pageImage == null) {
      throw Exception('Failed to render page');
    }

    // Create a canvas to draw on
    final recorder = ui.PictureRecorder();
    final canvas = Canvas(recorder);
    
    // Draw the original page
    final pageImageUi = await _bytesToImage(pageImage.bytes);
    canvas.drawImage(pageImageUi, Offset.zero, Paint());
    
    // Add signatures and text fields
    for (final field in fields) {
      await _drawFieldOnCanvas(
        canvas: canvas,
        field: field,
        pageWidth: page.width * 2,
        pageHeight: page.height * 2,
        signatureImages: signatureImages,
      );
    }
    
    // Convert canvas to image
    final picture = recorder.endRecording();
    final img = await picture.toImage(
      (page.width * 2).round(),
      (page.height * 2).round(),
    );
    
    final byteData = await img.toByteData(format: ui.ImageByteFormat.png);
    return byteData!.buffer.asUint8List();
  }

  Future<void> _drawFieldOnCanvas({
    required Canvas canvas,
    required SignatureField field,
    required double pageWidth,
    required double pageHeight,
    required Map<String, Uint8List> signatureImages,
  }) async {
    final left = field.x * pageWidth;
    final top = field.y * pageHeight;
    final width = field.width * pageWidth;
    final height = field.height * pageHeight;

    switch (field.type) {
      case SignatureFieldType.signature:
        // Draw signature image if available
        final signatureData = signatureImages[field.id];
        if (signatureData != null) {
          final signatureImage = await _bytesToImage(signatureData);
          final srcRect = Rect.fromLTWH(0, 0, signatureImage.width.toDouble(), signatureImage.height.toDouble());
          final dstRect = Rect.fromLTWH(left, top, width, height);
          canvas.drawImageRect(signatureImage, srcRect, dstRect, Paint());
        }
        break;
        
      case SignatureFieldType.name:
      case SignatureFieldType.text:
        // Draw text
        if (field.value != null && field.value!.isNotEmpty) {
          final textPainter = TextPainter(
            text: TextSpan(
              text: field.value!,
              style: TextStyle(
                fontSize: height * 0.6,
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
            textDirection: TextDirection.ltr,
          );
          textPainter.layout(maxWidth: width);
          textPainter.paint(canvas, Offset(left, top + (height - textPainter.height) / 2));
        }
        break;
        
      case SignatureFieldType.date:
        // Draw date
        final dateText = field.value ?? DateTime.now().toString().split(' ')[0];
        final textPainter = TextPainter(
          text: TextSpan(
            text: dateText,
            style: TextStyle(
              fontSize: height * 0.6,
              color: Colors.black,
              fontWeight: FontWeight.w500,
            ),
          ),
          textDirection: TextDirection.ltr,
        );
        textPainter.layout(maxWidth: width);
        textPainter.paint(canvas, Offset(left, top + (height - textPainter.height) / 2));
        break;
    }
  }

  Future<ui.Image> _bytesToImage(Uint8List bytes) async {
    final codec = await ui.instantiateImageCodec(bytes);
    final frame = await codec.getNextFrame();
    return frame.image;
  }

  Future<Uint8List> _combinePagesIntoPdf(List<Uint8List> pageImages) async {
    // This is a simplified version. In a real app, you'd use a proper PDF library
    // to combine images into a PDF. For now, we'll return the first page.
    // You could use packages like pdf or syncfusion_flutter_pdf for this.
    return pageImages.first;
  }

  Future<String> uploadSignedPdf({
    required String documentId,
    required Uint8List pdfBytes,
    required String userId,
  }) async {
    final fileName = 'signed_docs/${documentId}_signed_${DateTime.now().millisecondsSinceEpoch}.pdf';
    
    await _client.storage
        .from('documents')
        .uploadBinary(fileName, pdfBytes);
    
    return _client.storage
        .from('documents')
        .getPublicUrl(fileName);
  }

  Future<Map<String, Uint8List>> collectSignatureImages(
    List<SignatureField> fields,
  ) async {
    final Map<String, Uint8List> signatureImages = {};
    
    for (final field in fields) {
      if (field.type == SignatureFieldType.signature && field.value != null) {
        // In a real implementation, you'd fetch the signature image from storage
        // For now, we'll skip this step
        // signatureImages[field.id] = await _fetchSignatureImage(field.value!);
      }
    }
    
    return signatureImages;
  }
}