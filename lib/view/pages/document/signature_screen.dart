import 'package:bsign/extensions/navigator_extensions.dart';
import 'package:bsign/view/pages/home/home_page.dart';
import 'package:bsign/view/widgets/pdf_viewr/pdf_viewer.dart';
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:provider/provider.dart';
import 'package:bsign/core/config/app_color.dart';
import 'package:bsign/models/signature_field/signaure_type.dart';
import 'package:bsign/view/pages/document/SignatureScreenLogic.dart';

class SignatureScreen extends StatefulWidget {
  const SignatureScreen({super.key});

  @override
  State<SignatureScreen> createState() => _SignatureScreenState();
}

class _SignatureScreenState extends State<SignatureScreen> {
  double _pageWidth = 1;
  double _pageHeight = 1;

  @override
  void initState() {
    super.initState();
    Future.microtask(() async {
      final logic = Provider.of<SignatureScreenProvider>(
        context,
        listen: false,
      );
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
    final bytes = image?.bytes;
    _pageWidth = image?.width?.toDouble() ?? 1;
    _pageHeight = image?.height?.toDouble() ?? 1;
    await page.close();

    if (bytes != null) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final logic = Provider.of<SignatureScreenProvider>(context);
    final pageFields = logic.getCurrentPageFields();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Fields"),
        actions: [
          if (!logic.fileUploaded)
            Container(
              margin: const EdgeInsets.only(right: 16),
              child: ElevatedButton.icon(
                onPressed:
                    logic.isLoading
                        ? null
                        : () async {
                          await logic.uploadFile(context);
                          if (logic.fileUploaded) {
                            await _loadCurrentPageImage(logic);
                          }
                          navigateAndClearStack(context, HomeScreen());
                        },
                icon: const Icon(HugeIcons.strokeRoundedTelegram),
                label: const Text("Next"),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 2,
                  ),
                ),
              ),
            ),
        ],
      ),
      body: Column(
        children: [
          // ✅ Recipients list on top
          if (logic.recipients.isNotEmpty)
            SizedBox(
              height: 90,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: logic.recipients.length,
                itemBuilder: (context, index) {
                  final recipient = logic.recipients[index];
                  final isSelected =
                      logic.emailSelected == recipient.user_email;

                  return GestureDetector(
                    onTap: () => logic.selectRecipient(recipient.user_email),
                    child: Container(
                      width: 70,
                      margin: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 10,
                      ),

                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: 22,
                            child: Text(
                              recipient.name[0].toUpperCase(),
                              style: const TextStyle(fontSize: 18),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            recipient.name,
                            style: const TextStyle(fontSize: 12),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

          // ✅ PDF Viewer
          Expanded(
            child:
                logic.isLoading
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
      bottomNavigationBar: SignatureToolsBar(
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
      ),
    );
  }
}

class SignatureToolsBar extends StatelessWidget {
  final Function(SignatureFieldType) onAddField;
  final VoidCallback onPrevPage;
  final VoidCallback onNextPage;

  const SignatureToolsBar({
    super.key,
    required this.onAddField,
    required this.onPrevPage,
    required this.onNextPage,
  });

  Widget _buildToolButton(
    String label,
    IconData icon,
    SignatureFieldType type,
  ) {
    return GestureDetector(
      onTap: () => onAddField(type),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            radius: 24,
            backgroundColor: AppColors.primary.withOpacity(0.1),
            child: Icon(icon, color: AppColors.primary),
          ),
          const SizedBox(height: 6),
          Text(label, style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        // ignore: deprecated_member_use
        color: Colors.grey.withOpacity(0.1),
        border: Border(
          top: BorderSide(color: Colors.grey.withOpacity(0.3), width: 2),
        ),
      ),
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(icon: const Icon(Icons.arrow_back), onPressed: onPrevPage),
          _buildToolButton(
            'Signature',
            HugeIcons.strokeRoundedEdit01,
            SignatureFieldType.signature,
          ),
          _buildToolButton(
            'Name',
            HugeIcons.strokeRoundedUser,
            SignatureFieldType.name,
          ),
          _buildToolButton(
            'Date',
            HugeIcons.strokeRoundedDateTime,
            SignatureFieldType.date,
          ),
          _buildToolButton(
            'Text',
            HugeIcons.strokeRoundedText,
            SignatureFieldType.text,
          ),
          IconButton(
            icon: const Icon(Icons.arrow_forward),
            onPressed: onNextPage,
          ),
        ],
      ),
    );
  }
}
