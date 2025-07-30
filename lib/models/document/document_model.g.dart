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
      file_url: json['file_url'] as String,
      uploaded_at:
          json['uploaded_at'] == null
              ? null
              : DateTime.parse(json['uploaded_at'] as String),
      type: json['type'] as String?,
      created_by: json['created_by'] as String?,
    );

Map<String, dynamic> _$$DocumentImplToJson(_$DocumentImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'pages': instance.pages,
      'file_url': instance.file_url,
      'uploaded_at': instance.uploaded_at?.toIso8601String(),
      'type': instance.type,
      'created_by': instance.created_by,
    };
