import 'package:bsign/models/audit_log/audit_log_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

class AuditService {
  final _client = Supabase.instance.client;
  final _uuid = const Uuid();

  Future<void> logAction({
    required String documentId,
    required AuditAction action,
    required String userId,
    String? recipientEmail,
    String? ipAddress,
    String? userAgent,
    Map<String, dynamic>? metadata,
  }) async {
    final auditLog = AuditLog(
      id: _uuid.v4(),
      documentId: documentId,
      action: action,
      userId: userId,
      recipientEmail: recipientEmail,
      ipAddress: ipAddress,
      userAgent: userAgent,
      metadata: metadata,
      timestamp: DateTime.now().toUtc(),
    );

    await _client.from('audit_logs').insert(auditLog.toJson());
  }

  Future<List<AuditLog>> getDocumentAuditTrail(String documentId) async {
    final response = await _client
        .from('audit_logs')
        .select()
        .eq('documentId', documentId)
        .order('timestamp', ascending: false);

    return (response as List)
        .map((log) => AuditLog.fromJson(log as Map<String, dynamic>))
        .toList();
  }

  Future<List<AuditLog>> getUserAuditTrail(String userId) async {
    final response = await _client
        .from('audit_logs')
        .select()
        .eq('userId', userId)
        .order('timestamp', ascending: false)
        .limit(100);

    return (response as List)
        .map((log) => AuditLog.fromJson(log as Map<String, dynamic>))
        .toList();
  }
}