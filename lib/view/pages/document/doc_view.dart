import 'package:bsign/view/widgets/pdf_viewr/pdf_viewer.dart';
import 'package:flutter/material.dart';
import 'package:pdfx/pdfx.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import 'package:bsign/models/signature_field/signature_field_model.dart';
import 'package:bsign/providers/signature_field_provider.dart';

class DocumentViewScreen extends StatefulWidget {
  final String documentId;
  final String filePath;
  final int totalPages;

  const DocumentViewScreen({
    super.key,
    required this.documentId,
    required this.filePath,
    required this.totalPages,
  });

  @override
  State<DocumentViewScreen> createState() => _DocumentViewScreenState();
}

class _DocumentViewScreenState extends State<DocumentViewScreen> {
  late PdfControllerPinch _pdfController;
  int currentPageIndex = 0;
  List<SignatureField> fields = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _initPdf();
  }

  Future<void> _initPdf() async {
    try {
      final response = await http.get(Uri.parse(widget.filePath));
      if (response.statusCode == 200) {
        final bytes = response.bodyBytes;
        final doc = await PdfDocument.openData(bytes);

        _pdfController = PdfControllerPinch(document: Future.value(doc));

        await Provider.of<SignatureFieldProvider>(context, listen: false)
            .loadFields(widget.documentId);

        setState(() {
          fields = Provider.of<SignatureFieldProvider>(context, listen: false).fields;
          _loading = false;
        });
      } else {
        throw Exception('Failed to load PDF from URL');
      }
    } catch (e) {
      debugPrint('PDF Load Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error loading PDF: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final pageFields = fields.where((f) => f.pageNumber == currentPageIndex).toList();

    return Scaffold(
      appBar: AppBar(title: const Text('View Document')),
      body: PdfDocumentViewer(
        pdfController: _pdfController,
        currentPage: currentPageIndex,
        pageFields: pageFields,
        editable: false,
        onFieldMoved: null,
      ),
    );
  }
}
