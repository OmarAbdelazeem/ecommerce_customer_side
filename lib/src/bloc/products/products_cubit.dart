// import 'package:baqal/src/core/utils/trim.dart';
// import 'package:baqal/src/models/name_field.dart';
// import 'package:baqal/src/models/sub_category_model.dart';
// import 'package:baqal/src/repository/algolia_repository.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:baqal/src/bloc/base_states/result_state/result_state.dart';
// import 'package:baqal/src/di/app_injector.dart';
// import 'package:baqal/src/models/product_model.dart';
// import 'package:baqal/src/repository/firestore_repository.dart';
//
// class ProductsCubit extends Cubit<ResultState<List<ProductModel>>> {
//   var _firestoreRepo = getItInstance<FirestoreRepository>();
//
//   ProductsCubit() : super(ResultState.idle());
//   late List<DocumentSnapshot> _documents;
//   late List<ProductModel> productList;
//
//   fetchProducts(NameField subCategoryName) async {
//     emit(ResultState.loading());
//     try {
//       _documents =
//           await _firestoreRepo.fetchProducts(subCategoryName: subCategoryName);
//
//       productList = List<ProductModel>.generate(_documents.length,
//           (index) => ProductModel.fromJson(_documents[index].data()));
//
//       List.generate(productList.length, (index) {
//         print(productList[index].name);
//       });
//       print(productList.length);
//       emit(ResultState.data(data: productList.toSet().toList()));
//     } catch (e) {
//       emit(ResultState.error(error: e.toString()));
//     }
//   }
//
//   fetchTopProducts() async {
//     emit(ResultState.loading());
//     try {
//       _documents = await _firestoreRepo.fetchTopProducts();
//
//       productList = List<ProductModel>.generate(_documents.length,
//           (index) => ProductModel.fromJson(_documents[index].data()));
//
//       List.generate(productList.length, (index) {
//         print(productList[index].name);
//       });
//       emit(ResultState.data(data: productList.toSet().toList()));
//     } catch (e) {}
//   }
//
//   fetchBannerProducts(NameField banner) async {
//     emit(ResultState.loading());
//     try {
//       _documents = await _firestoreRepo.fetchProducts(bannerName: banner );
//
//       productList = List<ProductModel>.generate(_documents.length,
//           (index) => ProductModel.fromJson(_documents[index].data()));
//
//       List.generate(productList.length, (index) {
//         print(productList[index].name);
//       });
//       print(productList.length);
//       emit(ResultState.data(data: productList.toSet().toList()));
//     } catch (e) {
//       emit(ResultState.error(error: e.toString()));
//     }
//   }
//
//   fetchNextList(NameField subCategoryName) async {
//     print('fetchNextList');
//     try {
//       List<DocumentSnapshot> docs = await _firestoreRepo.fetchProducts(
//           documentSnapshot: _documents[_documents.length - 1],
//           subCategoryName: subCategoryName);
//
//       _documents.addAll(docs);
//
//       productList = List<ProductModel>.generate(_documents.length,
//           (index) => ProductModel.fromJson(_documents[index]));
//
//       List.generate(productList.length, (index) {
//         print(productList[index].name);
//       });
//
//       print(productList.length);
//
//       emit(ResultState.data(data: productList.toSet().toList()));
//
//     } catch (e) {
//       print(e);
//       emit(ResultState.unNotifiedError(error: e.toString(), data: productList));
//     }
//   }
// }

import 'package:baqal/src/bloc/products/products.dart';
import 'package:baqal/src/core/utils/trim.dart';
import 'package:baqal/src/models/name_field.dart';
import 'package:baqal/src/models/sub_category_model.dart';
import 'package:baqal/src/repository/algolia_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:baqal/src/bloc/base_states/result_state/result_state.dart';
import 'package:baqal/src/di/app_injector.dart';
import 'package:baqal/src/models/product_model.dart';
import 'package:baqal/src/repository/firestore_repository.dart';

class ProductsCubit extends Cubit<ProductsState> {
  var _firestoreRepo = getItInstance<FirestoreRepository>();

  ProductsCubit() : super(ProductsState.idle());
  late List<DocumentSnapshot> _documents;
  late List<ProductModel> productList;

  fetchProducts(String filterId) async {
    emit(ProductsState.fetchingFirstList());
    try {
      _documents =
          await _firestoreRepo.fetchProducts(filterId: filterId);

      productList = List<ProductModel>.generate(_documents.length,
          (index) => ProductModel.fromJson(_documents[index].data()));

      List.generate(productList.length, (index) {
        print(productList[index].name.english);
      });
      print(productList.length);
      emit(ProductsState.loaded(productList.toSet().toList()));
    } catch (e) {
      emit(ProductsState.error(e.toString()));
    }
  }

  Future<ProductModel?> getProductData(String productId)async
  {
    try{
    var productDocumentSnapshot = await _firestoreRepo.getProductData(productId);
    ProductModel product = ProductModel.fromJson(productDocumentSnapshot.data());
    return product;
    }catch(e){
      print(e);
      return null;
    }
  }

  fetchTopProducts() async {
    emit(ProductsState.fetchingFirstList());
    try {
      _documents = await _firestoreRepo.fetchTopProducts();

      productList = List<ProductModel>.generate(_documents.length,
          (index) => ProductModel.fromJson(_documents[index].data()));

      List.generate(productList.length, (index) {
        print(productList[index].name);
      });
      emit(ProductsState.loaded(productList.toSet().toList()));
    } catch (e) {}
  }


  fetchNextList(String filterId) async {
    print('fetchNextList');
    try {
      List<DocumentSnapshot> docs = await _firestoreRepo.fetchProducts(
          documentSnapshot: _documents[_documents.length - 1],
          filterId: filterId);

      _documents.addAll(docs);

      productList = List<ProductModel>.generate(_documents.length,
              (index) => ProductModel.fromJson(_documents[index]));

      emit(ProductsState.loaded(productList.toSet().toList()));
    } catch (e) {
      print(e);
      emit(ProductsState.errorWhenFetchingNextList(e.toString(), productList));
    }
  }
}
