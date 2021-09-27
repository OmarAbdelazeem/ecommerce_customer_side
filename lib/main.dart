import 'dart:async';
import 'dart:io';
import 'package:baqal/src/app.dart';
import 'package:baqal/src/models/cart_model.dart';
import 'package:baqal/src/models/name_field.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:baqal/src/core/services/crashlytics_service.dart';
import 'package:baqal/src/di/app_injector.dart';
import 'package:baqal/src/notifiers/notification_provider.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:path_provider/path_provider.dart' as pathProvider;
import 'package:hive/hive.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
}

void main() {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
      AppInjector.create();

    Directory directory = await pathProvider.getApplicationDocumentsDirectory();
    Hive.init(directory.path);
    Hive.registerAdapter(CartItemModelAdapter());
    Hive.registerAdapter(NameFieldAdapter());
    Hive.openBox('cart');

  final notificationProvider = getItInstance<NotificationProvider>();
  notificationProvider.setInitialMessage = await FirebaseMessaging.instance.getInitialMessage();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    // Bloc.observer = MyBlocObserver();
    // FirebaseCrashlytics.instance.recordError(exception, stack) = false;
    FlutterError.onError = CrashlyticsService.recordFlutterError;
    runApp(App());
  }, (error, stack) {
    CrashlyticsService.recordError(error, stack);
  }, zoneSpecification: ZoneSpecification());
}


