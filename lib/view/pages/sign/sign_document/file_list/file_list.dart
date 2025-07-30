import 'package:bsign/providers/attachment_provider.dart';
import 'package:bsign/view/pages/document/SignatureScreenLogic.dart';
import 'package:bsign/view/pages/document/signature_screen.dart';
import 'package:bsign/view/pages/sign/request_signatures/add_recipient_page.dart';
import 'package:bsign/view/widgets/custom_button.dart';
import 'package:bsign/view/widgets/my_bg.dart';
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:provider/provider.dart';

enum SignType { selfSign, requestSign }

class FileList extends StatelessWidget {
  final String typeSign;

  const FileList({super.key, required this.typeSign});

  @override
  Widget build(BuildContext context) {
    final attachmentProvider = Provider.of<AttachmentProvider>(context);

    return MyBackground(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Document Files'),
          backgroundColor: Colors.transparent,
        ),
        body: ListView.builder(
          padding: const EdgeInsets.all(12),
          itemCount: attachmentProvider.selectedFiles.length,
          itemBuilder: (BuildContext context, int index) {
            final file = attachmentProvider.selectedFiles[index];
            final fileName = attachmentProvider.fileNames[index];
            final fileType = attachmentProvider.fileTypes[index];
            final sizeInBytes = file.lengthSync();
            final sizeInKB = sizeInBytes / 1024;
            final sizeInMB = sizeInKB / 1024;

            final fileSizeFormatted =
                sizeInMB >= 1
                    ? '${sizeInMB.toStringAsFixed(2)} MB'
                    : '${sizeInKB.toStringAsFixed(2)} KB';

            IconData icon;
            if (fileType == 'pdf') {
              icon = HugeIcons.strokeRoundedPdf01;
            } else if (['png', 'jpg', 'jpeg'].contains(fileType)) {
              icon = HugeIcons.strokeRoundedImage01;
            } else {
              icon = HugeIcons.strokeRoundedGoogleDrive;
            }

            return Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 2,
                      color: Colors.grey.withOpacity(0.3),
                    ),
                    color: Colors.grey.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.all(16),
                  child: Stack(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(
                            child: Icon(
                              icon,
                              color: Colors.red,
                              size: 60, // Increased size
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            fileName,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "$fileSizeFormatted • ${fileType.toUpperCase()}",
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 14,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                      Positioned(
                        top: 0,
                        right: 0,
                        child: GestureDetector(
                          onTap: () {
                            attachmentProvider.removeFileAt(index);
                            Navigator.pop(context);
                          },
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.red.withOpacity(0.1),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.close,
                              color: Colors.red,
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
        bottomNavigationBar: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: SizedBox(
              width: double.infinity,
              height: 50,
              child: CustomButton(
                onPressed: () {
                  if (typeSign == 'request') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (_) => ChangeNotifierProvider(
                              create:
                                  (_) => SignatureScreenProvider(
                                    type:
                                        typeSign == 'request'
                                            ? SignType.requestSign
                                            : SignType.selfSign,
                                  ),
                              child: const AddRecipientScreen(),
                            ),
                      ),
                    );
                  } else {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (_) => ChangeNotifierProvider(
                              create:
                                  (_) => SignatureScreenProvider(
                                    type:
                                        typeSign == 'request'
                                            ? SignType.requestSign
                                            : SignType.selfSign,
                                  ),
                              child: const SignatureScreen(),
                            ),
                      ),
                    );
                  }
                },
                label: 'Next',
                color: Theme.of(context).primaryColor,
                isLoading: false,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
