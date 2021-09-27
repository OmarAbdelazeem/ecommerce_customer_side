import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:baqal/src/di/app_injector.dart';
import 'package:baqal/src/repository/auth_repository.dart';
import 'package:package_info/package_info.dart';

class CrashlyticsService {
  static recordFlutterError(FlutterErrorDetails details) {
    FirebaseCrashlytics.instance.recordFlutterError(details);
    // fullDeviceLog();
  }

  static recordError(dynamic exception, StackTrace stack, {dynamic context}) {
    FirebaseCrashlytics.instance.recordError(exception, stack);
    // fullDeviceLog();
  }

  // static fullDeviceLog() async {
  //   var authRepo = getItInstance<FirebaseRepository>();
  //   var isLoggedIn = await authRepo.checkLoggedInStatus();
  //   String packageName = (await PackageInfo.fromPlatform()).packageName;
  //   StringBuffer stringBuffer = StringBuffer("");
  //   stringBuffer.write("Platform : $defaultTargetPlatform");
  //   stringBuffer.write("Package Name : $packageName");
  //   stringBuffer.write("Date of Error : ${DateTime.now()}");
  //   if (isLoggedIn) {
  //     var currentUser = await authRepo.getCurrentUser();
  //     stringBuffer.write("Name : ${currentUser!.displayName}");
  //     stringBuffer.write("Phone Number : ${currentUser.phoneNumber}");
  //     stringBuffer.write("UID : ${currentUser.uid}");
  //   }
  //   FirebaseCrashlytics.instance.log(stringBuffer.toString());
  // }
}