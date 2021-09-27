// import 'package:baqal/src/di/app_injector.dart';
// import 'package:baqal/src/repository/firestore_repository.dart';
// import 'package:baqal/src/res/string_constants.dart';
// import 'package:bloc/bloc.dart';
// import 'package:ecommerce_admin_tut/src/di/app_injector.dart';
// import 'package:ecommerce_admin_tut/src/notifiers/orders_notifier.dart';
// import 'package:ecommerce_admin_tut/src/repository/firestore_repository.dart';
// import 'package:ecommerce_admin_tut/src/res/string_constants.dart';
// import 'package:flutter/foundation.dart';
//
// import  'order_status_state.dart';
//
// class OrderStatusCubit extends Cubit<OrderStatusState> {
//   OrderStatusCubit() : super(OrderStatusState.idle());
//   var _firestoreRepo = getItInstance<FirestoreRepository>();
//
//   void updateOrderStatus(
//       {@required String? status, @required String? orderId}) async {
//     emit(OrderStatusState.loading());
//     try {
//       // add order number
//       if (status == StringsConstants.delivering) {
//         int orderNumber = await _firestoreRepo.getOrderNumber(orderId!);
//
//         await _firestoreRepo.updateOrderStatus(status!, orderId, orderNumber);
//       } else if (status == StringsConstants.delivered ||
//           status == StringsConstants.cancelled) {
//         await _firestoreRepo.updateOrderStatus(status!, orderId!);
//       }
//
//       emit(OrderStatusState.loaded(status!));
//     } catch (e) {
//       print(e);
//       // emit(OrderStatusState.error(e));
//     }
//   }
//
// }
