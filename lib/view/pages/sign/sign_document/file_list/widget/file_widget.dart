import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

class FileWidget extends StatelessWidget {
  
  const FileWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(leading: Icon(HugeIcons.strokeRoundedPdf01));
  }
}
