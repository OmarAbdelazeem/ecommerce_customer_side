// import 'package:admin_side_ecommerce/src/models/category_model.dart';
// import 'package:admin_side_ecommerce/src/ui/common/main_category.dart';
// import 'package:bloc/bloc.dart';
//
// class SelectedMainCategoryCubit extends Cubit<bool> {
//
//   // SubCategoryModel _selectedSubCategory;
//   String _selectedMainCategoryId;
//   // SelectedCategoryState.idle()
//   SelectedMainCategoryCubit() : super(false);
//
//   compareWithSelectedMainCategory(String mainCategoryId) {
//     // return categoryModel == _selectedMainCategoryModel;
//     print('mainCategoryModel.id is ${mainCategoryId}');
//     print('_selectedMainCategoryModel.id is ${_selectedMainCategoryId}');
//     emit(mainCategoryId == _selectedMainCategoryId);
//   }
//
//   // compareWithSelectedSubCategory(SubCategoryModel subCategoryModel) {
//   //   // return categoryModel == _selectedSubCategory;
//   //   emit(subCategoryModel == _selectedSubCategory);
//   // }
//
//   selectMainCategory(String mainCategoryId){
//     _selectedMainCategoryId = mainCategoryId;
//   }
//
//   // selectSubCategory(SubCategoryModel subCategoryModel){
//   //   _selectedSubCategory = subCategoryModel;
//   // }
// // void changeTappedCategoryState() {
// //   categoryModel.changeClickState();
// //   categoryModel.isTapped
// //       ? emit(SelectedCategoryState.categoryTapped())
// //       : emit(SelectedCategoryState.categoryNotTapped());
// // }
// }
