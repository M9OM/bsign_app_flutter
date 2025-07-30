import 'package:bsign/models/signing_session/signing_session_model.dart';
import 'package:bsign/models/signing_session_recipient/signing_session_recipient_model.dart' show SigningSessionRecipient;
import 'package:supabase_flutter/supabase_flutter.dart';

class SigningSessionService {
  final _client = Supabase.instance.client;

  Future<void> createSession(SigningSession session) async {
    await _client.from('signing_sessions').insert(session.toJson());
  }

  Future<void> addRecipientToSession(SigningSessionRecipient link) async {
    await _client.from('signing_session_recipients').insert(link.toJson());
  }

  Future<List<SigningSession>> fetchSessionsForDocument(String documentId) async {
    final response = await _client
        .from('signing_sessions')
        .select()
        .eq('document_id', documentId);

    return (response as List)
        .map((s) => SigningSession.fromJson(s))
        .toList();
  }
}
