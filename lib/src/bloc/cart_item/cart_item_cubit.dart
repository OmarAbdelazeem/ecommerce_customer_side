import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:baqal/src/core/utils/connectivity.dart';
import 'package:baqal/src/di/app_injector.dart';
import 'package:baqal/src/models/cartModel_model.dart';
import 'package:baqal/src/repository/firestore_repository.dart';
import 'package:baqal/src/res/string_constants.dart';
import 'cart_item_state.dart';

class CartItemCubit extends Cubit<CartItemState> {
  var _firebaseRepo = getItInstance<FirestoreRepository>();

  CartItemCubit() : super(CartItemState.idle());

  initCartValues(int cartValue) {
    emit(CartItemState.showCartValue(cartValue));
  }

  updateCartValues(
      CartModel cartModel, int cartValue, bool shouldIncrease) async {
    int newCartValue = shouldIncrease ? cartValue + 1 : cartValue - 1;
    emit(CartItemState.cartDataLoading());
    if (newCartValue > 0) {
      if (!(await ConnectionStatus.getInstance().checkConnection())) {
        emit(CartItemState.updateCartError(
            StringsConstants.connectionNotAvailable, cartValue));
        return;
      }
      cartModel.numOfItems = newCartValue;
      _firebaseRepo.addProductToCart(cartModel).then((value) {
        emit(CartItemState.showCartValue(newCartValue));
      }).catchError((e) {
        emit(CartItemState.updateCartError(e.toString(), cartValue));
      });
    } else {
      deleteItem(cartModel, deleteExternally: false);
    }
  }

  deleteItem(CartModel cartModel, {bool deleteExternally = true}) async {
    if (deleteExternally) {
      emit(CartItemState.cartDeleteLoading());
    }
    if (!(await ConnectionStatus.getInstance().checkConnection())) {
      emit(CartItemState.deleteCartError(StringsConstants.connectionNotAvailable));
      return;
    }
    _firebaseRepo.delProductFromCart(cartModel.productId).then((value) {
      emit(CartItemState.itemDeleted());
    }).catchError((e) {
      emit(CartItemState.deleteCartError(e.toString()));
    });
  }
}
