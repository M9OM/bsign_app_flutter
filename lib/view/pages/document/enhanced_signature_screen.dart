import 'package:bsign/extensions/navigator_extensions.dart';
import 'package:bsign/models/audit_log/audit_log_model.dart';
import 'package:bsign/services/audit_service.dart';
import 'package:bsign/services/enhanced_email_service.dart';
import 'package:bsign/view/pages/home/home_page.dart';
import 'package:bsign/view/pages/sign/sign_document/file_list/enhanced_file_list.dart';
import 'package:bsign/view/pages/sign/sign_document/file_list/file_list.dart';
import 'package:bsign/view/widgets/pdf_viewr/pdf_viewer.dart';
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:bsign/models/signature_field/signaure_type.dart';
import 'package:bsign/view/pages/document/SignatureScreenLogic.dart';

class EnhancedSignatureScreen extends StatefulWidget {
  const EnhancedSignatureScreen({super.key});

  @override
  State<EnhancedSignatureScreen> createState() => _EnhancedSignatureScreenState();
}

class _EnhancedSignatureScreenState extends State<EnhancedSignatureScreen> {
  double _pageWidth = 1;
  double _pageHeight = 1;
  final AuditService _auditService = AuditService();
  final EnhancedEmailService _emailService = EnhancedEmailService();

  @override
  void initState() {
    super.initState();
    Future.microtask(() async {
      final logic = Provider.of<SignatureScreenProvider>(context, listen: false);
      await logic.initialize(context);
      await _loadCurrentPageImage(logic);
    });
  }

  Future<void> _loadCurrentPageImage(SignatureScreenProvider logic) async {
    final docFuture = logic.pdfController?.document;
    if (docFuture == null) return;

    final doc = await docFuture;
    final page = await doc.getPage(logic.currentPageIndex + 1);
    final image = await page.render(width: page.width, height: page.height);
    _pageWidth = image?.width?.toDouble() ?? 1;
    _pageHeight = image?.height?.toDouble() ?? 1;
    await page.close();

    if (mounted) setState(() {});
  }

  Future<void> _sendForSigning(SignatureScreenProvider logic) async {
    if (logic.recipients.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please add at least one recipient')),
      );
      return;
    }

    try {
      setState(() {});
      
      final currentUser = Supabase.instance.client.auth.currentUser;
      if (currentUser == null) throw Exception('User not authenticated');

      // Upload the document first
      await logic.uploadFile(context);
      
      if (!logic.fileUploaded || logic.documentId == null) {
        throw Exception('Failed to upload document');
      }

      // Log document sent action
      await _auditService.logAction(
        documentId: logic.documentId!,
        action: AuditAction.document_sent,
        userId: currentUser.id,
        metadata: {
          'recipientCount': logic.recipients.length,
          'fieldCount': logic.pendingFields.length,
        },
      );

      // Send email invitations
      await _emailService.sendSigningInvitation(
        documentId: logic.documentId!,
        documentName: 'Document for Signing',
        senderName: currentUser.userMetadata?['name'] ?? currentUser.email ?? 'Unknown',
        senderEmail: currentUser.email ?? '',
        recipientEmails: logic.recipients.map((r) => r.user_email).toList(),
        recipientNames: logic.recipients.map((r) => r.name).toList(),
        customMessage: 'Please review and sign this document.',
      );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Document sent successfully! Recipients will receive email invitations.'),
            backgroundColor: Colors.green,
          ),
        );
        
        navigateAndClearStack(context, HomeScreen());
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error sending document: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final logic = Provider.of<SignatureScreenProvider>(context);
    final pageFields = logic.getCurrentPageFields();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Prepare Document"),
        actions: [
          if (!logic.fileUploaded)
            Container(
              margin: const EdgeInsets.only(right: 16),
              child: ElevatedButton.icon(
                onPressed: logic.isLoading
                    ? null
                    : () async {
                        if (logic.type == SignType.selfSign) {
                          await logic.uploadFile(context);
                          if (logic.fileUploaded) {
                            navigateAndClearStack(context, HomeScreen());
                          }
                        } else {
                          await _sendForSigning(logic);
                        }
                      },
                icon: Icon(
                  logic.type == SignType.selfSign 
                      ? HugeIcons.strokeRoundedAlignVerticalCenter 
                      : HugeIcons.strokeRoundedTelegram,
                ),
                label: Text(
                  logic.type == SignType.selfSign ? "Save" : "Send for Signing",
                ),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                ),
              ),
            ),
        ],
      ),
      body: Column(
        children: [
          // Recipients list for request signing
          if (logic.type == SignType.requestSign && logic.recipients.isNotEmpty)
            Container(
              height: 90,
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      'Recipients',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Expanded(
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: logic.recipients.length,
                      itemBuilder: (context, index) {
                        final recipient = logic.recipients[index];
                        final isSelected = logic.emailSelected == recipient.user_email;

                        return GestureDetector(
                          onTap: () => logic.selectRecipient(recipient.user_email),
                          child: Container(
                            width: 70,
                            margin: const EdgeInsets.only(right: 12),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                  radius: 20,
                                  backgroundColor: isSelected 
                                      ? Theme.of(context).primaryColor 
                                      : Colors.grey.shade300,
                                  child: Text(
                                    recipient.name[0].toUpperCase(),
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: isSelected ? Colors.white : Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  recipient.name,
                                  style: const TextStyle(fontSize: 11),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),

          // PDF Viewer
          Expanded(
            child: logic.isLoading
                ? const Center(child: CircularProgressIndicator())
                : logic.pdfController == null
                    ? const Center(child: Text("No PDF loaded."))
                    : PdfDocumentViewer(
                        pdfController: logic.pdfController!,
                        currentPage: logic.currentPageIndex,
                        pageFields: pageFields,
                        editable: true,
                        onFieldMoved: (newField) {
                          logic.updateField(newField);
                          setState(() {});
                        },
                      ),
          ),
        ],
      ),
      bottomNavigationBar: EnhancedSignatureToolsBar(
        onAddField: (type) async {
          await logic.addField(type, _pageWidth, _pageHeight);
          await _loadCurrentPageImage(logic);
        },
        onPrevPage: () async {
          if (logic.currentPageIndex > 0) {
            logic.currentPageIndex--;
            await _loadCurrentPageImage(logic);
          }
        },
        onNextPage: () async {
          if (logic.currentPageIndex < logic.totalPages - 1) {
            logic.currentPageIndex++;
            await _loadCurrentPageImage(logic);
          }
        },
        currentPage: logic.currentPageIndex + 1,
        totalPages: logic.totalPages,
      ),
    );
  }
}

class EnhancedSignatureToolsBar extends StatelessWidget {
  final Function(SignatureFieldType) onAddField;
  final VoidCallback onPrevPage;
  final VoidCallback onNextPage;
  final int currentPage;
  final int totalPages;

  const EnhancedSignatureToolsBar({
    super.key,
    required this.onAddField,
    required this.onPrevPage,
    required this.onNextPage,
    required this.currentPage,
    required this.totalPages,
  });

  Widget _buildToolButton(
    String label,
    IconData icon,
    SignatureFieldType type,
    Color color,
  ) {
    return GestureDetector(
      onTap: () => onAddField(type),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            radius: 22,
            backgroundColor: color.withOpacity(0.1),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(fontSize: 11),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        border: Border(
          top: BorderSide(color: Colors.grey.withOpacity(0.3), width: 1),
        ),
      ),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Page navigation
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back_ios),
                  onPressed: currentPage > 1 ? onPrevPage : null,
                ),
                Text(
                  'Page $currentPage of $totalPages',
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
                IconButton(
                  icon: const Icon(Icons.arrow_forward_ios),
                  onPressed: currentPage < totalPages ? onNextPage : null,
                ),
              ],
            ),
            const SizedBox(height: 8),
            // Tools
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildToolButton(
                  'Signature',
                  HugeIcons.strokeRoundedEdit01,
                  SignatureFieldType.signature,
                  Colors.blue,
                ),
                _buildToolButton(
                  'Name',
                  HugeIcons.strokeRoundedUser,
                  SignatureFieldType.name,
                  Colors.green,
                ),
                _buildToolButton(
                  'Date',
                  HugeIcons.strokeRoundedDateTime,
                  SignatureFieldType.date,
                  Colors.orange,
                ),
                _buildToolButton(
                  'Text',
                  HugeIcons.strokeRoundedText,
                  SignatureFieldType.text,
                  Colors.purple,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}