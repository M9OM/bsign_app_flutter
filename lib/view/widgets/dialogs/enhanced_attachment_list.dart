import 'package:bsign/providers/attachment_provider.dart';
import 'package:bsign/view/pages/sign/sign_document/file_list/enhanced_file_list.dart';
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:provider/provider.dart';

void showEnhancedAttachmentOptions(BuildContext context, String typeSign) {
  showModalBottomSheet(
    useSafeArea: true,
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) => _EnhancedAttachmentSheet(typeSign: typeSign),
  );
}

class _EnhancedAttachmentSheet extends StatelessWidget {
  final String typeSign;

  const _EnhancedAttachmentSheet({required this.typeSign});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
      height: screenHeight * 0.35,
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            children: [
              Icon(
                typeSign == 'request' 
                    ? HugeIcons.strokeRoundedUserGroup 
                    : HugeIcons.strokeRoundedEdit01,
                color: Theme.of(context).primaryColor,
              ),
              const SizedBox(width: 8),
              Text(
                typeSign == 'request' 
                    ? 'Request Signatures' 
                    : 'Sign Document',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            typeSign == 'request'
                ? 'Upload a document and send it to others for signing'
                : 'Upload a document to add your signature',
            style: const TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 20),

          // Options grid
          Expanded(
            child: GridView.count(
              padding: EdgeInsets.zero,
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 1.2,
              children: [
                _AttachmentOption(
                  icon: HugeIcons.strokeRoundedFolder01,
                  label: 'Browse Files',
                  description: 'PDF, Images',
                  color: Colors.blue,
                  onTap: () => _handleFiles(context),
                ),
                _AttachmentOption(
                  icon: HugeIcons.strokeRoundedCamera01,
                  label: 'Scan Document',
                  description: 'Use camera',
                  color: Colors.orange,
                  onTap: () => _handleScan(context),
                ),
                _AttachmentOption(
                  icon: HugeIcons.strokeRoundedImage01,
                  label: 'Photo Library',
                  description: 'Select images',
                  color: Colors.purple,
                  onTap: () => _handlePhotos(context),
                ),
                _AttachmentOption(
                  icon: HugeIcons.strokeRoundedFileAttachment,
                  label: 'Templates',
                  description: 'Coming soon',
                  color: Colors.green,
                  onTap: () => _showComingSoon(context),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _handleFiles(BuildContext context) async {
    final provider = context.read<AttachmentProvider>();
    await provider.pickFiles();

    if (provider.selectedFiles.isNotEmpty && context.mounted) {
      Navigator.pop(context);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => EnhancedFileList(typeSign: typeSign),
        ),
      );
    }
  }

  void _handleScan(BuildContext context) async {
    final provider = context.read<AttachmentProvider>();
    await provider.scanDocument();

    if (provider.selectedFiles.isNotEmpty && context.mounted) {
      Navigator.pop(context);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => EnhancedFileList(typeSign: typeSign),
        ),
      );
    }
  }

  void _handlePhotos(BuildContext context) {
    // TODO: Implement photo library picker
    _showComingSoon(context);
  }

  void _showComingSoon(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Feature coming soon!')),
    );
    Navigator.pop(context);
  }
}

class _AttachmentOption extends StatelessWidget {
  final IconData icon;
  final String label;
  final String description;
  final Color color;
  final VoidCallback? onTap;

  const _AttachmentOption({
    required this.icon,
    required this.label,
    required this.description,
    required this.color,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.withOpacity(0.2)),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 24,
              backgroundColor: color.withOpacity(0.1),
              child: Icon(icon, color: color, size: 24),
            ),
            const SizedBox(height: 12),
            Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 4),
            Text(
              description,
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 12,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}