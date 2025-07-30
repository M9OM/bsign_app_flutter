import 'package:flutter/material.dart';
import 'package:bsign/models/signature_field/signature_field_model.dart';
import 'package:bsign/models/signature_field/signaure_type.dart';

class PositionedSignatureBox extends StatelessWidget {
  final SignatureField field;
  final double scale;
  final double pageWidth;
  final double pageHeight;
  final Function(SignatureField)? onPositionChanged;
  final VoidCallback? onDelete;

  const PositionedSignatureBox({
    super.key,
    required this.field,
    required this.scale,
    required this.pageWidth,
    required this.pageHeight,
    this.onPositionChanged,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final left = field.x * pageWidth * scale;
    final top = field.y * pageHeight * scale;
    final width = field.width * pageWidth * scale;
    final height = field.height * pageHeight * scale;

    return Positioned(
      left: left,
      top: top,
      child: GestureDetector(
        onPanUpdate: (details) {
          if (onPositionChanged == null) return;

          double newX = ((left + details.delta.dx) / scale) / pageWidth;
          double newY = ((top + details.delta.dy) / scale) / pageHeight;

          newX = newX.clamp(0.0, 1.0 - field.width);
          newY = newY.clamp(0.0, 1.0 - field.height);

          onPositionChanged!(
            field.copyWith(x: newX, y: newY),
          );
        },
        child: Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: Colors.yellow.withOpacity(0.3),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Stack(
            children: [
              // النص في الوسط دائمًا
              Center(
                child: Text(
                  field.value?.isNotEmpty == true
                      ? field.value!
                      : field.type.displayName,
                  style: const TextStyle(fontSize: 12, color: Colors.black),
                  textAlign: TextAlign.center,
                ),
              ),
              // أيقونة الحذف
              if (onDelete != null)
                Positioned(
                  top: 2,
                  right: 2,
                  child: GestureDetector(
                    onTap: onDelete,
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      padding: const EdgeInsets.all(2),
                      child: const Icon(Icons.close, size: 12, color: Colors.white),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
