import 'package:bsign/models/document_status/document_status_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

class DocumentStatusService {
  final client = Supabase.instance.client;
  final _uuid = const Uuid();

  Future<void> createDocumentStatus({
    required String documentId,
    required String createdBy,
    DateTime? expiresAt,
  }) async {
    final status = DocumentStatusModel(
      id: _uuid.v4(),
      documentId: documentId,
      status: DocumentStatus.draft,
      createdAt: DateTime.now().toUtc(),
      createdBy: createdBy,
      expiresAt: expiresAt,
      totalRecipients: 0,
      signedCount: 0,
      pendingCount: 0,
    );

    await client.from('doc_status').insert(status.toJson());
  }

  Future<void> updateDocumentStatus({
    required String documentId,
    required DocumentStatus status,
    DateTime? sentAt,
    DateTime? completedAt,
  }) async {
    final updateData = <String, dynamic>{
      'status': status.name,
      'updated_at': DateTime.now().toUtc().toIso8601String(),
    };

    if (sentAt != null) updateData['sentAt'] = sentAt.toIso8601String();
    if (completedAt != null) updateData['completedAt'] = completedAt.toIso8601String();

    await client
        .from('doc_status')
        .update(updateData)
        .eq('documentId', documentId);
  }

  Future<DocumentStatusModel?> getDocumentStatus(String documentId) async {
    final response = await client
        .from('doc_status')
        .select()
        .eq('documentId', documentId)
        .maybeSingle();

    if (response == null) return null;
    return DocumentStatusModel.fromJson(response);
  }

  Future<void> createRecipientStatus({
    required String documentId,
    required String recipientEmail,
    required String recipientName,
    required String accessToken,
    required DateTime tokenExpiresAt,
  }) async {
    final status = RecipientStatus(
      id: _uuid.v4(),
      documentId: documentId,
      recipientEmail: recipientEmail,
      recipientName: recipientName,
      status: SigningStatus.pending,
      sentAt: DateTime.now().toUtc(),
      accessToken: accessToken,
      tokenExpiresAt: tokenExpiresAt,
    );

    await client.from('recipient_status_tracking').insert(status.toJson());
  }

  Future<void> updateRecipientStatus({
    required String documentId,
    required String recipientEmail,
    required SigningStatus status,
    DateTime? viewedAt,
    DateTime? signedAt,
    String? declineReason,
  }) async {
    final updateData = <String, dynamic>{
      'status': status.name,
      'updated_at': DateTime.now().toUtc().toIso8601String(),
    };

    if (viewedAt != null) updateData['viewedAt'] = viewedAt.toIso8601String();
    if (signedAt != null) updateData['signedAt'] = signedAt.toIso8601String();
    if (declineReason != null) updateData['declineReason'] = declineReason;

    await client
        .from('recipient_status_tracking')
        .update(updateData)
        .eq('documentId', documentId)
        .eq('recipientEmail', recipientEmail);
  }

  Future<List<RecipientStatus>> getDocumentRecipientStatuses(String documentId) async {
    final response = await client
        .from('recipient_status_tracking')
        .select()
        .eq('documentId', documentId)
        .order('sentAt', ascending: true);

    return (response as List)
        .map((status) => RecipientStatus.fromJson(status as Map<String, dynamic>))
        .toList();
  }

  Future<RecipientStatus?> getRecipientStatus({
    required String documentId,
    required String recipientEmail,
  }) async {
    final response = await client
        .from('recipient_status_tracking')
        .select()
        .eq('documentId', documentId)
        .eq('recipientEmail', recipientEmail)
        .maybeSingle();

    if (response == null) return null;
    return RecipientStatus.fromJson(response);
  }

  Future<void> updateDocumentCounts(String documentId) async {
    // Get all recipient statuses for this document
    final recipients = await getDocumentRecipientStatuses(documentId);
    
    final totalRecipients = recipients.length;
    final signedCount = recipients.where((r) => r.status == SigningStatus.signed).length;
    final pendingCount = recipients.where((r) => r.status == SigningStatus.pending).length;

    // Update document status counts
    await client
        .from('doc_status')
        .update({
          'totalRecipients': totalRecipients,
          'signedCount': signedCount,
          'pendingCount': pendingCount,
          'updated_at': DateTime.now().toUtc().toIso8601String(),
        })
        .eq('documentId', documentId);

    // If all recipients have signed, mark document as completed
    if (signedCount == totalRecipients && totalRecipients > 0) {
      await updateDocumentStatus(
        documentId: documentId,
        status: DocumentStatus.completed,
        completedAt: DateTime.now().toUtc(),
      );
    }
  }
}