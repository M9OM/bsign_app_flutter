// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'document_status_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DocumentStatusModelImpl _$$DocumentStatusModelImplFromJson(
  Map<String, dynamic> json,
) => _$DocumentStatusModelImpl(
  id: json['id'] as String,
  documentId: json['documentId'] as String,
  status: $enumDecode(_$DocumentStatusEnumMap, json['status']),
  createdAt: DateTime.parse(json['createdAt'] as String),
  sentAt:
      json['sentAt'] == null ? null : DateTime.parse(json['sentAt'] as String),
  completedAt:
      json['completedAt'] == null
          ? null
          : DateTime.parse(json['completedAt'] as String),
  expiresAt:
      json['expiresAt'] == null
          ? null
          : DateTime.parse(json['expiresAt'] as String),
  createdBy: json['createdBy'] as String,
  totalRecipients: (json['totalRecipients'] as num?)?.toInt(),
  signedCount: (json['signedCount'] as num?)?.toInt(),
  pendingCount: (json['pendingCount'] as num?)?.toInt(),
);

Map<String, dynamic> _$$DocumentStatusModelImplToJson(
  _$DocumentStatusModelImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'documentId': instance.documentId,
  'status': _$DocumentStatusEnumMap[instance.status]!,
  'createdAt': instance.createdAt.toIso8601String(),
  'sentAt': instance.sentAt?.toIso8601String(),
  'completedAt': instance.completedAt?.toIso8601String(),
  'expiresAt': instance.expiresAt?.toIso8601String(),
  'createdBy': instance.createdBy,
  'totalRecipients': instance.totalRecipients,
  'signedCount': instance.signedCount,
  'pendingCount': instance.pendingCount,
};

const _$DocumentStatusEnumMap = {
  DocumentStatus.draft: 'draft',
  DocumentStatus.sent: 'sent',
  DocumentStatus.in_progress: 'in_progress',
  DocumentStatus.completed: 'completed',
  DocumentStatus.expired: 'expired',
  DocumentStatus.cancelled: 'cancelled',
};

_$RecipientStatusImpl _$$RecipientStatusImplFromJson(
  Map<String, dynamic> json,
) => _$RecipientStatusImpl(
  id: json['id'] as String,
  documentId: json['documentId'] as String,
  recipientEmail: json['recipientEmail'] as String,
  recipientName: json['recipientName'] as String,
  status: $enumDecode(_$SigningStatusEnumMap, json['status']),
  sentAt:
      json['sentAt'] == null ? null : DateTime.parse(json['sentAt'] as String),
  viewedAt:
      json['viewedAt'] == null
          ? null
          : DateTime.parse(json['viewedAt'] as String),
  signedAt:
      json['signedAt'] == null
          ? null
          : DateTime.parse(json['signedAt'] as String),
  declineReason: json['declineReason'] as String?,
  accessToken: json['accessToken'] as String?,
  tokenExpiresAt:
      json['tokenExpiresAt'] == null
          ? null
          : DateTime.parse(json['tokenExpiresAt'] as String),
);

Map<String, dynamic> _$$RecipientStatusImplToJson(
  _$RecipientStatusImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'documentId': instance.documentId,
  'recipientEmail': instance.recipientEmail,
  'recipientName': instance.recipientName,
  'status': _$SigningStatusEnumMap[instance.status]!,
  'sentAt': instance.sentAt?.toIso8601String(),
  'viewedAt': instance.viewedAt?.toIso8601String(),
  'signedAt': instance.signedAt?.toIso8601String(),
  'declineReason': instance.declineReason,
  'accessToken': instance.accessToken,
  'tokenExpiresAt': instance.tokenExpiresAt?.toIso8601String(),
};

const _$SigningStatusEnumMap = {
  SigningStatus.pending: 'pending',
  SigningStatus.viewed: 'viewed',
  SigningStatus.signed: 'signed',
  SigningStatus.declined: 'declined',
  SigningStatus.expired: 'expired',
};
