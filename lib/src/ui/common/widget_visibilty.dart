import 'package:flutter/material.dart';

class WidgetVisibility extends StatelessWidget {
  final bool visible;
  final Widget child;

  WidgetVisibility({required this.visible, required this.child});

  @override
  Widget build(BuildContext context) {
    return !visible ? Container() : child;
  }
}
