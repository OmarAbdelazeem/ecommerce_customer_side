import 'package:baqal/src/repository/auth_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:baqal/src/bloc/place_order/place_order.dart';
import 'package:baqal/src/core/utils/connectivity.dart';
import 'package:baqal/src/di/app_injector.dart';
import 'package:baqal/src/models/cartModel_model.dart';
import 'package:baqal/src/models/order_model.dart';
import 'package:baqal/src/notifiers/account_provider.dart';
import 'package:baqal/src/notifiers/cart_status_provider.dart';
import 'package:baqal/src/repository/firestore_repository.dart';
import 'package:baqal/src/res/string_constants.dart';
import 'place_order_state.dart';

class PlaceOrderCubit extends Cubit<PlaceOrderState> {
  var firestoreRepo = getItInstance<FirestoreRepository>();
  var firebaseRep = getItInstance<FirebaseRepository>();
  var accountProvider = getItInstance<AccountProvider>();
  late String orderId;
  PlaceOrderCubit() : super(PlaceOrderState.idle());

  placeOrder(
    CartStatusProvider cartItemStatus,
  ) async {
    emit(PlaceOrderState.orderPlacedInProgress());
    if (await ConnectionStatus.getInstance().checkConnection()) {
      try {
        await firestoreRepo
            .placeOrder(await _orderFromCartList(cartItemStatus));
        await firestoreRepo.emptyCart();
        emit(PlaceOrderState.orderSuccessfullyPlaced());
      } catch (e) {
        emit(PlaceOrderState.orderNotPlaced(e.toString()));
      }
    } else {
      emit(PlaceOrderState.orderNotPlaced(StringsConstants.connectionNotAvailable));
    }
  }

  Future<OrderModel> _orderFromCartList(
    CartStatusProvider cartItemStatus,
  ) async {
    var cartItems = cartItemStatus.cartItems;

    List<OrderItem> getOrderItems() {
      return List<OrderItem>.generate(cartItems.length, (index) {
        CartModel cartModel = cartItems[index];
        return OrderItem(
          name: cartModel.name,
          productId: cartModel.productId,
          price: cartModel.currentPrice,
          image: cartModel.image,
          noOfItems: cartModel.numOfItems,
        );
      });
    }

    orderId =
        "${cartItemStatus.priceInCart}${DateTime.now().millisecondsSinceEpoch}";
    OrderModel orderModel = OrderModel(
        orderId:
            orderId,
        orderItems: getOrderItems(),
        userId: await firebaseRep.getUid(),
        // paymentId: response.paymentId,
        // signature: response.signature,
        total: cartItemStatus.priceInCart,
        orderAddress: accountProvider.addressSelected);
    print(orderModel);
    return orderModel;
  }

  cancelOrder(String orderId) async {
    try {
      await firestoreRepo.cancelOrder(orderId);
    } catch (e) {
      print(e);
    }
  }
}
