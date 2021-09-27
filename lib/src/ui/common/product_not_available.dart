import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget productNotAvailable() {
  return Container(
    height: 40,
    padding: EdgeInsets.all(10),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(5),
      color: Colors.red,
    ),
    child: Text(
      'Product not available',
      textAlign: TextAlign.start,
      style: TextStyle(
          fontSize: 15, color: Colors.white, overflow: TextOverflow.fade),
    ),
  );
}
