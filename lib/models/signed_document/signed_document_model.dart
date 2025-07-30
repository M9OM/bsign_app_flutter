import 'package:freezed_annotation/freezed_annotation.dart';
part 'signed_document_model.freezed.dart';
part 'signed_document_model.g.dart';

@freezed
class SignedDocument with _$SignedDocument {
  const factory SignedDocument({
    required String id,
    required String originalDocumentId,
    required String signedUrl,
    DateTime? completedAt,
  }) = _SignedDocument;

  factory SignedDocument.fromJson(Map<String, dynamic> json) => _$SignedDocumentFromJson(json);
}
