import 'package:baqal/src/core/utils/connectivity.dart';
import 'package:baqal/src/di/app_injector.dart';
import 'package:baqal/src/models/main_category_model.dart';
import 'package:baqal/src/notifiers/categories_provider.dart';
import 'package:baqal/src/repository/firestore_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'main_categories_state.dart';

class MainCategoriesCubit extends Cubit<MainCategoriesState> {
  MainCategoriesCubit() : super(MainCategoriesState.idle());

  var _firestoreRepo = getItInstance<FirestoreRepository>();
  late List<DocumentSnapshot> _documents;
  List<MainCategoryModel> _mainCategoriesList = [];
  final categoriesProvider = getItInstance<CategoriesProvider>();
  MyConnectivity _connectivity = MyConnectivity.instance;

  fetchMainCategories() async {
    bool hasConnection = await _connectivity.checkInternetConnection();
    if(hasConnection){
      emit(MainCategoriesState.loading());
      try {
        // 1 - fetch main categories docs
        _documents = await _firestoreRepo.fetchMainCategories();

        // 2 - convert docs to main categories models

        var temp = List<MainCategoryModel>.generate(_documents.length,
                (index) => MainCategoryModel.fromJson(_documents[index]));

        // 3 - remove empty main categories
        temp.removeWhere((element) => element.subCategoriesIds.isEmpty);


        _mainCategoriesList = temp;

        categoriesProvider.setMainCategories = _mainCategoriesList;

        emit(MainCategoriesState.loaded(_mainCategoriesList));

      } catch (e) {
        print('categories cubit error is $e');
        emit(MainCategoriesState.error(e.toString()));
      }
    }


  }


  get mainCategories => _mainCategoriesList;
}
