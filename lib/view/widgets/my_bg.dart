import 'dart:ui';
import 'package:flutter/material.dart';

class MyBackground extends StatelessWidget {
  final Widget child;

  const MyBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // 🌄 خلفية تدرج لوني
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFFf8f9fa),
                Color(0xFFe9ecef),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),

        // 🔵 دائرة زرقاء ثابتة مع Blur
        Positioned(
          top: -30,
          left: -30,
          child: ClipOval(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 80.0, sigmaY: 80.0),
              child: Container(
                width: 200,
                height: 200,
                color: Colors.blue.withOpacity(0.2),
              ),
            ),
          ),
        ),

        // 🔴 دائرة وردية ثابتة مع Blur
        Positioned(
          bottom: -30,
          right: -30,
          child: ClipOval(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 80.0, sigmaY: 80.0),
              child: Container(
                width: 200,
                height: 200,
                color: Colors.blue.withOpacity(0.2),
              ),
            ),
          ),
        ),

        // 👇 المحتوى الرئيسي
        child,
      ],
    );
  }
}
