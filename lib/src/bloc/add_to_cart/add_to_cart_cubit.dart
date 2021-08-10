import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:baqal/src/bloc/add_to_cart/add_to_cart_state.dart';
import 'package:baqal/src/core/utils/connectivity.dart';
import 'package:baqal/src/di/app_injector.dart';
import 'package:baqal/src/models/cartModel_model.dart';
import 'package:baqal/src/models/product_model.dart';
import 'package:baqal/src/repository/auth_repository.dart';
import 'package:baqal/src/repository/firestore_repository.dart';
import 'package:baqal/src/res/string_constants.dart';
import 'add_to_cart_state.dart';

class AddToCartCubit extends Cubit<AddToCartState> {
  var _firebaseRepo = getItInstance<FirestoreRepository>();
  var _authRepo = getItInstance<FirebaseRepository>();

  AddToCartCubit() : super(AddToCartState.showAddButton());

  listenToProduct(String productId) async {
    _firebaseRepo.cartStatusListen(await _authRepo.getUid()).listen((event) {
      checkItemInCart(productId, isListening: true);
    });
  }

  checkItemInCart(String productId, {bool isListening = false}) async {
    if (!isListening) {
      emit(AddToCartState.addToCardLoading());
    }
    int cartValue = await _firebaseRepo.checkItemInCart(productId);
    if (cartValue > 0) {
      emit(AddToCartState.showCartValue(cartValue));
    } else {
      emit(AddToCartState.showAddButton());
    }
  }

  addToCart(ProductModel productModel) async {
    emit(AddToCartState.addToCardLoading());
    if (!(await ConnectionStatus.getInstance().checkConnection())) {
      emit(AddToCartState.addToCartError(StringsConstants.connectionNotAvailable));
      return;
    }
    CartModel cartModel = CartModel.fromProduct(productModel, 1);
    _firebaseRepo.addProductToCart(cartModel).then((value) {
      emit(AddToCartState.showCartValue(1));
    }).catchError((e) {
      emit(AddToCartState.addToCartError(e.toString()));
    });
  }

  updateCartValues(
      ProductModel productModel, int cartValue, bool shouldIncrease) async {
    int newCartValue = shouldIncrease ? cartValue + 1 : cartValue - 1;
    emit(AddToCartState.cartDataLoading());

    if (newCartValue > 0) {
      if (!(await ConnectionStatus.getInstance().checkConnection())) {
        emit(AddToCartState.updateCartError(
            StringsConstants.connectionNotAvailable, cartValue));
        return;
      }
      CartModel cartModel = CartModel.fromProduct(productModel, newCartValue);
      _firebaseRepo.addProductToCart(cartModel).then((value) {
        emit(AddToCartState.showCartValue(newCartValue));
      }).catchError((e) {
        emit(AddToCartState.updateCartError(e.toString(), cartValue));
      });
    } else {
      if (!(await ConnectionStatus.getInstance().checkConnection())) {
        emit(AddToCartState.deleteCartError(StringsConstants.connectionNotAvailable));
        return;
      }
      _firebaseRepo.delProductFromCart(productModel.productId).then((value) {
        emit(AddToCartState.showAddButton());
      }).catchError((e) {
        emit(AddToCartState.deleteCartError(e.toString()));
      });
    }
  }
}
