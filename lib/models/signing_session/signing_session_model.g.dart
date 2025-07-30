// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'signing_session_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SigningSessionImpl _$$SigningSessionImplFromJson(Map<String, dynamic> json) =>
    _$SigningSessionImpl(
      id: json['id'] as String,
      documentId: json['documentId'] as String,
      status: $enumDecodeNullable(_$SessionStatusEnumMap, json['status']),
      createdAt:
          json['createdAt'] == null
              ? null
              : DateTime.parse(json['createdAt'] as String),
      createdBy: json['createdBy'] as String?,
    );

Map<String, dynamic> _$$SigningSessionImplToJson(
  _$SigningSessionImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'documentId': instance.documentId,
  'status': _$SessionStatusEnumMap[instance.status],
  'createdAt': instance.createdAt?.toIso8601String(),
  'createdBy': instance.createdBy,
};

const _$SessionStatusEnumMap = {
  SessionStatus.draft: 'draft',
  SessionStatus.in_progress: 'in_progress',
  SessionStatus.completed: 'completed',
};
