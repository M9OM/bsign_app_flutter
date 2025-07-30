import 'package:bsign/providers/attachment_provider.dart';
import 'package:bsign/view/pages/document/SignatureScreenLogic.dart';
import 'package:bsign/view/pages/document/enhanced_signature_screen.dart';
import 'package:bsign/view/pages/sign/request_signatures/enhanced_add_recipient_page.dart';
import 'package:bsign/view/widgets/custom_button.dart';
import 'package:bsign/view/widgets/my_bg.dart';
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:provider/provider.dart';
import 'package:bsign/view/pages/sign/sign_document/file_list/file_list.dart'; // Import the correct SignType

// Removed duplicate enum SignType

class EnhancedFileList extends StatelessWidget {
  final String typeSign;

  const EnhancedFileList({super.key, required this.typeSign});

  @override
  Widget build(BuildContext context) {
    final attachmentProvider = Provider.of<AttachmentProvider>(context);

    return MyBackground(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            typeSign == 'request' ? 'Request Signatures' : 'Sign Document',
          ),
          backgroundColor: Colors.transparent,
        ),
        body: Column(
          children: [
            // File preview section
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: attachmentProvider.selectedFiles.length,
                itemBuilder: (context, index) {
                  final file = attachmentProvider.selectedFiles[index];
                  final fileName = attachmentProvider.fileNames[index];
                  final fileType = attachmentProvider.fileTypes[index];
                  final sizeInBytes = file.lengthSync();
                  final sizeInKB = sizeInBytes / 1024;
                  final sizeInMB = sizeInKB / 1024;

                  final fileSizeFormatted = sizeInMB >= 1
                      ? '${sizeInMB.toStringAsFixed(2)} MB'
                      : '${sizeInKB.toStringAsFixed(2)} KB';

                  IconData icon;
                  Color iconColor;
                  
                  if (fileType == 'pdf') {
                    icon = HugeIcons.strokeRoundedPdf01;
                    iconColor = Colors.red;
                  } else if (['png', 'jpg', 'jpeg'].contains(fileType)) {
                    icon = HugeIcons.strokeRoundedImage01;
                    iconColor = Colors.blue;
                  } else {
                    icon = HugeIcons.strokeRoundedFile01;
                    iconColor = Colors.grey;
                  }

                  return Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 2,
                        color: Colors.grey.withOpacity(0.3),
                      ),
                      color: Colors.grey.withOpacity(0.05),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        // File icon and info
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: iconColor.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Icon(
                                icon,
                                color: iconColor,
                                size: 32,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    fileName,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    "$fileSizeFormatted • ${fileType.toUpperCase()}",
                                    style: TextStyle(
                                      color: Colors.grey[600],
                                      fontSize: 14,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.green.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: const Text(
                                      'Ready to process',
                                      style: TextStyle(
                                        color: Colors.green,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                attachmentProvider.removeFileAt(index);
                                if (attachmentProvider.selectedFiles.isEmpty) {
                                  Navigator.pop(context);
                                }
                              },
                              icon: const Icon(
                                HugeIcons.strokeRoundedDelete01,
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ),
                        
                        // File details
                        const SizedBox(height: 16),
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor.withOpacity(0.05),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                HugeIcons.strokeRoundedInformationCircle,
                                color: Theme.of(context).primaryColor,
                                size: 16,
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  typeSign == 'request'
                                      ? 'You can add signature fields and send this document to recipients for signing.'
                                      : 'You can add your signature and other required fields to this document.',
                                  style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            
            // Action buttons section
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                border: Border(
                  top: BorderSide(color: Colors.grey.withOpacity(0.3)),
                ),
              ),
              child: Column(
                children: [
                  if (typeSign == 'request') ...[
                    Row(
                      children: [
                        Icon(
                          HugeIcons.strokeRoundedUserGroup,
                          color: Theme.of(context).primaryColor,
                        ),
                        const SizedBox(width: 8),
                        const Text(
                          'Next: Add recipients who need to sign',
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                  ],
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: CustomButton(
                      onPressed: () {
                        if (typeSign == 'request') {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => ChangeNotifierProvider(
                                create: (_) => SignatureScreenProvider(
                                  type: SignType.requestSign,
                                ),
                                child: const EnhancedAddRecipientScreen(),
                              ),
                            ),
                          );
                        } else {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => ChangeNotifierProvider(
                                create: (_) => SignatureScreenProvider(
                                  type: SignType.selfSign,
                                ),
                                child: const EnhancedSignatureScreen(),
                              ),
                            ),
                          );
                        }
                      },
                      label: typeSign == 'request' 
                          ? 'Add Recipients' 
                          : 'Add Signature Fields',
                      color: Theme.of(context).primaryColor,
                      isLoading: false,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}