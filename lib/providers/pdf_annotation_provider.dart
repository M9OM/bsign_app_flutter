import 'dart:typed_data';
import 'package:flutter/material.dart';
enum AnnotationType { signature, name, date }

class AnnotationItem {
  final AnnotationType type;
  Offset position;
  final String? value;
  final Uint8List? image;

  AnnotationItem({
    required this.type,
    required this.position,
    this.value,
    this.image,
  });
}

class AnnotationProvider with ChangeNotifier {
  
  final List<AnnotationItem> _annotations = [];

  List<AnnotationItem> get annotations => _annotations;

  void addAnnotation(AnnotationItem item) {
    _annotations.add(item);
    notifyListeners();
  }

  void updatePosition(int index, Offset newPosition) {
    _annotations[index].position = newPosition;
    notifyListeners();
  }

  void clear() {
    _annotations.clear();
    notifyListeners();
  }
}
