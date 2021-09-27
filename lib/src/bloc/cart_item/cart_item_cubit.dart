import 'package:baqal/src/models/cart_model.dart';
import 'package:baqal/src/models/product_model.dart';
import 'package:baqal/src/notifiers/account_provider.dart';
import 'package:baqal/src/notifiers/cart_status_provider.dart';
import 'package:baqal/src/repository/hive_repsitory.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:baqal/src/core/utils/connectivity.dart';
import 'package:baqal/src/di/app_injector.dart';
import 'package:baqal/src/repository/firestore_repository.dart';
import 'package:baqal/src/res/string_constants.dart';

// import 'package:hive/hive.dart';
import 'cart_item_state.dart';

class CartItemCubit extends Cubit<CartItemState> {
  var _firestoreRepo = getItInstance<FirestoreRepository>();
  final _cartStatusProvider = getItInstance<CartStatusProvider>();
  MyConnectivity _connectivity = MyConnectivity.instance;
  final _accountProvider = getItInstance<AccountProvider>();
  final _hiveRepository = getItInstance<HiveRepository>();

  CartItemCubit() : super(CartItemState.idle());

  updateCartItem(
      CartItemModel cartItem, int cartValue, bool shouldIncrease) async {
    bool hasConnection = await _connectivity.checkInternetConnection();
    if (hasConnection) {
      try {
        int newCartValue = shouldIncrease ? cartValue + 1 : cartValue - 1;
        emit(CartItemState.cartDataLoading());
        if (newCartValue > 0) {
          cartItem.numberOfItems = newCartValue;
          if (_accountProvider.user != null)
            await _firestoreRepo.addItemToOnlineCart(cartItem);
          else
            await _hiveRepository.addItemToLocalCart(cartItem);
          _cartStatusProvider.updateCartItemValue(cartItem.productId, newCartValue);
          emit(CartItemState.showCartValue(newCartValue));
        } else {
          await deleteCartItem(cartItem.productId);
        }
      } catch (e) {
        emit(CartItemState.updateCartError(e.toString(), cartValue));
      }
    } else {
      emit(CartItemState.updateCartError(
          StringsConstants.connectionNotAvailable, cartValue));
    }
  }

  deleteCartItem(String productID) async {
    bool hasConnection = await _connectivity.checkInternetConnection();
    emit(CartItemState.cartDeleteLoading());
    if (hasConnection) {
      try {
        if (_accountProvider.user != null)
          await _firestoreRepo.deleteProductFromCart(productID);
        else
          await _hiveRepository.deleteLocalItemFromCart(productID);
        _cartStatusProvider.deleteCartItem(productID);
        emit(CartItemState.itemDeleted());
      } catch (e) {
        emit(CartItemState.deleteCartError(e.toString()));
      }
    } else
      emit(CartItemState.deleteCartError(
          StringsConstants.connectionNotAvailable));
  }

  void listenToCartItemUpdates(String productId) {
    _firestoreRepo
        .listenToProductUpdates(
      productId,
    )
        .listen((event) async {
      if (event.exists) {
        final product = ProductModel.fromJson(event.data());
        print('product.remainQuantity is ${product.remainQuantity}');
        if (product.remainQuantity! > 0) {
          var cartItem = _cartStatusProvider.updateCartItem(product);
          await _firestoreRepo.addItemToOnlineCart(cartItem);
        } else {
          // delete cart item from database
          _cartStatusProvider.deleteCartItem(productId);
          await _firestoreRepo.deleteProductFromCart(productId);
        }
      }
    });
  }
}
