// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'audit_log_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AuditLogImpl _$$AuditLogImplFromJson(Map<String, dynamic> json) =>
    _$AuditLogImpl(
      id: json['id'] as String,
      documentId: json['documentId'] as String,
      action: $enumDecode(_$AuditActionEnumMap, json['action']),
      userId: json['userId'] as String,
      recipientEmail: json['recipientEmail'] as String?,
      ipAddress: json['ipAddress'] as String?,
      userAgent: json['userAgent'] as String?,
      metadata: json['metadata'] as Map<String, dynamic>?,
      timestamp: DateTime.parse(json['timestamp'] as String),
    );

Map<String, dynamic> _$$AuditLogImplToJson(_$AuditLogImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'documentId': instance.documentId,
      'action': _$AuditActionEnumMap[instance.action]!,
      'userId': instance.userId,
      'recipientEmail': instance.recipientEmail,
      'ipAddress': instance.ipAddress,
      'userAgent': instance.userAgent,
      'metadata': instance.metadata,
      'timestamp': instance.timestamp.toIso8601String(),
    };

const _$AuditActionEnumMap = {
  AuditAction.document_uploaded: 'document_uploaded',
  AuditAction.document_sent: 'document_sent',
  AuditAction.document_viewed: 'document_viewed',
  AuditAction.document_signed: 'document_signed',
  AuditAction.document_completed: 'document_completed',
  AuditAction.signature_added: 'signature_added',
  AuditAction.recipient_added: 'recipient_added',
  AuditAction.email_sent: 'email_sent',
  AuditAction.link_accessed: 'link_accessed',
};
