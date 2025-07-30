import 'package:flutter/material.dart';

enum AnnotationTool {
  none,
  signature,
  initials,
  date,
  textbox,
  name,
}

class AnnotationModel {
  final String id;
  final AnnotationTool type;
  final Offset position;
  final double scale;
  final double rotation;
  dynamic data;

  AnnotationModel({
    required this.id,
    required this.type,
    required this.position,
    this.scale = 1.0,
    this.rotation = 0.0,
    required this.data,
  });

  AnnotationModel copyWith({
    String? id,
    AnnotationTool? type,
    Offset? position,
    double? scale,
    double? rotation,
    dynamic data,
  }) {
    return AnnotationModel(
      id: id ?? this.id,
      type: type ?? this.type,
      position: position ?? this.position,
      scale: scale ?? this.scale,
      rotation: rotation ?? this.rotation,
      data: data ?? this.data,
    );
  }
}

class SignatureData {
  final List<Offset> points;
  final Color color;
  final double strokeWidth;

  SignatureData({
    required this.points,
    this.color = Colors.black,
    this.strokeWidth = 2.0,
  });

  SignatureData copyWith({
    List<Offset>? points,
    Color? color,
    double? strokeWidth,
  }) {
    return SignatureData(
      points: points ?? this.points,
      color: color ?? this.color,
      strokeWidth: strokeWidth ?? this.strokeWidth,
    );
  }
}

class TextData {
  final String text;
  final TextStyle style;
  
  TextData({
    required this.text,
    required this.style,
  });

  TextData copyWith({
    String? text,
    TextStyle? style,
  }) {
    return TextData(
      text: text ?? this.text,
      style: style ?? this.style,
    );
  }
}

class DateData {
  final DateTime date;
  final String format;
  final TextStyle style;
  
  DateData({
    required this.date,
    this.format = 'dd/MM/yyyy',
    required this.style,
  });

  DateData copyWith({
    DateTime? date,
    String? format,
    TextStyle? style,
  }) {
    return DateData(
      date: date ?? this.date,
      format: format ?? this.format,
      style: style ?? this.style,
    );
  }
}