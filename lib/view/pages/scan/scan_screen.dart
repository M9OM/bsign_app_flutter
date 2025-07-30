import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_doc_scanner/flutter_doc_scanner.dart';
class ScanScreen extends StatefulWidget {
  const ScanScreen({super.key});

  @override
  _ScanScreenState createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  List<String> scannedFiles = [];

  Future<void> scanDocument() async {
    dynamic scannedDocuments;
    try {
      scannedDocuments = await FlutterDocScanner().getScanDocuments(page: 3) ??
          'Unknown platform documents';
    } on PlatformException {
      scannedDocuments = 'Failed to get scanned documents.';
    }

    print(scannedDocuments.toString());

    // إذا النتيجة عبارة عن List<String> (مسارات ملفات)
    if (scannedDocuments is List<String>) {
      setState(() {
        scannedFiles = List<String>.from(scannedDocuments);
      });
    } else if (scannedDocuments is String) {
      // رسالة خطأ أو غيرها
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(scannedDocuments)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Document Scanner")),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: scanDocument,
            child: Text("Scan Documents (3 pages)"),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: scannedFiles.length,
              itemBuilder: (context, index) {
                return Card(
                  child: Image.file(
                    File(scannedFiles[index]),
                    fit: BoxFit.cover,
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
