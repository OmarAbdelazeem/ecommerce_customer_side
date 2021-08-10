import 'package:flutter/cupertino.dart';

class SelectedCategoryProvider with ChangeNotifier{

  String ? selectedMainCategoryId;
  String ? selectedSubCategoryId;
  int ? mainCategoryIndex;
  selectMainCategory(String mainCategoryId){
    selectedMainCategoryId = mainCategoryId;
    notifyListeners();
  }

  selectMainCategoryIndex(int index){
    mainCategoryIndex =index;
    notifyListeners();
  }
  selectSubCategory(String subCategoryId){
    selectedSubCategoryId = subCategoryId;
    notifyListeners();
    // notifyListeners();
  }
}