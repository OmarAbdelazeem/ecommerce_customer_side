import 'package:flutter/cupertino.dart';

class MainHomeScreenProvider extends ChangeNotifier {
  int _navigationIndex = 0;
  PageController pageController = PageController();

  set setNavigationIndex(int value) {
    _navigationIndex = value;
    notifyListeners();
  }

  int get navigationIndex => _navigationIndex;
}
