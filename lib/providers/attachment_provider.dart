import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
import 'package:flutter_doc_scanner/flutter_doc_scanner.dart';
import 'package:path/path.dart' as path;

class AttachmentProvider extends ChangeNotifier {
  List<File> _selectedFiles = [];
  List<String> _fileNames = [];
  List<String> _fileTypes = [];

  List<File> get selectedFiles => _selectedFiles;
  List<String> get fileNames => _fileNames;
  List<String> get fileTypes => _fileTypes;

  /// المسح باستخدام الكاميرا – يسمح فقط بملف واحد
  Future<void> scanDocument() async {
    dynamic scannedDocuments;
    try {
      scannedDocuments = await FlutterDocScanner().getScanDocuments(page: 3);
    } on PlatformException catch (e) {
      debugPrint('Failed to get scanned documents: $e');
      return;
    }

    if (scannedDocuments != null &&
        scannedDocuments is List &&
        scannedDocuments.isNotEmpty) {
      final pathStr = scannedDocuments.first.toString();
      final scannedFile = File(pathStr);

      _selectedFiles = [scannedFile];
      _fileNames = [path.basename(scannedFile.path)];
      _fileTypes = [
        path.extension(scannedFile.path).replaceFirst('.', '').toLowerCase()
      ];
      notifyListeners();

      debugPrint('File scanned: $pathStr');
    } else {
      debugPrint('Scan error or canceled: $scannedDocuments');
    }
  }

  /// اختيار ملف واحد فقط من النظام
  Future<void> pickFiles() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'png', 'jpg', 'jpeg'],
        allowMultiple: false,
      );

      if (result != null && result.paths.first != null) {
        final filePath = result.paths.first!;
        final file = File(filePath);
        final ext = path.extension(file.path).toLowerCase();

        if (['.pdf', '.png', '.jpg', '.jpeg'].contains(ext)) {
          _selectedFiles = [file];
          _fileNames = [path.basename(file.path)];
          _fileTypes = [ext.replaceFirst('.', '')];
          notifyListeners();
        } else {
          throw Exception('Unsupported file type selected');
        }
      }
    } catch (e) {
      debugPrint('Error picking file: $e');
      rethrow;
    }
  }

  void setSelectedFiles(List<File> files) {
    if (files.isNotEmpty) {
      final file = files.first;
      _selectedFiles = [file];
      _fileNames = [path.basename(file.path)];
      _fileTypes = [path.extension(file.path).replaceFirst('.', '').toLowerCase()];
      notifyListeners();
    }
  }

  void removeFileAt(int index) {
    if (index >= 0 && index < _selectedFiles.length) {
      _selectedFiles.removeAt(index);
      _fileNames.removeAt(index);
      _fileTypes.removeAt(index);
      notifyListeners();
    }
  }

  bool isImage(String filePath) {
    final extension = path.extension(filePath).toLowerCase();
    return ['.png', '.jpg', '.jpeg'].contains(extension);
  }

  bool isPdf(String filePath) {
    return path.extension(filePath).toLowerCase() == '.pdf';
  }

  void clearSelectedFiles() {
    _selectedFiles.clear();
    _fileNames.clear();
    _fileTypes.clear();
    notifyListeners();
  }
}
