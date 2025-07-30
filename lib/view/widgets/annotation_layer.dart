// import 'package:bsign/models/annotation.dart';
// import 'package:flutter/material.dart';

// class AnnotationLayer extends StatelessWidget {
//   final List<Annotation> annotations;
//   final int? selectedIndex;
//   final Function(int) onAnnotationTapped;
//   final Function(int, Offset) onAnnotationMoved;

//   const AnnotationLayer({
//     super.key,
//     required this.annotations,
//     this.selectedIndex,
//     required this.onAnnotationTapped,
//     required this.onAnnotationMoved,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: List.generate(
//         annotations.length,
//         (index) => _buildAnnotationWidget(index),
//       ),
//     );
//   }

//   Widget _buildAnnotationWidget(int index) {
//     final annotation = annotations[index];
//     final isSelected = selectedIndex == index;
    
//     return Positioned(
//       left: annotation.position.dx,
//       top: annotation.position.dy,
//       child: GestureDetector(
//         onTap: () => onAnnotationTapped(index),
//         onPanUpdate: (details) {
//           onAnnotationMoved(index, Offset(
//             annotation.position.dx + details.delta.dx,
//             annotation.position.dy + details.delta.dy,
//           ));
//         },
//         child: Container(
//           decoration: BoxDecoration(
//             border: isSelected ? Border.all(color: Colors.blue, width: 2) : null,
//           ),
//           child: _buildAnnotationContent(annotation),
//         ),
//       ),
//     );
//   }

//   Widget _buildAnnotationContent(Annotation annotation) {
//     switch (annotation.type) {
//       case AnnotationType.signature:
//         return CustomPaint(
//           size: annotation.size,
//           painter: SignatureAnnotationPainter(annotation.signaturePath),
//         );
        
//       case AnnotationType.text:
//         return Container(
//           padding: const EdgeInsets.all(4),
//           child: Text(
//             annotation.content,
//             style: TextStyle(
//               fontSize: annotation.fontSize,
//               color: annotation.color,
//             ),
//           ),
//         );
        
//       case AnnotationType.date:
//         return Container(
//           padding: const EdgeInsets.all(4),
//           color: Colors.yellow[200],
//           child: Text(
//             annotation.content,
//             style: const TextStyle(fontSize: 12),
//           ),
//         );
        
//       case AnnotationType.initials:
//         return Container(
//           width: 50,
//           height: 50,
//           decoration: BoxDecoration(
//             color: Colors.amber[100],
//             shape: BoxShape.circle,
//           ),
//           alignment: Alignment.center,
//           child: Text(
//             annotation.content,
//             style: const TextStyle(
//               fontSize: 16,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//         );
        
//       case AnnotationType.name:
//         return Text(
//           annotation.content,
//           style: const TextStyle(
//             fontSize: 14,
//             fontWeight: FontWeight.bold,
//           ),
//         );
//     }
//   }
// }

// class SignatureAnnotationPainter extends CustomPainter {
//   final Path? signaturePath;
  
//   SignatureAnnotationPainter(this.signaturePath);
  
//   @override
//   void paint(Canvas canvas, Size size) {
//     if (signaturePath == null) return;
    
//     final paint = Paint()
//       ..color = Colors.black
//       ..strokeCap = StrokeCap.round
//       ..strokeWidth = 3.0
//       ..style = PaintingStyle.stroke;
      
//     canvas.drawPath(signaturePath!, paint);
//   }
  
//   @override
//   bool shouldRepaint(SignatureAnnotationPainter oldDelegate) => 
//       oldDelegate.signaturePath != signaturePath;
// }