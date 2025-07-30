// import 'package:bsign/models/annotation.dart';
// import 'package:flutter/material.dart';

// class PdfAnnotationToolbar extends StatelessWidget {
//   final AnnotationType? selectedTool;
//   final Function(AnnotationType) onToolSelected;

//   const PdfAnnotationToolbar({
//     super.key,
//     required this.selectedTool,
//     required this.onToolSelected,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 100,
//       color: Colors.white,
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         children: [
//           _buildToolButton(
//             context: context,
//             type: AnnotationType.signature,
//             icon: Icons.draw,
//             label: 'Signature',
//           ),
//           _buildToolButton(
//             context: context,
//             type: AnnotationType.initials,
//             icon: Icons.short_text,
//             label: 'Initials',
//           ),
//           _buildToolButton(
//             context: context,
//             type: AnnotationType.date,
//             icon: Icons.calendar_today,
//             label: 'Date',
//           ),
//           _buildToolButton(
//             context: context,
//             type: AnnotationType.text,
//             icon: Icons.text_fields,
//             label: 'Textbox',
//           ),
//           _buildToolButton(
//             context: context,
//             type: AnnotationType.name,
//             icon: Icons.person,
//             label: 'Name',
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildToolButton({
//     required BuildContext context,
//     required AnnotationType type,
//     required IconData icon,
//     required String label,
//   }) {
//     final isSelected = selectedTool == type;
    
//     return GestureDetector(
//       onTap: () => onToolSelected(type),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Container(
//             width: 60,
//             height: 60,
//             decoration: BoxDecoration(
//               color: isSelected ? Colors.amber : Colors.amber.shade100,
//               shape: BoxShape.circle,
//             ),
//             child: Icon(
//               icon,
//               size: 28,
//               color: isSelected ? Colors.black87 : Colors.black54,
//             ),
//           ),
//           const SizedBox(height: 4),
//           Text(
//             label,
//             style: TextStyle(
//               fontSize: 12,
//               fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }