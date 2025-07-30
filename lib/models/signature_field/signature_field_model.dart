import 'package:bsign/models/signature_field/signaure_type.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'signature_field_model.freezed.dart';
part 'signature_field_model.g.dart';

@freezed
class SignatureField with _$SignatureField {
  const factory SignatureField({
    required String id,
    required String documentId,
    required String recipientId,
    required int pageNumber,
    required double x,
    required double y,
    required double width,
    required double height,
    String? value,
    required String recipientsUid,
    @Default(true) bool requiredField,
    required SignatureFieldType type,
  }) = _SignatureField;

  factory SignatureField.fromJson(Map<String, dynamic> json) =>
      _$SignatureFieldFromJson(json);
}
