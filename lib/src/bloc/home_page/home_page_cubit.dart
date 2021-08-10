import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:baqal/src/bloc/base_states/result_state/result_state.dart';
import 'package:baqal/src/core/utils/connectivity.dart';
import 'package:baqal/src/di/app_injector.dart';
import 'package:baqal/src/models/product_model.dart';
import 'package:baqal/src/repository/auth_repository.dart';
import 'package:baqal/src/repository/firestore_repository.dart';
import 'package:baqal/src/res/string_constants.dart';

enum ProductData { DealOfTheDay, OnSale, TopProducts }

class ProductDataCubit extends Cubit<ResultState<List<ProductModel>>> {
  var repo = getItInstance<FirestoreRepository>();
  var authRepo = getItInstance<FirebaseRepository>();

  ProductDataCubit() : super(ResultState.idle());

  fetchProductData(ProductData productData) async {
    emit(ResultState.loading());

    try {
      if (!(await ConnectionStatus.getInstance().checkConnection())) {
        emit(ResultState.error(error: StringsConstants.connectionNotAvailable));
        return;
      }
      String condition;
      switch (productData) {
        case ProductData.DealOfTheDay:
          condition = "deal_of_the_day";
          break;
        case ProductData.OnSale:
          condition = "on_sale";
          break;
        case ProductData.TopProducts:
          condition = "top_products";
          break;
      }
      List<ProductModel> productList = await repo.getProductsData(condition);
      emit(ResultState.data(data: productList));
    } catch (e) {
      emit(ResultState.error(error: e.toString()));
    }
  }
}
