import 'package:bsign/providers/attachment_provider.dart';
import 'package:bsign/view/pages/sign/sign_document/file_list/file_list.dart';
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:provider/provider.dart';

void showAttachmentOptions(BuildContext context, String typeSign) {
  showModalBottomSheet(
    useSafeArea: true,
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) => _AttachmentSheet(typeSign: typeSign),
  );
}

class _AttachmentSheet extends StatelessWidget {
  final String typeSign;

  const _AttachmentSheet({required this.typeSign});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return SizedBox(
      height: screenHeight * 0.22,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Add Documents',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: GridView.count(
                padding: EdgeInsets.zero,
                crossAxisCount: 4,
                crossAxisSpacing: 5,
                mainAxisSpacing: 5,
                children: [
                  _AttachmentOption(
                    icon: HugeIcons.strokeRoundedFolder01,
                    label: 'Files',
                    color: Colors.blue,
                    onTap: () => _handleFiles(context),
                  ),
                  _AttachmentOption(
                    icon: HugeIcons.strokeRoundedImage01,
                    label: 'Photos',
                    color: Colors.deepPurple,
                    onTap: () {
                      // TODO: implement photo picker if needed
                    },
                  ),
                  _AttachmentOption(
                    icon: HugeIcons.strokeRoundedSquare,
                    label: 'Scan',
                    color: Colors.orange,
                    onTap: () => _handleScan(context),
                  ),
                  _AttachmentOption(
                    icon: HugeIcons.strokeRoundedColorPicker,
                    label: 'Templates',
                    color: Colors.green,
                    onTap: () {
                      // TODO: implement template picker
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
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
          builder: (_) => FileList(typeSign: typeSign),
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
          builder: (_) => FileList(typeSign: typeSign),
        ),
      );
    }
  }
}

class _AttachmentOption extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback? onTap;

  const _AttachmentOption({
    required this.icon,
    required this.label,
    required this.color,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            radius: 25,
            backgroundColor: color.withOpacity(0.16),
            child: Icon(icon, color: color, size: 28),
          ),
          const SizedBox(height: 8),
          Text(label, style: const TextStyle(fontSize: 14)),
        ],
      ),
    );
  }
}
