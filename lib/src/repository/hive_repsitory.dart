import 'package:baqal/src/models/cart_model.dart';
import 'package:hive/hive.dart';

class HiveRepository {
  late Box _box;

  void _getOpenedBox() {
    _box = Hive.box('cart');
  }

  // void openBox()async{
  //   _box = await Hive.openBox('cart');
  // }

  addItemToLocalCart(CartItemModel cart) async {
    try {
      _getOpenedBox();
      await _box.put(cart.productId, cart);
    } catch (e) {
      print(e.toString());
    }
  }

 List getLocalCartItems(){
    _getOpenedBox();
  return _box.values.toList();
  }

  emptyingLocalCart()async{
    _getOpenedBox();
   await _box.clear();
  }

  Stream<Box> listenToLocalCart() {
    return Hive.openBox('cart').asStream();
  }

  Stream<BoxEvent> listenToLocalCartItem(String cartItemId) {
    _getOpenedBox();
    print('from local listening to cart item');
    return _box.watch(key: cartItemId);
  }

  getCartItem(String productId){
    _getOpenedBox();
    _box.get(productId);
  }

  updateLocalCartItem(CartItemModel cart) async {
    _getOpenedBox();
    await _box.put(cart.productId, cart);
  }

  deleteLocalItemFromCart(String productId) async {
    _getOpenedBox();
    await _box.delete(productId);
  }
}
