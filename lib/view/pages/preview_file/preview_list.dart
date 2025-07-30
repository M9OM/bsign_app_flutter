import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:file_picker/file_picker.dart';


class PDFSelectorPage extends StatefulWidget {
  const PDFSelectorPage({super.key});

  @override
  _PDFSelectorPageState createState() => _PDFSelectorPageState();
}

class _PDFSelectorPageState extends State<PDFSelectorPage> {
  String? _pdfPath;
  final List<Rect> _signatureBoxes = [];

  Future<void> _pickPDF() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.custom, allowedExtensions: ['pdf']);
    if (result != null && result.files.single.path != null) {
      setState(() {
        _pdfPath = result.files.single.path;
        _signatureBoxes.clear();
      });
    }
  }

  void _addSignatureBox(Offset position) {
    setState(() {
      _signatureBoxes.add(Rect.fromLTWH(position.dx, position.dy, 120, 60));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('حدد ملف PDF')),
      body: _pdfPath == null
          ? Center(
              child: ElevatedButton(
                onPressed: _pickPDF,
                child: Text('اختر ملف PDF'),
              ),
            )
          : Stack(
              children: [
                Positioned.fill(
                  child: GestureDetector(
                    onTapDown: (details) => _addSignatureBox(details.localPosition),
                    child: PDFView(
                      filePath: _pdfPath,
                    ),
                  ),
                ),
                ..._signatureBoxes.map((box) => Positioned(
                      left: box.left,
                      top: box.top,
                      child: Container(
                        width: box.width,
                        height: box.height,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.blueAccent, width: 2),
                          color: Colors.blue.withOpacity(0.2),
                        ),
                        child: Center(child: Text('توقيع')),
                      ),
                    ))
              ],
            ),
    );
  }
}
