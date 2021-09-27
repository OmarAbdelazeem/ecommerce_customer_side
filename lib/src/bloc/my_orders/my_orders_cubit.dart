import 'package:baqal/src/core/utils/connectivity.dart';
import 'package:baqal/src/models/basic_order_model.dart';
import 'package:baqal/src/notifiers/account_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:baqal/src/bloc/base_states/result_state/result_state.dart';
import 'package:baqal/src/di/app_injector.dart';
import 'package:baqal/src/repository/firestore_repository.dart';

class MyOrdersCubit extends Cubit<ResultState<List<BasicOrderModel>>> {
  var _firestoreRepo = getItInstance<FirestoreRepository>();
  final _accountProvider = getItInstance<AccountProvider>();

  MyOrdersCubit() : super(ResultState.idle());
  late List<DocumentSnapshot> _documents;
  late List<BasicOrderModel> _orderList;
  late Stream<QuerySnapshot<Object?>> ordersQuerySnapshot;
  MyConnectivity _connectivity = MyConnectivity.instance;

  listenToOrders() async{
    bool hasConnection = await _connectivity.checkInternetConnection();

    if(hasConnection){
      emit(ResultState.loading());
      try {
        ordersQuerySnapshot =
            _firestoreRepo.listenToOrders(userId: _accountProvider.user!.uid);

        ordersQuerySnapshot.listen((querySnapshot) {
          _documents = querySnapshot.docs;
          _orderList = List<BasicOrderModel>.generate(_documents.length,
                  (index) => BasicOrderModel.fromJson(_documents[index].data()));
          print('querySnapshot is ${querySnapshot.docs}');
          querySnapshot.docChanges.forEach((DocumentChange change) {
            int changedOrderIndex = _orderList
                .indexWhere((order) => order.orderId == (change.doc['order_id']));
            if (changedOrderIndex >= 0) {
              _orderList[changedOrderIndex] =
                  BasicOrderModel.fromJson(change.doc.data());
            }
          });
          emit(ResultState.data(data: _orderList));
        });
      } catch (e) {
        print(e);
      }
    }
  }

  fetchNextList() async {
    try {
      ordersQuerySnapshot = _firestoreRepo.listenToOrders(
          userId: _accountProvider.user!.uid,
          documentSnapshot: _documents[_documents.length - 1]);

      ordersQuerySnapshot.listen((querySnapshot) {
        _documents.addAll(querySnapshot.docs);

        _orderList = List<BasicOrderModel>.generate(_documents.length,
            (index) => BasicOrderModel.fromJson(_documents[index].data()));

        print('querySnapshot is ${querySnapshot.docs}');

        querySnapshot.docChanges.forEach((DocumentChange change) {
          int changedOrderIndex = _orderList
              .indexWhere((order) => order.orderId == (change.doc['order_id']));

          if (changedOrderIndex >= 0) {
            _orderList[changedOrderIndex] =
                BasicOrderModel.fromJson(change.doc.data());
          }
        });

        emit(ResultState.data(data: _orderList));
      });
    } catch (e) {
      print(e);
      emit(ResultState.unNotifiedError(error: e.toString(), data: _orderList));
    }
  }
}
