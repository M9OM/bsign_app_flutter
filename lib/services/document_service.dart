import 'dart:io';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/document/document_model.dart';

class DocumentService {
  final client = Supabase.instance.client;

Future<List<Document>> fetchPendingDocuments(String userId) async {
  final data = await client.rpc('get_pending_documents', params: {
    'p_user_id': userId,
  });

  if (data == null) {
    throw Exception('Failed to load documents');
  }

  return (data as List)
      .map((doc) => Document.fromJson(doc as Map<String, dynamic>))
      .toList();
}

  Future<List<Document>> fetchUserDocuments(String userId) async {
    final data = await client.rpc('get_user_documents', params: {
      'p_user_id': userId,
    });

    if (data == null) {
      throw Exception('Failed to load user documents');
    }

    return (data as List)
        .map((doc) => Document.fromJson(doc as Map<String, dynamic>))
        .toList();
  }

  Future<Document?> getDocumentById(String id) async {
    final response = await client
        .from('documents')
        .select()
        .eq('id', id)
        .maybeSingle();

    if (response == null) return null;

    return Document.fromJson(response);
  }

  /// Get documents created by user
  Future<List<Document>> fetchDocumentsByUser(String userId) async {
    final response = await client
        .from('documents')
        .select()
        .eq('created_by', userId)
        .order('uploaded_at', ascending: false);

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
  // Upload file to Supabase Storage first
  final fileName = 'docs/${DateTime.now().millisecondsSinceEpoch}_${doc.name}';
  final fileBytes = await file.readAsBytes();
  
  await client.storage
      .from('documents')
      .uploadBinary(fileName, fileBytes, fileOptions: const FileOptions(upsert: true));
  
  final fileUrl = client.storage
      .from('documents')
      .getPublicUrl(fileName);
  
  // Create document record with file URL
  final documentData = {
    'id': doc.id,
    'name': doc.name,
    'pages': doc.pages,
    'file_url': fileUrl,
    'uploaded_at': DateTime.now().toUtc().toIso8601String(),
    'file_type': type,
    'created_by': userId,
  };
  
  final response = await client.from('documents').insert(documentData).select().single();

  return Document.fromJson(response);
}




  /// Delete document by ID
  Future<void> deleteDocument(String id) async {
    await client.from('documents').delete().eq('id', id);
  }
  
}
