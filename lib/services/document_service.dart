import 'dart:io';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/document/document_model.dart';

class DocumentService {
  final _client = Supabase.instance.client;

Future<List<Document>> fetchPendingDocuments(String userId) async {
  final data = await _client.rpc('get_pending_documents', params: {
    'p_user_id': userId,
  });

  if (data == null) {
    throw Exception('Failed to load documents');
  }

  return (data as List)
      .map((doc) => Document.fromJson(doc as Map<String, dynamic>))
      .toList();
}


  Future<Document?> getDocumentById(String id) async {
    final response = await _client
        .from('documents')
        .select()
        .eq('id', id)
        .single();

    if (response == null) return null;

    return Document.fromJson(response);
  }

  /// جلب الوثائق التي أنشأها المستخدم
  Future<List<Document>> fetchDocumentsByUser(String userId) async {
    final response = await _client
        .from('documents')
        .select()
        .eq('createdBy', userId)
        .order('createdBy', ascending: false);

    return (response as List)
        .map((doc) => Document.fromJson(doc as Map<String, dynamic>))
        .toList();
  }

Future<Document> createDocument({
  required File file,
  required String userId,
  required String type,
  required Document doc,
}) async {
  final response = await _client.from('documents').insert(doc.toJson()).select().single();

  return Document.fromJson(response);
}




  /// حذف document حسب ID
  Future<void> deleteDocument(String id) async {
    await _client.from('documents').delete().eq('id', id);
  }
  
}
