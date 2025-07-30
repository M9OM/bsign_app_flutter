// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'document_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DocumentImpl _$$DocumentImplFromJson(Map<String, dynamic> json) =>
    _$DocumentImpl(
      id: json['id'] as String?,
      name: json['name'] as String,
      pages: (json['pages'] as num).toInt(),
      fileUrl: json['fileUrl'] as String,
      uploadedAt:
          json['uploadedAt'] == null
              ? null
              : DateTime.parse(json['uploadedAt'] as String),
      type: json['type'] as String?,
      createdBy: json['createdBy'] as String?,
    );

Map<String, dynamic> _$$DocumentImplToJson(_$DocumentImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'pages': instance.pages,
      'fileUrl': instance.fileUrl,
      'uploadedAt': instance.uploadedAt?.toIso8601String(),
      'type': instance.type,
      'createdBy': instance.createdBy,
    };
