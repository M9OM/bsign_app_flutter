import 'package:bsign/models/recipient/recipient_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class RecipientService {
  final _client = Supabase.instance.client;

  Future<void> addRecipient(Recipient recipient) async {
    await _client.from('recipients').insert(recipient.toJson());
  }

  Future<List<Recipient>> fetchRecipientsForSession(String sessionId) async {
    final response = await _client
        .from('signing_session_recipients')
        .select('recipient_id, recipients(*)')
        .eq('session_id', sessionId);

    return (response as List)
        .map((e) => Recipient.fromJson(e['recipients']))
        .toList();
  }
}
