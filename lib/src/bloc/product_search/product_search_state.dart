import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:baqal/src/models/product_model.dart';

part 'product_search_state.freezed.dart';

@freezed
abstract class ProductSearchState with _$ProductSearchState {
  const factory ProductSearchState.idle() = Idle;

  const factory ProductSearchState.loaded(List<ProductModel> products) =
      Loaded;

  const factory ProductSearchState.loading() = Loading;

  const factory ProductSearchState.error(String error) = Error;
}
