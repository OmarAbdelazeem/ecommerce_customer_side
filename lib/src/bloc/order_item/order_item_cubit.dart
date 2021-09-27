import 'package:baqal/src/core/utils/connectivity.dart';
import 'package:baqal/src/di/app_injector.dart';
import 'package:baqal/src/models/order_model.dart';
import 'package:baqal/src/notifiers/account_provider.dart';
import 'package:baqal/src/repository/firestore_repository.dart';
import 'package:baqal/src/res/string_constants.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'order_item_state.dart';

class OrderCubit extends Cubit<OrderItemState> {
  OrderCubit() : super(OrderItemState.idle());
  var _firestoreRepo = getItInstance<FirestoreRepository>();
 late Stream<DocumentSnapshot> orderQuerySnapshot;
  final accountProvider = getItInstance<AccountProvider>();
  MyConnectivity _connectivity = MyConnectivity.instance;

  listenToOrderDetails(String id) {
    emit(OrderItemState.loading());
    try {
      orderQuerySnapshot = _firestoreRepo.fetchOrderDetails(id);
      orderQuerySnapshot.listen((event) {
        OrderModel order = OrderModel.fromJson(event.data());
        emit(OrderItemState.loaded(order));
      });
    } catch (e) {
      print(e);
      emit(OrderItemState.error(e.toString()));
    }
  }

  Future cancelOrder(String orderId )async{
    bool hasConnection = await _connectivity.checkInternetConnection();
    if(hasConnection){
      try{
        await _firestoreRepo.cancelOrder(orderId);
      }catch(e){print(e);}
    }

  }


}
