import 'package:flutter/material.dart';

class UndefinedViewScreen extends StatelessWidget {
  final String ? name;
  const UndefinedViewScreen({Key ? key,  this.name}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Route for $name is not defined'),
      ),
    );
  }
}