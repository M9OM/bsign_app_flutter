import 'package:freezed_annotation/freezed_annotation.dart';
part 'document_model.freezed.dart';
part 'document_model.g.dart';

@freezed
class Document with _$Document {
  const factory Document({
     String? id,
    required String name,
    required int pages,
    required String fileUrl,
    DateTime? uploadedAt,
    String? type, // e.g., 'pdf', 'image'
    String? createdBy, // user_id
  }) = _Document;

  factory Document.fromJson(Map<String, dynamic> json) => _$DocumentFromJson(json);
}

//