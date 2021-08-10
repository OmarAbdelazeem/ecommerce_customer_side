import 'package:baqal/src/di/app_injector.dart';
import 'package:baqal/src/repository/firestore_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class CategoriesProvider extends ChangeNotifier {
  var _firestoreRepo = getItInstance<FirestoreRepository>();

  int categoriesPageIndex = 0;
  bool categoriesFinished = false;

  Future fetchCategories({required String categoryName}) async {
    var categoryInfo;
    try {
      if (categoriesPageIndex <= 3) {
        if (categoriesPageIndex == 0) {
          categoryInfo =
              await _firestoreRepo.getCategoyInfo(isMainCategories: true);
        }
        if (categoriesPageIndex > 0) {
          categoryInfo =
              await _firestoreRepo.getCategoyInfo(categoryName: categoryName);
        }

        if (categoriesPageIndex < 3) {
          categoriesPageIndex++;
        } if (categoriesPageIndex == 3) {
          categoriesFinished = true;
          notifyListeners();
        }
        print(
            'categoriesPageIndex is $categoriesPageIndex ');
        return categoryInfo;
      }

    } catch (e) {
      print(e);
    }
  }

  Future<bool> popPage()async{
    if(categoriesPageIndex > 0){
      categoriesPageIndex--;
      print(
          'categoriesPageIndex is $categoriesPageIndex ');
      categoriesFinished = false;
      notifyListeners();
    }
    return true;
  }
}
