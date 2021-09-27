
import 'package:baqal/src/models/main_category_model.dart';
import 'package:baqal/src/models/sub_category_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'main_categories_state.freezed.dart';

@freezed
abstract class MainCategoriesState with _$MainCategoriesState {
  const factory MainCategoriesState.idle() = Idle;
  //
  const factory MainCategoriesState.loading() = Loading;

  const factory MainCategoriesState.loaded(List<MainCategoryModel> mainCategories) = Loaded;

  const factory MainCategoriesState.mainCategorySelected(
      MainCategoryModel mainCategoryModel) = MainCategorySelected;
  //
  const factory MainCategoriesState.subCategorySelected(
      SubCategoryModel subCategoryModel) = SubCategorySelected;
  //
  const factory MainCategoriesState.error(String error) = Error;
}
