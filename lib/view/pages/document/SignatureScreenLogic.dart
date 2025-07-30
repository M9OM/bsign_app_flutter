import 'package:bsign/view/pages/sign/sign_document/file_list/file_list.dart';
import 'package:flutter/material.dart';
import 'package:pdfx/pdfx.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';
import 'package:bsign/models/document/document_model.dart';
import 'package:bsign/models/recipient/recipient_model.dart';
import 'package:bsign/models/signature_field/signaure_type.dart';
import 'package:bsign/models/signature_field/signature_field_model.dart';
import 'package:bsign/providers/attachment_provider.dart';
import 'package:bsign/providers/document_provider.dart';
import 'package:bsign/providers/signature_field_provider.dart';
import 'package:bsign/services/recipient_service.dart';

class SignatureScreenProvider extends ChangeNotifier {
  SignType type = SignType.selfSign;

  SignatureScreenProvider({required this.type});

  PdfControllerPinch? pdfController;
  int _currentPageIndex = 0;
  int get currentPageIndex => _currentPageIndex;
  set currentPageIndex(int value) {
    _currentPageIndex = value;
    notifyListeners();
  }
String? emailSelected;

void selectRecipient(String email) {
  emailSelected = email;
  notifyListeners();
}

  int totalPages = 0;
  bool isLoading = false;
  bool fileUploaded = false;
  String? _documentId;

  List<SignatureField> fields = [];
  List<SignatureField> pendingFields = [];

  /// NEW: Local recipients list
  final List<Recipient> recipients = [];

  /// NEW: Add recipient to local list
  void addRecipientLocally(Recipient recipient) {
    recipients.add(recipient);
    notifyListeners();
  }

  Future<void> initialize(BuildContext context) async {
    final attachmentProvider = Provider.of<AttachmentProvider>(context, listen: false);
    if (attachmentProvider.selectedFiles.isEmpty) return;

    final file = attachmentProvider.selectedFiles.first;
    isLoading = true;
    notifyListeners();
    try {
      if (attachmentProvider.isPdf(file.path)) {
        final doc = await PdfDocument.openFile(file.path);
        pdfController?.dispose();
        pdfController = PdfControllerPinch(document: Future.value(doc));
        totalPages = doc.pagesCount;
      }
    } catch (e) {
      debugPrint('Error loading: $e');
    }
    isLoading = false;
    notifyListeners();
  }

  Future<void> uploadFile(BuildContext context) async {
    final attachmentProvider = Provider.of<AttachmentProvider>(context, listen: false);
    final docProvider = Provider.of<DocumentProvider>(context, listen: false);
    final signatureFieldProvider = Provider.of<SignatureFieldProvider>(context, listen: false);

    if (attachmentProvider.selectedFiles.isEmpty || fileUploaded) return;
    final file = attachmentProvider.selectedFiles.first;

    try {
      isLoading = true;
      notifyListeners();

      final currentUser = Supabase.instance.client.auth.currentUser;
      if (currentUser == null) throw Exception('User not authenticated');

      final userId = currentUser.id;
      final documentId = Uuid().v7();
      _documentId = documentId;

      final fileName = 'docs/${DateTime.now().millisecondsSinceEpoch}_${file.path.split('/').last}';
      final fileBytes = await file.readAsBytes();

      final storageResponse = await Supabase.instance.client.storage
          .from('documents')
          .uploadBinary(fileName, fileBytes, fileOptions: const FileOptions(upsert: true));
      if (storageResponse.isEmpty) throw Exception("Failed to upload file");

      final fileUrl = Supabase.instance.client.storage
          .from('documents')
          .getPublicUrl(fileName);

      final newDoc = Document(
        id: documentId,
        name: file.path.split('/').last,
        pages: totalPages,
        uploadedAt: DateTime.now().toUtc(),
        fileUrl: fileUrl,
        createdBy: userId,
      );

      await docProvider.createDocument(file: file, userId: userId, type: 'pdf', doc: newDoc);

      /// Upload all recipients
      for (final recipient in recipients) {
        final recipientWithId = recipient.copyWith(
          id: Uuid().v6(),
          addedBy: userId,
          user_email: recipient.user_email.isEmpty ? (currentUser.email ?? '') : recipient.user_email,
        );
        await RecipientService().addRecipient(recipientWithId);

        // /// Add related fields for this recipient
        // for (final field in pendingFields.where((f) => f.recipientsUid == recipient.recipientsUid)) {
        //   await signatureFieldProvider.addField(
        //     field.copyWith(documentId: documentId, recipientId: recipientWithId.id),
        //   );
        // }
      }

      pendingFields.clear();
      fileUploaded = true;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('تم رفع الملف والتواقيع بنجاح')),
      );
    } catch (e) {
      debugPrint('Error uploading: $e');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('خطأ: $e')));
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadSignatureFields(BuildContext context) async {
    if (_documentId == null) return;
    final signatureFieldProvider = Provider.of<SignatureFieldProvider>(context, listen: false);
    await signatureFieldProvider.loadFields(_documentId!);
    fields = signatureFieldProvider.fields;
    notifyListeners();
  }

  void updateField(SignatureField updatedField) {
    final index = pendingFields.indexWhere((f) => f.id == updatedField.id);
    if (index != -1) pendingFields[index] = updatedField;
    notifyListeners();
  }

  Future<void> addField(SignatureFieldType fieldType, double pageWidth, double pageHeight) async {
    const double defaultWidth = 100;
    const double defaultHeight = 40;

    final double xInPercent = (pageWidth / 2 - defaultWidth / 2) / pageWidth;
    final double yInPercent = (pageHeight / 2 - defaultHeight / 2) / pageHeight;

    final double widthInPercent = defaultWidth / pageWidth;
    final double heightInPercent = defaultHeight / pageHeight;

    final currentUser = Supabase.instance.client.auth.currentUser;
    if (currentUser == null) return;

    String? value;
    if (type == SignType.selfSign) {
      switch (fieldType) {
        case SignatureFieldType.name:
          value = currentUser.userMetadata?['name'] ?? currentUser.email;
          break;
        case SignatureFieldType.text:
          value = currentUser.email;
          break;
        default:
          value = null;
      }
    }

    final field = SignatureField(
      id: Uuid().v6(),
      documentId: '',
      recipientId: '',
      pageNumber: currentPageIndex,
      x: xInPercent,
      y: yInPercent,
      value: value,
      width: widthInPercent,
      height: heightInPercent,
      requiredField: true,
      type: fieldType,
      recipientsUid: currentUser.id,
    );

    pendingFields.add(field);
    notifyListeners();
  }

  List<SignatureField> getCurrentPageFields() {
    return [
      ...fields.where((f) => f.pageNumber == currentPageIndex),
      ...pendingFields.where((f) => f.pageNumber == currentPageIndex),
    ];
  }

  void disposeController() {
    pdfController?.dispose();
  }
}
