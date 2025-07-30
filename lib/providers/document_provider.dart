import 'dart:io';

import 'package:bsign/view/pages/document/doc_view.dart';
import 'package:flutter/material.dart';
import 'package:bsign/models/document/document_model.dart';
import 'package:bsign/services/document_service.dart';

class DocumentProvider with ChangeNotifier {
  final DocumentService _service = DocumentService();

  List<Document> _documents = [];
  List<Document> get documents => _documents;

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  Document? _currentDocument;
  bool _isUploading = false;
  Document? get currentDocument => _currentDocument;
  bool get isUploading => _isUploading;


Widget getDocumentPage(Document doc) {
  return DocumentViewScreen(
    documentId: doc.id!,
    filePath: doc.fileUrl, // هذا الرابط المباشر من Supabase
    totalPages: doc.pages,
  );
}
  Future<void> loadDocuments(String ownerId) async {
    _isLoading = true;
    notifyListeners();

    try {
      _documents = await _service.fetchPendingDocuments(ownerId);
    } catch (e) {
      debugPrint('Error loading documents: $e');
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> createDocument({
    required File file,
    required String userId,
    required String type,
    required Document doc,
  }) async {
    try {
      _isUploading = true;
      notifyListeners();

      _currentDocument = await _service.createDocument(
        file: file,
        userId: userId,
        type: type,
        doc: doc,
      );
    } catch (e) {
      debugPrint('خطأ أثناء رفع الملف: $e');
      rethrow;
    } finally {
      _isUploading = false;
      notifyListeners();
    }
  }

}
