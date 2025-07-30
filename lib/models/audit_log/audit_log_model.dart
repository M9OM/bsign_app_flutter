import 'package:freezed_annotation/freezed_annotation.dart';
part 'audit_log_model.freezed.dart';
part 'audit_log_model.g.dart';

enum AuditAction {
  document_uploaded,
  document_sent,
  document_viewed,
  document_signed,
  document_completed,
  signature_added,
  recipient_added,
  email_sent,
  link_accessed,
}

@freezed
class AuditLog with _$AuditLog {
  const factory AuditLog({
    required String id,
    required String documentId,
    required AuditAction action,
    required String userId,
    String? recipientEmail,
    String? ipAddress,
    String? userAgent,
    Map<String, dynamic>? metadata,
    required DateTime timestamp,
  }) = _AuditLog;

  factory AuditLog.fromJson(Map<String, dynamic> json) => _$AuditLogFromJson(json);
}