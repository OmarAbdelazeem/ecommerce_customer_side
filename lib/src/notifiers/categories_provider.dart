import 'package:baqal/src/models/main_category_model.dart';
import 'package:baqal/src/models/name_field.dart';
import 'package:baqal/src/models/sub_category_model.dart';
import 'package:flutter/foundation.dart';

class CategoriesProvider extends ChangeNotifier {
  List<MainCategoryModel> _mainCategories = [];
  List<SubCategoryModel> _subCategories = [];
  MainCategoryModel? _currentMainCategory;
  SubCategoryModel? _currentSubCategory;

  int get currentCategoryIndex {
    return _mainCategories.indexWhere((element) => element.id == currentMainCategory!.id);
  }

  set setSubCategories(List<SubCategoryModel> subCategories) {
    _subCategories = subCategories;
  }

  set setMainCategories(List<MainCategoryModel> mainCategory) {
    _mainCategories = mainCategory;
  }

  set setCurrentSubCategory(SubCategoryModel subCategory) {
    _currentSubCategory = subCategory;
    _currentMainCategory = _mainCategories.firstWhere(
        (mainCategory) => subCategory.mainCategoryId == mainCategory.id);
  }

  get mainCategories => _mainCategories;

  get subCategories => _subCategories;

  MainCategoryModel? get currentMainCategory => _currentMainCategory;

  SubCategoryModel? get currentSubCategory => _currentSubCategory;
}
