import 'package:freezed_annotation/freezed_annotation.dart';
part 'signing_session_recipient_model.freezed.dart';
part 'signing_session_recipient_model.g.dart';

@freezed
class SigningSessionRecipient with _$SigningSessionRecipient {
  const factory SigningSessionRecipient({
    required String sessionId,
    required String recipientId,
  }) = _SigningSessionRecipient;

  factory SigningSessionRecipient.fromJson(Map<String, dynamic> json) =>
      _$SigningSessionRecipientFromJson(json);
}
