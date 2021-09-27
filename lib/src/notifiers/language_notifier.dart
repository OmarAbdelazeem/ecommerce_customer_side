import 'package:baqal/src/core/localization/set_localization.dart';
import 'package:baqal/src/models/language_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageProvider extends ChangeNotifier {
  Locale? _locale;

  bool _isEnglish = true;

  LanguageModel? languageOption;

  List<Locale> _supportedLocals = [Locale('en', 'US'), Locale('ar', 'EG')];

  Iterable<LocalizationsDelegate<dynamic>>? _localizationsDelegates = [
    SetLocalization.localizationsDelegate,
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
  ];

  void setLocale(Locale? locale) {
    _locale = locale;
    _saveLocale(locale!);
    notifyListeners();
  }

  Locale? get locale => _locale;

  get isEnglish => _isEnglish;

  get supportedLocals => _supportedLocals;

  Iterable<LocalizationsDelegate<dynamic>>? get localizationsDelegates =>
      _localizationsDelegates!;

  Locale? localResolutionCallback(
      Locale? deviceLocal, Iterable<Locale>? localeResolutionCallback) {
    for (var local in localeResolutionCallback!) {
      if (local.languageCode == deviceLocal!.languageCode &&
          local.countryCode == deviceLocal.countryCode) {
        _locale = deviceLocal;
        if (locale!.languageCode == 'en') {
          _isEnglish = true;
          languageOption = LanguageModel.languageList()[0];
        } else if (locale!.languageCode == 'ar') {
          _isEnglish = false;
          languageOption = LanguageModel.languageList()[1];
        }
        print('languageOption.languageCode is ${languageOption!.languageCode}');
        return deviceLocal;
      }
    }
    return localeResolutionCallback.first;
  }


  String? getTranslated(BuildContext? context, String? key) {
    return SetLocalization.of(context!)!.getTranslateValue(key!);
  }

  Future<Locale> checkIfThereIsASavedLocale()async{
      Locale? locale = await _getSavedLocale;
      if(locale !=null)
        setLocale(locale);
      else
        locale = Locale('en','US');
      return locale;
  }

  void changeLanguage(LanguageModel? lang) {
    Locale locale = _getLocaleForLanguage(lang);
    setLocale(locale);
  }

  Locale _getLocaleForLanguage(LanguageModel? lang) {
    Locale _temp;
    switch (lang!.languageCode) {
      case 'en':
        _temp = Locale(lang.languageCode, 'US');
        break;
      case 'ar':
        _temp = Locale(lang.languageCode, 'EG');
        break;
      default:
        _temp = Locale('en', 'US');
        break;
    }
    return _temp;
  }

  Future<Locale?> get _getSavedLocale async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? languageCode = prefs.getString('language_code');
    String? countryCode = prefs.getString('country_code');
    if (languageCode != null)
      return Locale(languageCode, countryCode);
    else
      return null;
  }

  void _saveLocale(Locale locale) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('language_code', locale.languageCode);
    if (locale.countryCode != null)
      prefs.setString('country_code', locale.countryCode!);
  }
}
