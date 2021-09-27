import 'package:baqal/src/res/app_colors.dart';
import 'package:flutter/material.dart';


Widget addOrMinusButton(bool isAdd, VoidCallback? onTap) => GestureDetector(
  onTap: onTap,
  behavior: HitTestBehavior.opaque,
  child: Container(
    height: 32,
    width: 32,
    alignment: Alignment.center,
    decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: isAdd ? AppColors.colorE2E6EC : AppColors.colorE2E6EC),
    child: Center(
      child: Icon(
        isAdd ? Icons.add : Icons.remove,
        size: 14,
        color: isAdd ? AppColors.color81819A : AppColors.color81819A,
      ),
    ),
  ),
);
