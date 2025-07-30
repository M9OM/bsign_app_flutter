import 'package:freezed_annotation/freezed_annotation.dart';
part 'document_status_model.freezed.dart';
part 'document_status_model.g.dart';

enum DocumentStatus {
  draft,
  sent,
  in_progress,
  completed,
  expired,
  cancelled,
}

enum SigningStatus {
  pending,
  viewed,
  signed,
  declined,
  expired,
}

@freezed
class DocumentStatusModel with _$DocumentStatusModel {
  const factory DocumentStatusModel({
    required String id,
    required String documentId,
    required DocumentStatus status,
    required DateTime createdAt,
    DateTime? sentAt,
    DateTime? completedAt,
    DateTime? expiresAt,
    required String createdBy,
    int? totalRecipients,
    int? signedCount,
    int? pendingCount,
  }) = _DocumentStatusModel;

  factory DocumentStatusModel.fromJson(Map<String, dynamic> json) => 
      _$DocumentStatusModelFromJson(json);
}

@freezed
class RecipientStatus with _$RecipientStatus {
  const factory RecipientStatus({
    required String id,
    required String documentId,
    required String recipientEmail,
    required String recipientName,
    required SigningStatus status,
    DateTime? sentAt,
    DateTime? viewedAt,
    DateTime? signedAt,
    String? declineReason,
    String? accessToken,
    DateTime? tokenExpiresAt,
  }) = _RecipientStatus;

  factory RecipientStatus.fromJson(Map<String, dynamic> json) => 
      _$RecipientStatusFromJson(json);
}