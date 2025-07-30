import 'dart:typed_data';
import 'package:bsign/models/audit_log/audit_log_model.dart';
import 'package:bsign/models/document_status/document_status_model.dart';
import 'package:bsign/models/signature_field/signature_field_model.dart';
import 'package:bsign/services/audit_service.dart';
import 'package:bsign/services/document_status_service.dart';
import 'package:bsign/services/pdf_processing_service.dart';
import 'package:bsign/services/signature_field_service.dart';
import 'package:bsign/view/widgets/pdf_viewr/pdf_viewer.dart';
import 'package:bsign/view/widgets/signature_pad.dart';
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:pdfx/pdfx.dart';
import 'package:http/http.dart' as http;
import 'package:signature/signature.dart';

class RecipientSigningPage extends StatefulWidget {
  final String documentId;
  final String recipientEmail;
  final String accessToken;

  const RecipientSigningPage({
    super.key,
    required this.documentId,
    required this.recipientEmail,
    required this.accessToken,
  });

  @override
  State<RecipientSigningPage> createState() => _RecipientSigningPageState();
}

class _RecipientSigningPageState extends State<RecipientSigningPage> {
  late PdfControllerPinch _pdfController;
  final DocumentStatusService _statusService = DocumentStatusService();
  final AuditService _auditService = AuditService();
  final SignatureFieldService _fieldService = SignatureFieldService();
  final PdfProcessingService _pdfService = PdfProcessingService();

  List<SignatureField> _allFields = [];
  List<SignatureField> _myFields = [];
  int _currentPageIndex = 0;
  bool _loading = true;
  bool _signing = false;
  RecipientStatus? _recipientStatus;
  
  final SignatureController _signatureController = SignatureController(
    penStrokeWidth: 3,
    penColor: Colors.black,
    exportBackgroundColor: Colors.transparent,
  );

  @override
  void initState() {
    super.initState();
    _initializePage();
  }

  Future<void> _initializePage() async {
    try {
      // Verify access token and get recipient status
      _recipientStatus = await _statusService.getRecipientStatus(
        documentId: widget.documentId,
        recipientEmail: widget.recipientEmail,
      );

      if (_recipientStatus == null || 
          _recipientStatus!.accessToken != widget.accessToken ||
          _recipientStatus!.tokenExpiresAt!.isBefore(DateTime.now())) {
        throw Exception('Invalid or expired access token');
      }

      // Load document and fields
      await _loadDocument();
      await _loadSignatureFields();

      // Mark as viewed if first time
      if (_recipientStatus!.status == SigningStatus.pending) {
        await _statusService.updateRecipientStatus(
          documentId: widget.documentId,
          recipientEmail: widget.recipientEmail,
          status: SigningStatus.viewed,
          viewedAt: DateTime.now().toUtc(),
        );

        await _auditService.logAction(
          documentId: widget.documentId,
          action: AuditAction.document_viewed,
          userId: widget.recipientEmail,
          recipientEmail: widget.recipientEmail,
        );
      }

      setState(() => _loading = false);
    } catch (e) {
      setState(() => _loading = false);
      _showError('Error loading document: $e');
    }
  }

  Future<void> _loadDocument() async {
    // Get document info from database
    final docResponse = await _statusService.client
        .from('documents')
        .select()
        .eq('id', widget.documentId)
        .single();

    final fileUrl = docResponse['fileUrl'] as String;

    // Download and load PDF
    final response = await http.get(Uri.parse(fileUrl));
    if (response.statusCode == 200) {
      final bytes = response.bodyBytes;
      final doc = await PdfDocument.openData(bytes);
      _pdfController = PdfControllerPinch(document: Future.value(doc));
    } else {
      throw Exception('Failed to load PDF');
    }
  }

  Future<void> _loadSignatureFields() async {
    _allFields = await _fieldService.getFieldsForDocument(widget.documentId);
    
    // Filter fields assigned to this recipient
    _myFields = _allFields
        .where((field) => field.recipientsUid == widget.recipientEmail)
        .toList();
  }

  Future<void> _showSignatureDialog(SignatureField field) async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Signature'),
        content: SizedBox(
          width: 300,
          height: 200,
          child: Signature(
            controller: _signatureController,
            backgroundColor: Colors.grey[100]!,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              _signatureController.clear();
              Navigator.pop(context);
            },
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              if (_signatureController.isNotEmpty) {
                final signature = await _signatureController.toPngBytes();
                if (signature != null) {
                  // Save signature and update field
                  await _saveSignature(field, signature);
                  Navigator.pop(context);
                }
              }
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  Future<void> _saveSignature(SignatureField field, Uint8List signatureBytes) async {
    try {
      // Upload signature to storage
      final fileName = 'signatures/${field.id}_${DateTime.now().millisecondsSinceEpoch}.png';
      await _statusService.client.storage
          .from('signatures')
          .uploadBinary(fileName, signatureBytes);

      final signatureUrl = _statusService.client.storage
          .from('signatures')
          .getPublicUrl(fileName);

      // Update field with signature URL
      final updatedField = field.copyWith(value: signatureUrl);
      await _fieldService.updateField(updatedField);

      // Update local state
      final index = _myFields.indexWhere((f) => f.id == field.id);
      if (index != -1) {
        setState(() {
          _myFields[index] = updatedField;
        });
      }

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Signature added successfully')),
      );
    } catch (e) {
      _showError('Error saving signature: $e');
    }
  }

  Future<void> _completeSigning() async {
    // Check if all required fields are filled
    final unfilledFields = _myFields.where((f) => 
        f.requiredField && (f.value == null || f.value!.isEmpty)).toList();

    if (unfilledFields.isNotEmpty) {
      _showError('Please complete all required fields before signing');
      return;
    }

    setState(() => _signing = true);

    try {
      // Update recipient status to signed
      await _statusService.updateRecipientStatus(
        documentId: widget.documentId,
        recipientEmail: widget.recipientEmail,
        status: SigningStatus.signed,
        signedAt: DateTime.now().toUtc(),
      );

      // Log signing action
      await _auditService.logAction(
        documentId: widget.documentId,
        action: AuditAction.document_signed,
        userId: widget.recipientEmail,
        recipientEmail: widget.recipientEmail,
      );

      // Update document counts
      await _statusService.updateDocumentCounts(widget.documentId);

      // Show success message
      await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
          title: const Row(
            children: [
              Icon(Icons.check_circle, color: Colors.green),
              SizedBox(width: 8),
              Text('Document Signed'),
            ],
          ),
          content: const Text(
            'Thank you! Your signature has been successfully added to the document. '
            'You will receive a copy of the completed document via email.',
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop(); // Exit signing page
              },
              child: const Text('Done'),
            ),
          ],
        ),
      );
    } catch (e) {
      _showError('Error completing signature: $e');
    } finally {
      setState(() => _signing = false);
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final currentPageFields = _myFields
        .where((field) => field.pageNumber == _currentPageIndex)
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Document'),
        actions: [
          if (_myFields.isNotEmpty)
            ElevatedButton.icon(
              onPressed: _signing ? null : _completeSigning,
              icon: _signing 
                  ? const SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Icon(HugeIcons.strokeRoundedEdit01),
              label: Text(_signing ? 'Signing...' : 'Complete Signing'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
              ),
            ),
        ],
      ),
      body: Column(
        children: [
          // Progress indicator
          if (_myFields.isNotEmpty)
            Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Your Signature Fields: ${_myFields.where((f) => f.value != null && f.value!.isNotEmpty).length}/${_myFields.length} completed',
                    style: const TextStyle(fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 8),
                  LinearProgressIndicator(
                    value: _myFields.isEmpty ? 0 : 
                        _myFields.where((f) => f.value != null && f.value!.isNotEmpty).length / _myFields.length,
                    backgroundColor: Colors.grey[300],
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Theme.of(context).primaryColor,
                    ),
                  ),
                ],
              ),
            ),

          // PDF Viewer
          Expanded(
            child: PdfDocumentViewer(
              pdfController: _pdfController,
              currentPage: _currentPageIndex,
              pageFields: currentPageFields,
              editable: true,
              onFieldMoved: (field) async {
                await _fieldService.updateField(field);
                final index = _myFields.indexWhere((f) => f.id == field.id);
                if (index != -1) {
                  setState(() {
                    _myFields[index] = field;
                  });
                }
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: _currentPageIndex > 0
                  ? () => setState(() => _currentPageIndex--)
                  : null,
            ),
            Text('Page ${_currentPageIndex + 1}'),
            IconButton(
              icon: const Icon(Icons.arrow_forward),
              onPressed: () => setState(() => _currentPageIndex++),
            ),
          ],
        ),
      ),
      floatingActionButton: currentPageFields.isNotEmpty
          ? FloatingActionButton.extended(
              onPressed: () {
                final unfilledField = currentPageFields
                    .firstWhere((f) => f.value == null || f.value!.isEmpty);
                _showSignatureDialog(unfilledField);
              },
              icon: const Icon(HugeIcons.strokeRoundedEdit01),
              label: const Text('Add Signature'),
            )
          : null,
    );
  }

  @override
  void dispose() {
    _signatureController.dispose();
    super.dispose();
  }
}