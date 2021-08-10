import 'package:baqal/src/ui/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:baqal/src/res/app_theme.dart';

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return
    MaterialApp(
        theme: AppTheme.appTheme(),
        debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
