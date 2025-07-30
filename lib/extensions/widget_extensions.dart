import 'package:flutter/material.dart';

extension WidgetExtensions on Widget {
  Widget withPadding([EdgeInsets padding = const EdgeInsets.all(8)]) =>
      Padding(padding: padding, child: this);

  Widget withMargin([EdgeInsets margin = const EdgeInsets.all(8)]) =>
      Container(margin: margin, child: this);

  Widget visible(bool isVisible) => isVisible ? this : const SizedBox.shrink();

  Widget center() => Center(child: this);
}
