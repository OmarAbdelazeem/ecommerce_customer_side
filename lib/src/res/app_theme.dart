import 'package:flutter/material.dart';
import 'package:baqal/src/res/app_colors.dart';

class AppTheme {
  static ThemeData get appTheme {
    return ThemeData(
      fontFamily: 'Montserrat',
      scaffoldBackgroundColor: Colors.white,
      cardTheme: CardTheme(elevation: 5),
      appBarTheme: AppBarTheme(
        color: Colors.yellow.shade900,
        elevation: 2,
        iconTheme: IconThemeData(color: AppColors.primaryColor),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        elevation: 20,
        unselectedItemColor: Colors.grey.shade500,
        selectedItemColor: Colors.black,
        // unselectedFontSize: 0.0,
      )
    );
  }

}
