import 'package:flutter/cupertino.dart';

Widget noInternetConnection(){
  return Column(
    children: [
      Image.asset('assets/images/no-internet.gif'),
      SizedBox(
        height: 20,
      ),
      Text(
        'No internet connection',
        style: TextStyle(fontSize: 18),
      ),
    ],
  );

}