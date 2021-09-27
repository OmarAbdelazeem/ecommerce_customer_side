// import 'dart:async';
// import 'dart:io';
//
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:baqal/src/core/utils/connectivity.dart';
// import 'package:baqal/src/res/app_colors.dart';
//
// typedef _onConnectionChanged = void Function(bool value);
//
// mixin BaseScreenMixin {
//
//   final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
//
//   GlobalKey<ScaffoldState> get scaffoldKey => _scaffoldKey;
//
//   bool isOffline = false;
//
//   var connectionStatus = MyConnectivity.instance;
//   //
//   Future<bool> isNetworkConnected() async {
//     try {
//       final result = await InternetAddress.lookup('google.com');
//       if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
//         return true;
//       } else {
//         return false;
//       }
//     } on SocketException catch (_) {
//       return false;
//     }
//   }
//
//   showSnackBar({required String title ,required BuildContext context}) {
//     hideSnackBar(context);
//    var snackBar = SnackBar(
//         content: Text(title),
//         duration: Duration(days: 1)
//     );
//
//     ScaffoldMessenger.of(context).showSnackBar(snackBar);
//   }
//
//   hideSnackBar(BuildContext context){
//     ScaffoldMessenger.of(context).hideCurrentSnackBar();
//   }
//
//   showToast(String msg, BuildContext context,
//       {int duration = 1,
//       int gravity = 0,
//       double backgroundRadius = 20,
//       Border? border}) {
//     Fluttertoast.showToast(
//       msg: msg,
//       toastLength: Toast.LENGTH_SHORT,
//       gravity: ToastGravity.BOTTOM,
//       timeInSecForIosWeb: 1,
//       backgroundColor: AppColors.white,
//       textColor: AppColors.black,
//       fontSize: 14.0,
//     );
//   }
//
//
//
//
//   void onConnectionChange(_onConnectionChanged connectionChanged) {
//     connectionStatus.initialize();
//     connectionStatus.myStream.listen((value) {
//       connectionChanged(connectionStatus.getInternetStatus(value));
//     });
//   }
// }
