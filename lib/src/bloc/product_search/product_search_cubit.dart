import 'package:baqal/src/core/utils/connectivity.dart';
import 'package:baqal/src/core/utils/trim.dart';
import 'package:baqal/src/repository/algolia_repository.dart';
import 'package:baqal/src/res/string_constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:baqal/src/bloc/product_search/product_search.dart';
import 'package:baqal/src/bloc/product_search/product_search_state.dart';
import 'package:baqal/src/di/app_injector.dart';
import 'package:baqal/src/models/product_model.dart';

class ProductSearchCubit extends Cubit<ProductSearchState> {
  var _algoliaRepo = getItInstance<AlgoliaRepository>();
  MyConnectivity _connectivity = MyConnectivity.instance;
  ProductSearchCubit() : super(ProductSearchState.idle());

  searchForProduct(String? productName) async {
    bool hasConnection = await _connectivity.checkInternetConnection();
    if(hasConnection){
      try {
        if (productName != null && productName.length > 1) {
          print('productName is $productName');
          if (TrimUtils.trimSearchName(productName).isNotEmpty) {
            emit(ProductSearchState.loading());
            _algoliaRepo.searchForProduct(productName).listen((products) {
              List<ProductModel> list =
              List<ProductModel>.generate(products.hits.length, (index) {
                print(products.hits[index].data);
                ProductModel productModel =
                ProductModel.fromJson(products.hits[index].data);
                return productModel;
              });

              emit(ProductSearchState.loaded(list));
            });
          }
        } else
          emit(ProductSearchState.loaded([]));
      } catch (e) {
        emit(ProductSearchState.error(e.toString()));
      }
    }else
      emit(ProductSearchState.error(StringsConstants.connectionNotAvailable));

  }

}
