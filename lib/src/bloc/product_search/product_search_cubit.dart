import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:baqal/src/bloc/product_search/product_search.dart';
import 'package:baqal/src/bloc/product_search/product_search_state.dart';
import 'package:baqal/src/di/app_injector.dart';
import 'package:baqal/src/models/product_model.dart';
import 'package:baqal/src/repository/firestore_repository.dart';

class ProductSearchCubit extends Cubit<ProductSearchState> {
  var firebaseRepo = getItInstance<FirestoreRepository>();

  ProductSearchCubit() : super(ProductSearchState.idle());

  searchProduct(String query) async {
    emit(ProductSearchState.loading());
    try {
      var productSnapshot = await firebaseRepo.searchProducts(query);

      List<ProductModel> list =
          List<ProductModel>.generate(productSnapshot.length, (index) {
        ProductModel productModel =
            ProductModel.fromJson(productSnapshot[index]);
        return productModel;
      });
      emit(ProductSearchState.productList(list));
    } catch (e) {
      print(e.toString());
      emit(ProductSearchState.error());
    }
  }
}
