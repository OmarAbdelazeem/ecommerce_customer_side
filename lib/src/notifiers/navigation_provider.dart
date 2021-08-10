import 'package:flutter/cupertino.dart';

class NavigationProvider with ChangeNotifier{
 late String _pushingPageRoot;
  bool _isFromMainHomeScreen = false;
  void changePushingPageRoot(String newPushingRoot){
    _pushingPageRoot = newPushingRoot;
    notifyListeners();
  }

  set setIsFromMainHomeScreen(bool value){
    _isFromMainHomeScreen = value;
  }

  // get isFromMainHomeScreen => _isFromMainHomeScreen;

  get getPushingPageRoot => _pushingPageRoot;
}