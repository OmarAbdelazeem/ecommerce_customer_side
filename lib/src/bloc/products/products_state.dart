import 'package:baqal/src/models/product_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'products_state.freezed.dart';

@freezed
abstract class ProductsState with _$ProductsState {
  const factory ProductsState.idle() = Idle;

  const factory ProductsState.fetchingFirstList() = FetchingFirstList;

  const factory ProductsState.loaded(List<ProductModel> products) = Loaded;

  const factory ProductsState.errorWhenFetchingNextList(
      String error, List<ProductModel> products) = ErrorWhenFetchingNextList;

  const factory ProductsState.fetchingNextList() = FetchingNextList;

  const factory ProductsState.runOutOfData() = RunOutOfData;

  const factory ProductsState.error(String error) = Error;
}
