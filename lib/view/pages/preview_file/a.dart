import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/rendering.dart';

class AnnotateImagePage extends StatefulWidget {
  final File imageFile;
  const AnnotateImagePage({super.key, required this.imageFile});

  @override
  State<AnnotateImagePage> createState() => _AnnotateImagePageState();
}

class _AnnotateImagePageState extends State<AnnotateImagePage> {
  final GlobalKey _globalKey = GlobalKey();
  final List<_DraggableElement> elements = [];

  void _addElement(String label) {
    setState(() {
      elements.add(_DraggableElement(label: label, offset: const Offset(50, 50)));
    });
  }

  Future<void> _saveAnnotatedImage() async {
    RenderRepaintBoundary boundary = _globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
    ui.Image image = await boundary.toImage(pixelRatio: 3.0);
    ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    Uint8List pngBytes = byteData!.buffer.asUint8List();

    final directory = await getApplicationDocumentsDirectory();
    final annotatedFile = File("${directory.path}/annotated_image.png");
    await annotatedFile.writeAsBytes(pngBytes);

    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => ImagePreviewPage(file: annotatedFile)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Annotate Image"),
        actions: [
          IconButton(icon: const Icon(Icons.save), onPressed: _saveAnnotatedImage),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: RepaintBoundary(
              key: _globalKey,
              child: Stack(
                children: [
                  Positioned.fill(child: Image.file(widget.imageFile, fit: BoxFit.contain)),
                  ...elements.map((e) => Positioned(
                    left: e.offset.dx,
                    top: e.offset.dy,
                    child: Draggable(
                      feedback: _elementWidget(e.label),
                      childWhenDragging: Container(),
                      onDraggableCanceled: (_, offset) {
                        setState(() => e.offset = offset);
                      },
                      child: _elementWidget(e.label),
                    ),
                  )),
                ],
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(onPressed: () => _addElement("Name"), child: const Text("Name")),
              ElevatedButton(onPressed: () => _addElement("Email"), child: const Text("Email")),
              ElevatedButton(onPressed: () => _addElement("Date"), child: const Text("Date")),
              ElevatedButton(onPressed: () => _addElement("Signature"), child: const Text("Signature")),
            ],
          )
        ],
      ),
    );
  }

  Widget _elementWidget(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      color: Colors.yellow.shade200,
      child: Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
    );
  }
}

class _DraggableElement {
  String label;
  Offset offset;
  _DraggableElement({required this.label, required this.offset});
}

class ImagePreviewPage extends StatelessWidget {
  final File file;
  const ImagePreviewPage({super.key, required this.file});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Preview")),
      body: Center(child: Image.file(file)),
    );
  }
}
