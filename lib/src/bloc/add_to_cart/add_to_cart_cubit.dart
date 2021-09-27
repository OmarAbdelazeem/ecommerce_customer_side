import 'package:baqal/src/models/cart_model.dart';
import 'package:baqal/src/notifiers/account_provider.dart';
import 'package:baqal/src/notifiers/cart_status_provider.dart';
import 'package:baqal/src/repository/hive_repsitory.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:baqal/src/bloc/add_to_cart/add_to_cart_state.dart';
import 'package:baqal/src/core/utils/connectivity.dart';
import 'package:baqal/src/di/app_injector.dart';
import 'package:baqal/src/models/product_model.dart';
import 'package:baqal/src/repository/auth_repository.dart';
import 'package:baqal/src/repository/firestore_repository.dart';
import 'package:baqal/src/res/string_constants.dart';
import 'add_to_cart_state.dart';

class AddToCartCubit extends Cubit<AddToCartState> {
  var _firestoreRepo = getItInstance<FirestoreRepository>();
  var _firebaseRepo = getItInstance<FirebaseRepository>();
  var _hiveRepository = getItInstance<HiveRepository>();
  var _cartStatusProvider = getItInstance<CartStatusProvider>();
  var _accountProvider = getItInstance<AccountProvider>();
  MyConnectivity _connectivity = MyConnectivity.instance;

  AddToCartCubit() : super(AddToCartState.showAddButton());

  addItemToCart(ProductModel product) async {
    bool hasConnection = await _connectivity.checkInternetConnection();
    if (!hasConnection) {
      emit(AddToCartState.addToCartError(
          StringsConstants.connectionNotAvailable));
      return;
    } else {
      emit(AddToCartState.addToCardLoading());
      CartItemModel cart = CartItemModel.fromProduct(product, 1);
      print(
          'first cartProvider.noOfItemsInCart is ${_cartStatusProvider.noOfItemsInCart}');
      try {
        if (_accountProvider.user != null)
          await _firestoreRepo.addItemToOnlineCart(cart);
        else{
          await _hiveRepository.addItemToLocalCart(cart);
          _cartStatusProvider.addItem(cart);
        }


        print(
            'second cartProvider.noOfItemsInCart is ${_cartStatusProvider.noOfItemsInCart}');
        _cartStatusProvider.cartItems.forEach((element) {
          print('element is ${element.name.english} , ${element.numberOfItems}');
        });
        emit(AddToCartState.showCartValue(1));
      } catch (e) {
        emit(AddToCartState.addToCartError(e.toString()));
      }
    }
  }

  updateCartItem(
      ProductModel product, int cartValue, bool shouldIncrease) async {
    bool hasConnection = await _connectivity.checkInternetConnection();
    if (hasConnection) {
      int newCartValue = shouldIncrease ? cartValue + 1 : cartValue - 1;
      emit(AddToCartState.cartDataLoading());

      if (newCartValue > 0) {
        CartItemModel cart = CartItemModel.fromProduct(product, newCartValue);
        try {
          if (_accountProvider.user != null)
            await _firestoreRepo.addItemToOnlineCart(cart);
          else
            await _hiveRepository.addItemToLocalCart(cart);
          _cartStatusProvider.updateCartItemValue(cart.productId, newCartValue);
          emit(AddToCartState.showCartValue(newCartValue));
        } catch (e) {
          emit(AddToCartState.updateCartError(e.toString(), cartValue));
        }
      } else {
        try {
          if (_accountProvider.user != null)
            await _firestoreRepo.deleteProductFromCart(product.productId);
          else
            await _hiveRepository.deleteLocalItemFromCart(product.productId);
          _cartStatusProvider.deleteCartItem(product.productId);
        } catch (e) {
          emit(AddToCartState.deleteCartError(e.toString()));
        }
      }
    } else {
      emit(AddToCartState.updateCartError(
          StringsConstants.connectionNotAvailable, cartValue));
    }
  }

  void listenToCart() async {
    if (_accountProvider.user != null) {
      _firestoreRepo
          .cartStatusListen((await _firebaseRepo.getCurrentUser())!.uid)
          .listen((event) {
        var numberOfItemsInCart = event.docs.length;
        if (numberOfItemsInCart > 0) {
          _cartStatusProvider.cartItems =
              List<CartItemModel>.generate(event.docs.length, (index) {
            DocumentSnapshot documentSnapshot = event.docs[index];
            return CartItemModel.fromJson(documentSnapshot);
          });
        } else {
          _cartStatusProvider.cartItems = [];
        }
      });
    } else {
      _hiveRepository.listenToLocalCart().listen((event) {
        _cartStatusProvider.cartItems = event.values.toList();
      });
    }
  }

  void listenToCartItem(String productId) async {
    CartItemModel? cartItem;
    if (_accountProvider.user != null) {
      _firestoreRepo
          .listenToCartItem(
              productId: productId,
              userId: (await _firebaseRepo.getCurrentUser())!.uid)
          .listen((event) {
        if (event.exists) {
          cartItem = CartItemModel.fromJson(event.data());
          emit(AddToCartState.showCartValue(cartItem!.numberOfItems));
        } else {
          emit(AddToCartState.showAddButton());
        }
      });
    } else {
      // Todo implement listen to local cart item

      // get item from cart status provider
      cartItem = _cartStatusProvider.checkIfCartItemIsExist(productId);
      if (cartItem != null && cartItem.numberOfItems > 0)
        emit(AddToCartState.showCartValue(cartItem.numberOfItems));

      _hiveRepository.listenToLocalCartItem(productId).listen((event) {
        if (event.value != null) {
          CartItemModel cartItem = event.value;
          if (cartItem.numberOfItems > 0) {
            emit(AddToCartState.showCartValue(cartItem.numberOfItems));
          }
        } else {
          emit(AddToCartState.showAddButton());
        }
      });
    }
  }

  transformItemsFromLocalCartToOnlineCart() async {
    print('transformItemsFromLocalCartToOnlineCart()');
    final localCartItems = _hiveRepository.getLocalCartItems();
    if (localCartItems.isNotEmpty) {
      localCartItems.forEach((item) async {
        print('item is $item');
        final onlineCartItem = await _firestoreRepo.getCartItem(item.productId);
        if (onlineCartItem != null){
          print('onlineCartItem != null');
          item.numberOfItems +=
              CartItemModel.fromJson(onlineCartItem.data()).numberOfItems;
          print('item.numberOfItems increased by one');
        }

        await _firestoreRepo.addItemToOnlineCart(item);
      });
     await _hiveRepository.emptyingLocalCart();
    }
  }
}
