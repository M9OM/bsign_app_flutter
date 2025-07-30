// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'signature_field_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SignatureFieldImpl _$$SignatureFieldImplFromJson(Map<String, dynamic> json) =>
    _$SignatureFieldImpl(
      id: json['id'] as String,
      documentId: json['documentId'] as String,
      recipientId: json['recipientId'] as String,
      pageNumber: (json['pageNumber'] as num).toInt(),
      x: (json['x'] as num).toDouble(),
      y: (json['y'] as num).toDouble(),
      width: (json['width'] as num).toDouble(),
      height: (json['height'] as num).toDouble(),
      value: json['value'] as String?,
      recipientsUid: json['recipientsUid'] as String,
      requiredField: json['requiredField'] as bool? ?? true,
      type: $enumDecode(_$SignatureFieldTypeEnumMap, json['type']),
    );

Map<String, dynamic> _$$SignatureFieldImplToJson(
  _$SignatureFieldImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'documentId': instance.documentId,
  'recipientId': instance.recipientId,
  'pageNumber': instance.pageNumber,
  'x': instance.x,
  'y': instance.y,
  'width': instance.width,
  'height': instance.height,
  'value': instance.value,
  'recipientsUid': instance.recipientsUid,
  'requiredField': instance.requiredField,
  'type': _$SignatureFieldTypeEnumMap[instance.type]!,
};

const _$SignatureFieldTypeEnumMap = {
  SignatureFieldType.signature: 'signature',
  SignatureFieldType.name: 'name',
  SignatureFieldType.date: 'date',
  SignatureFieldType.text: 'text',
};
