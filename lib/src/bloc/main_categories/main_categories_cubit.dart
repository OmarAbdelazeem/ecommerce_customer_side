import 'package:baqal/src/bloc/base_states/result_state/result_state.dart';
import 'package:baqal/src/di/app_injector.dart';
import 'package:baqal/src/models/main_category_model.dart';
import 'package:baqal/src/repository/firestore_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'main_categories_state.dart';

class MainCategoriesCubit extends Cubit<MainCategoriesState> {
  MainCategoriesCubit() : super(MainCategoriesState.idle());

  var _firestoreRepo = getItInstance<FirestoreRepository>();
  late List<DocumentSnapshot> _documents;
  List<MainCategoryModel> _mainCategoriesList = [];
  late MainCategoryModel selectedMainCategory;
  late MainCategoryModel selectedSubCategory;

  fetchMainCategories() async {
    emit(MainCategoriesState.categoriesLoading());
    try {
      _documents = await _firestoreRepo.fetchMainCategories();
      _mainCategoriesList = List<MainCategoryModel>.generate(_documents.length,
          (index) => MainCategoryModel.fromJson(_documents[index]));
      List.generate(_mainCategoriesList.length, (index) {
        print(_mainCategoriesList[index].name);
      });
      print(_mainCategoriesList.length);
      emit(MainCategoriesState.categoriesLoaded(_mainCategoriesList.toSet().toList()));

      // emit(ResultState.data(data: _mainCategoriesList.toSet().toList()));
    } catch (e) {
      emit(MainCategoriesState.error(e.toString()));
    }
  }

  get mainCategories => _mainCategoriesList;
}
