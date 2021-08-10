import 'package:flutter/material.dart';

class Navigation{
  static  push(BuildContext context , dynamic page){
   return Navigator.push(context, MaterialPageRoute(builder: (_)=>page));
  }

  static  pushAndPopUntil(BuildContext context , dynamic page){
    return Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_)=>page) , (route)=>false);
  }

  static  popUntil(BuildContext context){
    return Navigator.popUntil(context,(route)=> false );
  }
}