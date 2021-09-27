import 'package:baqal/src/models/cart_model.dart';
import 'package:baqal/src/notifiers/account_provider.dart';
import 'package:baqal/src/notifiers/addresses_provider.dart';
import 'package:baqal/src/repository/auth_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:baqal/src/bloc/place_order/place_order.dart';
import 'package:baqal/src/core/utils/connectivity.dart';
import 'package:baqal/src/di/app_injector.dart';
import 'package:baqal/src/models/order_model.dart';
import 'package:baqal/src/notifiers/cart_status_provider.dart';
import 'package:baqal/src/repository/firestore_repository.dart';
import 'package:baqal/src/res/string_constants.dart';
import 'place_order_state.dart';

class PlaceOrderCubit extends Cubit<PlaceOrderState> {
  var _firestoreRepo = getItInstance<FirestoreRepository>();
  var _accountProvider = getItInstance<AccountProvider>();
  var _addressesProvider = getItInstance<AddressesProvider>();
  MyConnectivity _connectivity = MyConnectivity.instance;
  late String orderId;

  PlaceOrderCubit() : super(PlaceOrderState.idle());

  placeOrder(
    CartStatusProvider cartItemStatus,
  ) async {
    bool hasConnection = await _connectivity.checkInternetConnection();

    if (hasConnection) {
      emit(PlaceOrderState.loading());
      try {
        await _firestoreRepo
            .placeOrder(await _orderFromCartList(cartItemStatus));
        await _firestoreRepo.emptyCart();
        emit(PlaceOrderState.orderSuccessfullyPlaced());
      } catch (e) {
        emit(PlaceOrderState.error(e.toString()));
      }
    } else {
      emit(PlaceOrderState.error(StringsConstants.connectionNotAvailable));
    }
  }

  Future<OrderModel> _orderFromCartList(
    CartStatusProvider cartItemStatus,
  ) async {
    var cartItems = cartItemStatus.cartItems;

    List<OrderItem> getOrderItems() {
      return List<OrderItem>.generate(cartItems.length, (index) {
        CartItemModel cartModel = cartItems[index];
        return OrderItem(
          customerId: _accountProvider.user!.uid,
          name: cartModel.name,
          productId: cartModel.productId,
          price: cartModel.price,
          image: cartModel.image,
          noOfItems: cartModel.numberOfItems,
        );
      });
    }

    orderId =
        "${cartItemStatus.priceInCart}${DateTime.now().millisecondsSinceEpoch}";
    OrderModel orderModel = OrderModel(
        orderId: orderId,
        orderItems: getOrderItems(),
        customerId: _accountProvider.user!.uid,
        total: cartItemStatus.priceInCart,
        orderAddress: _addressesProvider.selectedAddress!);
    print(orderModel);
    return orderModel;
  }

  cancelOrder(String orderId) async {
    bool hasConnection = await _connectivity.checkInternetConnection();
    if (hasConnection) {
      try {
        await _firestoreRepo.cancelOrder(orderId);
        emit(PlaceOrderState.orderCanceled());
      } catch (e) {
        print(e);
      }
    } else {
      emit(PlaceOrderState.error(StringsConstants.connectionNotAvailable));
    }
  }
}
