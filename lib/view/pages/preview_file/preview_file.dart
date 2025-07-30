import 'dart:io';

import 'package:bsign/providers/attachment_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// ignore: depend_on_referenced_packages
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

bool kIsDesktop = kIsWeb || Platform.isMacOS || Platform.isWindows;

class PdfAnnotationScreen extends StatefulWidget {
  const PdfAnnotationScreen({super.key});

  @override
  State<PdfAnnotationScreen> createState() => _PdfAnnotationScreenState();
}

class _PdfAnnotationScreenState extends State<PdfAnnotationScreen> {
  Uint8List? _documentBytes;
  final PdfViewerController _controller = PdfViewerController();
  final List<_AnnotationItem> _annotations = [];

  @override
  void initState() {
    super.initState();
  }



  void _addSignature(Offset localPosition) {
    setState(() {
      _annotations.add(
        _AnnotationItem(
          id: UniqueKey().toString(),
          type: AnnotationType.signature,
          pageNumber: _controller.pageNumber - 1,
          position: localPosition,
        ),
      );
    });
  }

  Future<void> _saveAnnotationsToPdf() async {
    if (_documentBytes == null) return;
    final document = PdfDocument(inputBytes: _documentBytes);

    for (var annotation in _annotations) {
      final page = document.pages[annotation.pageNumber];
      page.graphics.drawRectangle(
        bounds: Rect.fromLTWH(
          annotation.position.dx,
          annotation.position.dy,
          100,
          50,
        ),
        brush: PdfSolidBrush(PdfColor(0, 0, 255)),
      );
    }

    final newBytes = await document.save();
    setState(() {
      _documentBytes = Uint8List.fromList(newBytes);
      _annotations.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PDF Annotation'),
        actions: [
          IconButton(
            icon: const Icon(Icons.folder_open),
            onPressed: () async {
              await context.read<AttachmentProvider>().pickFiles();
            },
          ),
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _saveAnnotationsToPdf,
          ),
        ],
      ),
      body: _documentBytes == null
          ? const Center(child: Text('No PDF selected'))
          : Stack(
              children: [
                SfPdfViewer.memory(
                  _documentBytes!,
                  controller: _controller,
                  pageSpacing: 4,
                  enableTextSelection: false,
                ),
                ..._annotations.map((annotation) {
                  return Positioned(
                    left: annotation.position.dx,
                    top: annotation.position.dy,
                    child: Draggable(
                      feedback: _buildAnnotationWidget(annotation),
                      childWhenDragging: Container(),
                      onDragEnd: (details) {
                        setState(() {
                          annotation.position = details.offset;
                        });
                      },
                      child: _buildAnnotationWidget(annotation),
                    ),
                  );
                }),
                GestureDetector(
                  onTapDown: (details) {
                    _addSignature(details.localPosition);
                  },
                ),
              ],
            ),
    );
  }

  Widget _buildAnnotationWidget(_AnnotationItem annotation) {
    switch (annotation.type) {
      case AnnotationType.signature:
        return Container(
          width: 100,
          height: 50,
          color: Colors.blue.withOpacity(0.5),
          child: const Center(child: Text('Signature')),
        );
      case AnnotationType.name:
        return Container(
          width: 100,
          height: 30,
          color: Colors.green.withOpacity(0.5),
          child: const Center(child: Text('Name')),
        );
      case AnnotationType.date:
        return Container(
          width: 100,
          height: 30,
          color: Colors.orange.withOpacity(0.5),
          child: const Center(child: Text('Date')),
        );
      default:
        return Container();
    }
  }
}

enum AnnotationType { signature, name, date }

class _AnnotationItem {
  String id;
  AnnotationType type;
  int pageNumber;
  Offset position;

  _AnnotationItem({
    required this.id,
    required this.type,
    required this.pageNumber,
    required this.position,
  });
}
