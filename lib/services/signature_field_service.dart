import 'package:bsign/models/signature_field/signature_field_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SignatureFieldService {
  final _client = Supabase.instance.client;

  Future<void> addSignatureField(SignatureField field) async {
    await _client.from('signature_fields').insert(field.toJson());
  }

  Future<List<SignatureField>> getFieldsForDocument(String documentId) async {
    final response = await _client
        .from('signature_fields')
        .select()
        .eq('documentId', documentId);

    return (response as List)
        .map((e) => SignatureField.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<void> deleteField(String fieldId) async {
    await _client.from('signature_fields').delete().eq('id', fieldId);
  }

  Future<void> updateField(SignatureField field) async {
    await _client
        .from('signature_fields')
        .update(field.toJson())
        .eq('id', field.id);
  }
}
