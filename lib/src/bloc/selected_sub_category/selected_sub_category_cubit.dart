
import 'package:baqal/src/models/sub_category_model.dart';
import 'package:baqal/src/ui/common/main_category.dart';
import 'package:bloc/bloc.dart';

class SelectedSubCategoryCubit extends Cubit<bool> {

  late SubCategoryModel _selectedSubCategory;
  // MainCategoryModel _selectedMainCategoryModel;
  // SelectedCategoryState.idle()
  SelectedSubCategoryCubit() : super(false);

  // compareWithSelectedMainCategory(MainCategoryModel mainCategoryModel) {
  //   // return categoryModel == _selectedMainCategoryModel;
  //   emit(mainCategoryModel == _selectedMainCategoryModel);
  // }

  compareWithSelectedSubCategory(SubCategoryModel subCategoryModel) {
    // return categoryModel == _selectedSubCategory;
    emit(subCategoryModel == _selectedSubCategory);
  }

  // selectMainCategory(MainCategoryModel mainCategoryModel){
  //   _selectedMainCategoryModel = mainCategoryModel;
  // }

  selectSubCategory(SubCategoryModel subCategoryModel){
    _selectedSubCategory = subCategoryModel;
  }
// void changeTappedCategoryState() {
//   categoryModel.changeClickState();
//   categoryModel.isTapped
//       ? emit(SelectedCategoryState.categoryTapped())
//       : emit(SelectedCategoryState.categoryNotTapped());
// }
}
