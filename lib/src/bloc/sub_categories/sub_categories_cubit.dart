import 'package:baqal/src/di/app_injector.dart';
import 'package:baqal/src/models/sub_category_model.dart';
import 'package:baqal/src/notifiers/categories_provider.dart';
import 'package:baqal/src/repository/firestore_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'sub_categories_state.dart';

class SubCategoriesCubit extends Cubit<SubCategoriesState> {
  SubCategoriesCubit() : super(SubCategoriesState.idle());

  late List<DocumentSnapshot> _documents;
  List<SubCategoryModel> _subCategoriesList = [];
  var _firestoreRepo = getItInstance<FirestoreRepository>();
  final categoriesNotifier = getItInstance<CategoriesProvider>();

  void fetchSubCategories(String categoryId) async {
    emit(SubCategoriesState.loading());
    try {
      _documents = await _firestoreRepo.fetchSubCategories(categoryId);
      _subCategoriesList = List<SubCategoryModel>.generate(_documents.length,
          (index) => SubCategoryModel.fromJson(_documents[index].data()));

      categoriesNotifier.setSubCategories = _subCategoriesList;

      emit(SubCategoriesState.loaded(_subCategoriesList));
    } catch (e) {
      print('subCategories cubit error is $e');
      emit(SubCategoriesState.error(e.toString()));
    }
  }
}
