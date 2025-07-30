import 'package:flutter/material.dart';

class SignaturePad extends StatefulWidget {
  final Function(Path) onSignatureComplete;

  const SignaturePad({super.key, required this.onSignatureComplete});

  @override
  State<SignaturePad> createState() => _SignaturePadState();
}

class _SignaturePadState extends State<SignaturePad> {
  final List<Offset?> _points = [];
  final Path _signaturePath = Path();
  
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Expanded(
            child: GestureDetector(
              onPanStart: (details) {
                setState(() {
                  RenderBox renderBox = context.findRenderObject() as RenderBox;
                  Offset localPosition = renderBox.globalToLocal(details.globalPosition);
                  _points.add(localPosition);
                  _signaturePath.moveTo(localPosition.dx, localPosition.dy);
                });
              },
              onPanUpdate: (details) {
                setState(() {
                  RenderBox renderBox = context.findRenderObject() as RenderBox;
                  Offset localPosition = renderBox.globalToLocal(details.globalPosition);
                  _points.add(localPosition);
                  _signaturePath.lineTo(localPosition.dx, localPosition.dy);
                });
              },
              onPanEnd: (details) {
                _points.add(null);
              },
              child: CustomPaint(
                painter: SignaturePainter(points: _points, path: _signaturePath),
                size: Size.infinite,
              ),
            ),
          ),
          Container(
            color: Colors.grey[200],
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    setState(() {
                      _points.clear();
                      _signaturePath.reset();
                    });
                  },
                  child: const Text('Clear'),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_points.isNotEmpty) {
                      widget.onSignatureComplete(_signaturePath);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                  ),
                  child: const Text('Done'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SignaturePainter extends CustomPainter {
  final List<Offset?> points;
  final Path path;
  
  SignaturePainter({required this.points, required this.path});
  
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.black
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 3.0;
      
    canvas.drawPath(path, paint);
  }
  
  @override
  bool shouldRepaint(SignaturePainter oldDelegate) => true;
}