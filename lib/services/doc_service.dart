// import 'dart:io';
// import 'package:bsign/core/config/constants.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';
// import 'package:uuid/uuid.dart';
// import '../models/document_model.dart';
// import '../models/signature_request_model.dart';

// class DocumentService {
//   final SupabaseClient _supabase = Supabase.instance.client;
//   final _uuid = const Uuid();












//   Future<List<DocumentModel>> getUserDocuments(String userId) async {
//     final response = await _supabase
//         .from(AppConstants.documentsTable)
//         .select()
//         .eq('owner_id', userId)
//         .order('updated_at', ascending: false);
//     return response.map<DocumentModel>((doc) => DocumentModel.fromJson(doc)).toList();
//   }

//   Future<List<SignatureRequestModel>> getIncomingRequests(String email) async {
//     final response = await _supabase
//         .from(AppConstants.signatureRequestsTable)
//         .select()
//         .eq('recipient_email', email)
//         .order('created_at', ascending: false);
//     return response.map<SignatureRequestModel>((e) => SignatureRequestModel.fromJson(e)).toList();
//   }

//   Future<List<SignatureRequestModel>> getOutgoingRequests(String userId) async {
//     final response = await _supabase
//         .from(AppConstants.signatureRequestsTable)
//         .select()
//         .eq('sender_id', userId)
//         .order('created_at', ascending: false);
//     return response.map<SignatureRequestModel>((e) => SignatureRequestModel.fromJson(e)).toList();
//   }

//   Future<DocumentModel> uploadDocument(File file, String userId, String title, {
//     String? description,
//     String documentType = AppConstants.typeOther,
//     List<String> tags = const [],
//     bool isTemplate = false,
//   }) async {
//     final documentId = _uuid.v4();
//     final fileExtension = file.path.split('.').last;
//     final fileName = '$documentId.$fileExtension';

//     await _supabase.storage.from('documents').upload(
//       'user_$userId/$fileName',
//       file,
//       fileOptions: const FileOptions(cacheControl: '3600', upsert: false),
//     );

//     final fileUrl = _supabase.storage.from('documents').getPublicUrl('user_$userId/$fileName');

//     final document = DocumentModel(
//       id: documentId,
//       ownerId: userId,
//       title: title,
//       description: description,
//       fileUrl: fileUrl,
//       status: AppConstants.statusDraft,
//       documentType: documentType,
//       tags: tags,
//       createdAt: DateTime.now(),
//       updatedAt: DateTime.now(),
//       isTemplate: isTemplate,
//     );

//     await _supabase.from(AppConstants.documentsTable).insert(document.toJson());

//     return document;
//   }

//   // Other service methods for deleteDocument, updateDocument, sendSignatureRequest, etc.
// }
