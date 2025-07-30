import 'package:freezed_annotation/freezed_annotation.dart';
part 'recipient_model.freezed.dart';
part 'recipient_model.g.dart';

enum RecipientRole {NEEDS_TO_SIGN, IN_PERSON_SIGNER, RECEIVES_COPY }

@freezed
class Recipient with _$Recipient {
  const factory Recipient({
    required String id,
    required String name,
    required String document_id,
    required String user_email, 
    required RecipientRole role,
    DateTime? assignedAt,
    String? addedBy,
  }) = _Recipient;

  factory Recipient.fromJson(Map<String, dynamic> json) => _$RecipientFromJson(json);
}
