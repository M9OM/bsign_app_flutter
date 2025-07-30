import 'package:flutter/material.dart';
import 'package:bsign/models/signature_field/signature_field_model.dart';
import 'package:bsign/services/signature_field_service.dart';

class SignatureFieldProvider with ChangeNotifier {
  final SignatureFieldService _service = SignatureFieldService();

  List<SignatureField> _fields = [];
  List<SignatureField> get fields => _fields;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> loadFields(String documentId) async {
    _isLoading = true;
    notifyListeners();

    try {
      _fields = await _service.getFieldsForDocument(documentId);
    } catch (e) {
      debugPrint('Error loading signature fields: $e');
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> addField(SignatureField field) async {
    await _service.addSignatureField(field);
    _fields.add(field);
    notifyListeners();
  }

  Future<void> updateField(SignatureField field) async {
    await _service.updateField(field);
    final index = _fields.indexWhere((f) => f.id == field.id);
    if (index != -1) {
      _fields[index] = field;
      notifyListeners();
    }
  }

  Future<void> deleteField(String id) async {
    await _service.deleteField(id);
    _fields.removeWhere((f) => f.id == id);
    notifyListeners();
  }

  void clear() {
    _fields.clear();
    notifyListeners();
  }
}
