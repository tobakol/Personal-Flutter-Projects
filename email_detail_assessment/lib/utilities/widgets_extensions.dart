import 'package:flutter/material.dart';

extension WidgetExtension on Widget {
  Widget spaceTo({double left = 0, double right = 0, double top = 0, double bottom = 0}) {
    return Padding(padding: EdgeInsets.only(bottom: bottom, top: top, left: left, right: right), child: this);
  }

  Widget paddingAll(double value) {
    return Padding(padding: EdgeInsets.all(value), child: this);
  }

  Widget spaceSymmetrically({double vertical = 0, double horizontal = 0}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontal, vertical: vertical),
      child: this,
    );
  }
}
