// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recipient_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RecipientImpl _$$RecipientImplFromJson(Map<String, dynamic> json) =>
    _$RecipientImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      document_id: json['document_id'] as String,
      user_email: json['user_email'] as String,
      role: $enumDecode(_$RecipientRoleEnumMap, json['role']),
      assignedAt:
          json['assignedAt'] == null
              ? null
              : DateTime.parse(json['assignedAt'] as String),
      addedBy: json['addedBy'] as String?,
    );

Map<String, dynamic> _$$RecipientImplToJson(_$RecipientImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'document_id': instance.document_id,
      'user_email': instance.user_email,
      'role': _$RecipientRoleEnumMap[instance.role]!,
      'assignedAt': instance.assignedAt?.toIso8601String(),
      'addedBy': instance.addedBy,
    };

const _$RecipientRoleEnumMap = {
  RecipientRole.NEEDS_TO_SIGN: 'NEEDS_TO_SIGN',
  RecipientRole.IN_PERSON_SIGNER: 'IN_PERSON_SIGNER',
  RecipientRole.RECEIVES_COPY: 'RECEIVES_COPY',
};
