import 'dart:typed_data';
import 'package:bsign/providers/signature_field_provider.dart';
import 'package:bsign/view/widgets/pdf_viewr/postion_sign.dart';
import 'package:flutter/material.dart';
import 'package:pdfx/pdfx.dart';
import 'package:bsign/models/signature_field/signature_field_model.dart';
import 'package:provider/provider.dart';

class PdfDocumentViewer extends StatefulWidget {
  final PdfControllerPinch pdfController;
  final int currentPage;
  final List<SignatureField> pageFields;
  final bool editable;
  final Function(SignatureField)? onFieldMoved;
  final double? overrideWidth;
  final String? selectedRecipientUid;

  const PdfDocumentViewer({
    super.key,
    required this.pdfController,
    required this.currentPage,
    required this.pageFields,
    this.editable = false,
    this.onFieldMoved,
    this.overrideWidth,
    this.selectedRecipientUid,
  });

  @override
  State<PdfDocumentViewer> createState() => _PdfDocumentViewerState();
}

class _PdfDocumentViewerState extends State<PdfDocumentViewer> {
  Uint8List? _pageImageBytes;
  // سنحتفظ بنسبة العرض إلى الارتفاع بدلاً من الأبعاد الثابتة
  double _aspectRatio = 1.0;

  @override
  void didUpdateWidget(covariant PdfDocumentViewer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.currentPage != oldWidget.currentPage) {
      _loadPage();
    }
  }

  @override
  void initState() {
    super.initState();
    _loadPage();
  }

  Future<void> _loadPage() async {
    // تأكد من أن الـ controller جاهز قبل استخدامه
    if (widget.pdfController == null) return;
    
    final document = await widget.pdfController.document;
    final page = await document.getPage(widget.currentPage + 1);
    
    // حساب نسبة الأبعاد
    _aspectRatio = page.width / page.height;

    // عرض الصفحة بجودة عالية للتعامل مع التكبير والتصغير
    final image = await page.render(width: page.width * 2, height: page.height * 2);
    _pageImageBytes = image?.bytes;
    
    await page.close();
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {

final SignatureFieldProvider signatureProvider = Provider.of<SignatureFieldProvider>(context);

    if (_pageImageBytes == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return Center(
      // استخدام AspectRatio للحفاظ على أبعاد الصفحة صحيحة
      child: AspectRatio(
        aspectRatio: _aspectRatio,
        // استخدام LayoutBuilder للحصول على الأبعاد الفعلية عند العرض
        child: LayoutBuilder(
          builder: (context, constraints) {
            // هذه هي الأبعاد الحقيقية للصورة المعروضة على الشاشة
            final double renderedWidth = constraints.maxWidth;
            final double renderedHeight = constraints.maxHeight;

            return InteractiveViewer(
              minScale: 1.0,
              maxScale: 4.0,
              boundaryMargin: const EdgeInsets.all(100),
              child: Stack(
                // تأكد من أن الـ Stack يملأ المساحة المتاحة
                fit: StackFit.expand,
                children: [
                  Image.memory(
                    _pageImageBytes!,
                    fit: BoxFit.fill,
                  ),
                  // تمرير الأبعاد الحقيقية لكل مربع توقيع
                  ...widget.pageFields.map(
                    (field) => PositionedSignatureBox(
                      field: field,
                      onDelete: () {
                        setState(() {
                          signatureProvider.deleteField(field.id);
                        });
                      },
                      pageWidth: renderedWidth,
                      pageHeight: renderedHeight,
                      scale: 1.0, // المقياس الآن ضمني في الأبعاد
                      onPositionChanged: widget.editable ? widget.onFieldMoved : null,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
