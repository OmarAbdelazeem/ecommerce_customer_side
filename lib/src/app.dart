import 'package:baqal/src/res/app_theme.dart';
import 'package:baqal/src/routes/router.dart' as router;
import 'package:baqal/src/routes/routes_constants.dart';
import 'package:baqal/src/ui/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'di/app_injector.dart';
import 'notifiers/language_notifier.dart';
import 'notifiers/provider_notifier.dart';

class App extends StatefulWidget {
  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final languageProvider = getItInstance<LanguageProvider>();
  @override
  void initState() {
    languageProvider.checkIfThereIsASavedLocale();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ProviderNotifier(
      child: (LanguageProvider languageNotifier) {
        return MaterialApp(
            home: SplashScreen(),
            initialRoute: Routes.splashScreen,
            onGenerateRoute: router.generateRoute,
            theme: AppTheme.appTheme,
            debugShowCheckedModeBanner: false,
            locale: languageNotifier.locale,
            supportedLocales: languageNotifier.supportedLocals,
            localizationsDelegates: languageNotifier.localizationsDelegates,
            localeResolutionCallback: languageNotifier.localResolutionCallback);
      },
    );
  }
}
