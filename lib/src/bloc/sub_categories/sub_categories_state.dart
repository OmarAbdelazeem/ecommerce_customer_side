import 'package:baqal/src/models/sub_category_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'sub_categories_state.freezed.dart';

@freezed
abstract class SubCategoriesState with _$SubCategoriesState {
  const factory SubCategoriesState.idle() = Idle;

  const factory SubCategoriesState.loading() = Loading;

  const factory SubCategoriesState.loaded(
      List<SubCategoryModel> subCategories) = Loaded;

  const factory SubCategoriesState.error(String error) = Error;
}
