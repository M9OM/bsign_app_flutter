// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'signed_document_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SignedDocumentImpl _$$SignedDocumentImplFromJson(Map<String, dynamic> json) =>
    _$SignedDocumentImpl(
      id: json['id'] as String,
      originalDocumentId: json['originalDocumentId'] as String,
      signedUrl: json['signedUrl'] as String,
      completedAt:
          json['completedAt'] == null
              ? null
              : DateTime.parse(json['completedAt'] as String),
    );

Map<String, dynamic> _$$SignedDocumentImplToJson(
  _$SignedDocumentImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'originalDocumentId': instance.originalDocumentId,
  'signedUrl': instance.signedUrl,
  'completedAt': instance.completedAt?.toIso8601String(),
};
