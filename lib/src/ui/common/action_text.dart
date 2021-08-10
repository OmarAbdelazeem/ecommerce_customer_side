import 'package:flutter/material.dart';
import 'package:baqal/src/res/app_colors.dart';

class ActionText extends StatelessWidget {
  final VoidCallback ? onTap;
  final String title;


  ActionText( {required this.title, this.onTap});

  @override
  Widget build(BuildContext context) {
    return actionText();
  }

  TextStyle get actionTextStyle => TextStyle(
      fontWeight: FontWeight.w500, fontSize: 14, color: AppColors.primaryColor);

  Widget actionText() {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Text(
        "$title",
        style: actionTextStyle,
      ),
    );
  }
}
