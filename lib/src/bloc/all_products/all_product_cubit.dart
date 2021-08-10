import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:baqal/src/bloc/base_states/result_state/result_state.dart';
import 'package:baqal/src/di/app_injector.dart';
import 'package:baqal/src/models/product_model.dart';
import 'package:baqal/src/repository/firestore_repository.dart';

class AllProductCubit extends Cubit<ResultState<List<ProductModel>>> {
  var _firestoreRepo = getItInstance<FirestoreRepository>();

  AllProductCubit() : super(ResultState.idle());
  late List<DocumentSnapshot> documents;
  late List<ProductModel> productList;

  fetchProducts([String ? condition])async{
    emit(ResultState.loading());
    try {
      if (condition == null) {
        documents = await _firestoreRepo.getAllProducts();
      } else {
        documents = await _firestoreRepo.getAllProducts(condition: condition);
      }
      productList = List<ProductModel>.generate(
          documents.length, (index) => ProductModel.fromJson(documents[index]));
      List.generate(productList.length, (index) {
        print(productList[index].name);
      });
      print(productList.length);
      emit(ResultState.data(data: productList.toSet().toList()));
    } catch (e) {
      emit(ResultState.error(error: e.toString()));
    }
  }

  fetchNextList([String ? condition]) async {
    try {
      List<DocumentSnapshot> docs =
          await _firestoreRepo.getAllProducts(documentSnapshot: documents[documents.length - 1]);

      documents.addAll(docs);
      productList = List<ProductModel>.generate(
          documents.length, (index) => ProductModel.fromJson(documents[index]));
      List.generate(productList.length, (index) {
        print(productList[index].name);
      });
      print(productList.length);
      emit(ResultState.data(data: productList.toSet().toList()));
    } catch (e) {
      print(e);
      emit(ResultState.unNotifiedError(error: e.toString(), data: productList));
    }
  }
}
