import 'dart:typed_data';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:signature/signature.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
// import 'package:image_gallery_saver/image_gallery_saver.dart';

class SignaturePage extends StatefulWidget {
  const SignaturePage({super.key});

  @override
  _SignaturePageState createState() => _SignaturePageState();
}

class _SignaturePageState extends State<SignaturePage> {
  final SignatureController _controller = SignatureController(
    penStrokeWidth: 3,
    penColor: Colors.black,
    exportBackgroundColor: Colors.transparent, // Transparent background
  );

  String? savedImagePath;

  Future<void> _saveSignature() async {
    if (_controller.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please draw a signature first.")),
      );
      return;
    }

    final Uint8List? data = await _controller.toPngBytes();
    if (data == null) return;

    // Request storage permission
    final status = await Permission.storage.request();
    if (!status.isGranted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Storage permission denied.")),
      );
      return;
    }

    // Save signature to temporary directory
    final tempDir = await getTemporaryDirectory();
    final filePath =
        '${tempDir.path}/signature_${DateTime.now().millisecondsSinceEpoch}.png';
    final file = File(filePath);
    await file.writeAsBytes(data);

    // Save to gallery
    // final result = await ImageGallerySaver.saveImage(
    //   data,
    //   quality: 100,
    //   name: "signature_${DateTime.now().millisecondsSinceEpoch}",
    // );

    // if (result['isSuccess'] == true) {
    //   setState(() {
    //     savedImagePath = file.path;
    //   });

    //   ScaffoldMessenger.of(context).showSnackBar(
    //     SnackBar(content: Text("Signature saved to gallery.")),
    //   );
    // } else {
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     SnackBar(content: Text("Failed to save signature.")),
    //   );
    // }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Signature Pad")),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Signature(
              
              controller: _controller,
              height: 300,
              backgroundColor: Colors.grey[200]!,
            ),


SizedBox(height: 20,),

Row(
  mainAxisAlignment: MainAxisAlignment.spaceAround,
  children: [
    Container(

      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.redAccent.withOpacity(0.15),
      ),
      child: IconButton(
        icon: Icon(HugeIcons.strokeRoundedDelete01,size: 40, color: Colors.redAccent),
        onPressed: () => _controller.clear(),
        tooltip: 'Clear',
      ),
    ),
    Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.green.withOpacity(0.15),
      ),
      child: IconButton(
        
        icon: Icon(HugeIcons.strokeRoundedAddCircle,size: 40, color: Colors.green),
        onPressed: _saveSignature,
        tooltip: 'Save',
      ),
    ),
  ],
)
,            if (savedImagePath != null) ...[
              SizedBox(height: 20),
              Text("Signature Preview:", style: TextStyle(fontWeight: FontWeight.bold)),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  color: Colors.grey[200],
                  child: Image.file(File(savedImagePath!)),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
