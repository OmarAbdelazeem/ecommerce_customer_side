import 'package:flutter/material.dart';

showSnackBar(
    {required String title,
    required BuildContext context,
    Duration? duration}) {
  hideSnackBar(context);
  var snackBar =
      SnackBar(content: Text(title), duration: duration ?? Duration(seconds: 2));

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

hideSnackBar(BuildContext context) {
  ScaffoldMessenger.of(context).hideCurrentSnackBar();
}
