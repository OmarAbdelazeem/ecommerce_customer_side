import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:baqal/src/app.dart';
import 'package:baqal/src/bloc/app_cubit_observer.dart';
import 'package:baqal/src/core/services/crashlytics_service.dart';
import 'package:baqal/src/di/app_injector.dart';

void main() {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    AppInjector.create();
    Bloc.observer = MyBlocObserver();
    // FirebaseCrashlytics.instance.recordError(exception, stack) = false;
    FlutterError.onError = CrashlyticsService.recordFlutterError;
    runApp(App());
  }, (error, stack) {
    CrashlyticsService.recordError(error, stack);
  }, zoneSpecification: ZoneSpecification());
}

