import 'package:freezed_annotation/freezed_annotation.dart';
part 'signing_session_model.freezed.dart';
part 'signing_session_model.g.dart';

enum SessionStatus { draft, in_progress, completed }

@freezed
class SigningSession with _$SigningSession {
  const factory SigningSession({
    required String id,
    required String documentId,
    SessionStatus? status,
    DateTime? createdAt,
    String? createdBy,
  }) = _SigningSession;

  factory SigningSession.fromJson(Map<String, dynamic> json) => _$SigningSessionFromJson(json);
}
