import 'package:baqal/src/models/cart_model.dart';
import 'package:baqal/src/models/product_model.dart';
import 'package:flutter/cupertino.dart';

class CartStatusProvider with ChangeNotifier {
  List _cartItems = [];

  int get noOfItemsInCart => cartItems.length;

  num get priceInCart {
    num price = 0;
    List.generate(cartItems.length, (index) {
      price = price + (cartItems[index].price * cartItems[index].numberOfItems);
    });
    return price;
  }

  List get cartItems => _cartItems;

  updateCartItemValue(String itemId, int value) {
    var item = _cartItems.where((item) => item.productId == itemId).toList();
    if (item.isNotEmpty) item[0].numberOfItems = value;
    notifyListeners();
  }

  emptyingCart(){
    _cartItems = [];
    notifyListeners();
  }

  //  listenToItem(String itemId){
  //   _cartItems.
  //  // var item =  _cartItems.where((element) => element.productId == itemId).toList();
  //
  // }

  deleteCartItem(String itemId) {
    _cartItems.removeWhere((item) => item.productId == itemId);
    notifyListeners();
  }

  updateCartItem(ProductModel product) {
    int numberOfItems = 0;
    int index = _cartItems.indexWhere((cartItem) {
      if (cartItem.productId == product.productId) {
        numberOfItems = cartItem.numberOfItems;
        return true;
      }
      return false;
    });
    if (index >= 0) {
      _cartItems[index] = CartItemModel.fromProduct(product, numberOfItems);
      notifyListeners();
      return _cartItems[index];
    }
  }

  void addItem(CartItemModel cartItem){
    print('add item is called');
    _cartItems.add(cartItem);
    notifyListeners();
  }

 CartItemModel? checkIfCartItemIsExist(String cartItemId) {
   var items = _cartItems.where((element) => element.productId == cartItemId).toList();
   if(items.isNotEmpty)
     return items[0];
   else return null;
  }

  set cartItems(List value) {
    _cartItems = value;
    notifyListeners();
  }
}

// import 'package:baqal/src/models/cart_model.dart';
// import 'package:baqal/src/models/product_model.dart';
// import 'package:flutter/cupertino.dart';
//
// class CartStatusProvider with ChangeNotifier {
//   List<CartItemModel> cartItems = [];
//   late int currentCartItemNumber;
//   late int _currentCartItemIndex;
//
//   void addCartItem(ProductModel product) {
//     currentCartItemNumber = checkIfCartItemIsPresent(product.productId);
//     if (currentCartItemNumber > 0) {
//       currentCartItemNumber += 1;
//       cartItems[_currentCartItemIndex].numberOfItems = currentCartItemNumber;
//     } else {
//       cartItems.add(CartItemModel.fromProduct(product, 1));
//       currentCartItemNumber = 1;
//     }
//   }
//
//   int checkIfCartItemIsPresent(String productId) {
//     int cartItemIndex =
//         cartItems.indexWhere((cartItem) => cartItem.productId == productId);
//     if (cartItemIndex >= 0) {
//       _currentCartItemIndex = cartItemIndex;
//       return cartItems[cartItemIndex].numberOfItems;
//     } else
//       return 0;
//   }
// }
