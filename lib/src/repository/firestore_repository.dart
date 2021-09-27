import 'package:baqal/src/models/name_field.dart';
import 'package:baqal/src/notifiers/account_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:baqal/src/di/app_injector.dart';
import 'package:baqal/src/models/account_details_model.dart';
import 'package:baqal/src/models/cart_model.dart';
import 'package:baqal/src/models/order_model.dart';
import 'package:baqal/src/models/basic_order_model.dart';
import 'package:baqal/src/models/product_model.dart';
import 'auth_repository.dart';

class FirestoreRepository {
  var _firebaseRepo = getItInstance<FirebaseRepository>();
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  AccountProvider _accountProvider = getItInstance<AccountProvider>();

  Future<DocumentSnapshot?> getCartItem(String itemId) async{
   final cartItemSnapShot = await _firestore
        .collection('customers').doc('details').collection('customers')
        .doc(_accountProvider.user!.uid)
        .collection('cart')
        .doc(itemId)
        .get();
   if(cartItemSnapShot.exists)
     return cartItemSnapShot;
   else return null;
  }

  // Future<DocumentSnapshot> getCategoyInfo(
  //     {String? categoryName, bool isMainCategories = false}) async {
  //   var data = await _firestore
  //       .collection('categories')
  //       .doc(!isMainCategories ? categoryName : 'mainCategories')
  //       .get();
  //   return data;
  // }

  Stream<QuerySnapshot> listenToOrders(
      {required String userId, DocumentSnapshot? documentSnapshot}) {
    var snapshots;
    var reference = _firestore
        .collection('customers')
        .doc('details')
        .collection('customers')
        .doc(userId)
        .collection('orders')
        .limit(20)
        .orderBy("ordered_at", descending: true);

    if (documentSnapshot != null)
      snapshots = reference.startAfterDocument(documentSnapshot).snapshots();
    else
      snapshots = reference.snapshots();
    return snapshots;
  }

  Future<DocumentSnapshot> getProductData(String productId) async {
    return _firestore
        .collection('products')
        .doc('details')
        .collection('products')
        .doc(productId)
        .get();
  }

  Future<DocumentSnapshot> getBannerData(String bannerId) async {
    return _firestore.collection('banners').doc(bannerId).get();
  }

  fetchDeliveryAreas() async {
    return (await _firestore.collection('deliveryAreas').get()).docs;
  }

  fetchTopProducts() async {
    return (await _firestore
            .collection('products')
            .doc('details')
            .collection('products')
            .orderBy('number_of_sales', descending: true)
            .limit(10)
            .get())
        .docs;
  }

  // getProductData(String productId)async{
  //  var productData = await _firestore.collection('products').doc(productId).get();
  //  return productData;
  // }
  Future<List<DocumentSnapshot>> fetchProducts(
      {DocumentSnapshot? documentSnapshot, required String filterId}) async {
    late List<DocumentSnapshot> documentList;
    var query = _firestore
        .collection("products")
        .doc('details')
        .collection('products')
        .limit(20);

    if (documentSnapshot != null)
      documentList = (await query
              .startAfterDocument(documentSnapshot)
              .where('filter_ids', arrayContains: filterId)
              .get())
          .docs;
    else
      documentList =
          (await query.where('filter_ids', arrayContains: filterId).get()).docs;

    // if (bannerName != null) {
    //   if (documentSnapshot != null)
    //     documentList = (await query
    //         .startAfterDocument(documentSnapshot)
    //         .where('banners', arrayContains: bannerName.toJson())
    //         .get())
    //         .docs;
    //   else
    //     documentList = (await query
    //         .where('banners', arrayContains: bannerName.toJson())
    //         .get())
    //         .docs;
    // } else if (subCategoryName != null) {
    //   if (documentSnapshot != null)
    //     documentList = (await query
    //         .startAfterDocument(documentSnapshot)
    //         .where('sub_category', isEqualTo: subCategoryName.toJson())
    //         .get())
    //         .docs;
    //   else
    //     documentList = (await query
    //         .where('sub_category', isEqualTo: subCategoryName.toJson())
    //         .get())
    //         .docs;
    // }

    return documentList;
  }

  // Future<List<DocumentSnapshot>> fetchProducts(
  //     {DocumentSnapshot? documentSnapshot,
  //     NameField? subCategoryName,
  //     NameField? bannerName}) async {
  //   late List<DocumentSnapshot> documentList;
  //   var query = _firestore
  //       .collection("products")
  //       .doc('details')
  //       .collection('products')
  //       .limit(20);
  //
  //   if (bannerName != null) {
  //     if (documentSnapshot != null)
  //       documentList = (await query
  //               .startAfterDocument(documentSnapshot)
  //               .where('banners', arrayContains: bannerName.toJson())
  //               .get())
  //           .docs;
  //     else
  //       documentList = (await query
  //               .where('banners', arrayContains: bannerName.toJson())
  //               .get())
  //           .docs;
  //   } else if (subCategoryName != null) {
  //     if (documentSnapshot != null)
  //       documentList = (await query
  //               .startAfterDocument(documentSnapshot)
  //               .where('sub_category', isEqualTo: subCategoryName.toJson())
  //               .get())
  //           .docs;
  //     else
  //       documentList = (await query
  //               .where('sub_category', isEqualTo: subCategoryName.toJson())
  //               .get())
  //           .docs;
  //   }
  //
  //   return documentList;
  // }

  Stream<DocumentSnapshot> fetchOrderDetails(String id) {
    final orderData = _firestore
        .collection('orders')
        .doc(id)
        .collection('details')
        .doc(id)
        .snapshots();
    return orderData;
  }

  Future cancelOrder(String orderId) async {
    final orderRef = _firestore.collection('orders').doc(orderId);
    final orderDetailsRef = orderRef.collection('details').doc(orderId);

    await orderRef.update({'order_status': 'Canceled'});
    await orderDetailsRef.update({'order_status': 'Canceled'});

    // await orderRef
    //     .collection('details')
    //     .doc('details')
    //     .update({'order_status': 'Canceled'});
  }

  Future<List<DocumentSnapshot>> getAllOrders(
      [DocumentSnapshot? documentSnapshot]) async {
    List<DocumentSnapshot> documentList;
    var query = _firestore
        .collection("customers")
        .doc('details')
        .collection('customers')
        .doc((await _firebaseRepo.getCurrentUser())!.uid)
        .collection("orders")
        .limit(20)
        .orderBy("ordered_at", descending: true);
    if (documentSnapshot != null) {
      documentList =
          (await query.startAfterDocument(documentSnapshot).get()).docs;
    } else {
      documentList = (await query.get()).docs;
    }
    return documentList;
  }

  Future<List<DocumentSnapshot>> searchProducts(String query) async {
    List<DocumentSnapshot> documentList = (await _firestore
            .collection("products")
            .doc('details')
            .collection('products')
            .where("name_search", arrayContains: query)
            .get())
        .docs;
    return documentList;
  }

  Future<List<ProductModel>> getProductsData(String condition) async {
    List<DocumentSnapshot> docList = (await _firestore
            .collection("products")
            .doc('details')
            .collection('products')
            .where(condition, isEqualTo: true)
            .get())
        .docs;
    return List.generate(docList.length, (index) {
      return ProductModel.fromJson(docList[index]);
    });
  }

  Future<List<QueryDocumentSnapshot>> fetchSubCategories(
      String categoryId) async {
    return (await _firestore
            .collection('subCategories')
            .where('main_category_id', isEqualTo: categoryId)
            .get())
        .docs;
  }

  // Future<List<DocumentSnapshot>> getAllProductsData(
  //   String condition,
  // ) async {
  //   print(condition);
  //   List<DocumentSnapshot> documentList = (await _firestore
  //           .collection("products")
  //           .where(condition, isEqualTo: true)
  //           .getDocuments())
  //       .documents;
  //   return documentList;
  // }

  // Future<List<DocumentSnapshot>> getAllCategoryProducts(
  //   String categoryId,
  // ) async {
  //   print(categoryId);
  //   List<DocumentSnapshot> documentList = (await _firestore
  //           .collection("test_products")
  //           .doc(categoryId)
  //           .collection('categoryProducts')
  //           .get())
  //       .docs;
  //   return documentList;
  // }

  Future<AccountDetails> getAllFaq() async {
    DocumentSnapshot document = await _firestore
        .collection("customers")
        .doc('details')
        .collection('customers')
        .doc((await _firebaseRepo.getCurrentUser())!.uid)
        .collection("account")
        .doc("details")
        .get();
    return AccountDetails.fromDocument(document);
  }

  Future deleteAddress(String addressId) async {
    await _firestore
        .collection("customers")
        .doc('details')
        .collection('customers')
        .doc((await _firebaseRepo.getCurrentUser())!.uid)
        .collection('addresses')
        .doc(addressId)
        .delete();
  }

  // Future<int> checkItemInCart(String productId) async {
  //   try {
  //     DocumentSnapshot documentSnapshot = await _firestore
  //         .collection("users")
  //         .doc((await _firebaseRepo.getCurrentUser())!.uid)
  //         .collection("cart")
  //         .doc(productId)
  //         .get();
  //     if (documentSnapshot.exists) {
  //       return documentSnapshot["no_of_items"];
  //     } else {
  //       return 0;
  //     }
  //   } catch (e) {
  //     return 0;
  //   }
  // }

  Future<int> checkItemInCart(String productId) async {
    var documentSnapshot = await _firestore
        .collection("customers")
        .doc('details')
        .collection('customers')
        .doc((await _firebaseRepo.getCurrentUser())!.uid)
        .collection('cart')
        .doc(productId)
        .get();
    if (documentSnapshot.exists) {
      return documentSnapshot['number_of_items'];
    } else {
      return 0;
    }
  }

  Future<void> addItemToOnlineCart(CartItemModel cartModel) async {
    return await _firestore
        .collection("customers")
        .doc('details')
        .collection('customers')
        .doc((await _firebaseRepo.getCurrentUser())!.uid)
        .collection("cart")
        .doc(cartModel.productId)
        .set(cartModel.toJson());
  }

  Future<void> deleteProductFromCart(String productId) async {
    return await _firestore
        .collection("customers")
        .doc('details')
        .collection('customers')
        .doc((await _firebaseRepo.getCurrentUser())!.uid)
        .collection("cart")
        .doc(productId)
        .delete();
  }

  Future<int> checkProductInCart(String productId) async {
    var cartDoc = await _firestore
        .collection("customers")
        .doc('details')
        .collection('customers')
        .doc((await _firebaseRepo.getCurrentUser())!.uid)
        .collection('cart')
        .doc(productId)
        .get();
    if (cartDoc.exists) {
      return cartDoc['number_of_items'];
    } else {
      return 0;
    }
  }

  Stream<DocumentSnapshot> listenToCartItem(
      {required String productId, required String userId}) {
    return _firestore
        .collection("customers")
        .doc('details')
        .collection('customers')
        .doc(userId)
        .collection('cart')
        .doc(productId)
        .snapshots();
  }

  Stream<DocumentSnapshot> listenToProductUpdates(String productId) {
    return _firestore
        .collection('products')
        .doc('details')
        .collection('products')
        .doc(productId)
        .snapshots();
  }

  Future fetchUserAddresses() async {
    return (await _firestore
            .collection("customers")
            .doc('details')
            .collection('customers')
            .doc(_accountProvider.user!.uid)
            .collection('addresses')
            .get())
        .docs;
  }

  Future getUserData(String id) async {
    try {
      DocumentSnapshot documentSnapshot = await _firestore
          .collection("customers")
          .doc('details')
          .collection('customers')
          .doc(id)
          .get();
      if (documentSnapshot.exists) {
        return documentSnapshot.data();
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<void> addUserDetails(AccountDetails accountDetails) async {
    print('from addUserDetails accountDetails is ${accountDetails}');
    return await _firestore
        .collection("customers")
        .doc('details')
        .collection('customers')
        .doc((await _firebaseRepo.getCurrentUser())!.uid)
        .set(accountDetails.toJson());
  }

  Future updateCustomerField(Map<String, dynamic> field, String id) async {
    _firestore
        .collection("customers")
        .doc('details')
        .collection('customers')
        .doc(id)
        .update(field);
  }

  Future<void> addOrEditUserAddress(Address address) async {
    return await _firestore
        .collection("customers")
        .doc('details')
        .collection('customers')
        .doc((await _firebaseRepo.getCurrentUser())!.uid)
        .collection('addresses')
        .doc(address.id)
        .set(address.toJson());
  }

  Future<AccountDetails> fetchUserDetails() async {
    return AccountDetails.fromDocument(await _firestore
        .collection("customers")
        .doc('details')
        .collection('customers')
        .doc((await _firebaseRepo.getCurrentUser())!.uid)
        // .collection("account")
        // .document("details")
        .get());
  }

  Stream<DocumentSnapshot> streamUserDetails(String uID) {
    return _firestore
        .collection("customers")
        .doc('details')
        .collection('customers')
        .doc(uID)
        .snapshots();
  }

  Stream<QuerySnapshot> cartStatusListen(String uID) {
    return _firestore
        .collection("customers")
        .doc('details')
        .collection('customers')
        .doc(uID)
        .collection("cart")
        .snapshots();
  }

  // Future<void> placeOrder(OrderModel orderModel) async {
  //   return await _firestore
  //       .collection("users")
  //       .document(await authRepo.getUid())
  //       .collection("orders")
  //       .document(orderModel.orderId).collection('details').doc('details')
  //       .setData(orderModel.toJson());
  // }
  // Future<void> placeOrder(OrderModel order) async {
  //   final ordersRef = _firestore.collection("orders").doc(order.orderId).collection('details').doc(order.orderId);
  //   await ordersRef.set(Map.from(order.toJson()));
  // }

  Future<void> placeOrder(OrderModel order) async {
    final ordersRef = _firestore.collection("orders").doc(order.orderId);

    await ordersRef
        .collection('details')
        .doc(order.orderId)
        .set(Map.from(order.toJson()));

    await ordersRef
        .set(BasicOrderModel.fromJsonOrderModelToJson(order.toJson()));
  }

  Future<void> emptyCart() async {
    return await _firestore
        .collection("customers")
        .doc('details')
        .collection('customers')
        .doc((await _firebaseRepo.getCurrentUser())!.uid)
        .collection("cart")
        .get()
        .then((snapshot) {
      for (DocumentSnapshot doc in snapshot.docs) {
        doc.reference.delete();
      }
    });
  }

  Future<List<QueryDocumentSnapshot>> fetchBanners() async {
    final docs = (await _firestore
            .collection('banners')
            .where('is_opened', isEqualTo: true)
            .get())
        .docs;
    return docs;
  }

  // Future<void> addProductToDataBase(
  //     {Map product, @required String categoryId}) async {
  //   // collection('productsTest').doc('categoryName').collection(categoryProducts).doc(productId)
  //   await _firestore
  //       .collection('test_products')
  //       .document(categoryId)
  //       .collection('categoryProducts')
  //       .document(product['product_id'])
  //       .setData(Map.from(product));
  // }

  // void addCategoryToDataBase(
  //     {@required CategoryModel currentCategory,
  //     String previousCategoryId,
  //     bool isLastCategory}) async {
  //   var categoriesRef = _firestore.collection('categories');
  //   var productsRef = _firestore.collection('test_products');
  //
  //   // if previousCategoryId is null then it is main category
  //   await categoriesRef
  //       .document(previousCategoryId ?? 'mainCategories')
  //       .updateData({
  //     'subCategories': FieldValue.arrayUnion([currentCategory])
  //   });
  //
  //   // check if it is the last category do not create doc
  //   // create a document for current category
  //   if (!isLastCategory)
  //     await categoriesRef
  //         .document(currentCategory.id)
  //         .setData(currentCategory.toJson());
  //   else {
  //     // if it is last category then create document for it in the products (test_products) collection
  //     // add category in the products collection
  //
  //     productsRef
  //         .document(currentCategory.id)
  //         .collection('categoryProducts')
  //         .document();
  //   }
  //
  //   /*
  //   * mainCategories
  //   * SuperMarket
  //   * Food Cupboard
  //   * Grains & Rice
  //   * */
  // }

  // void addCategories() async{
  //   Map fruits_vegetables = {
  //     'categoryId': Uuid().v4(),
  //     'categoryName': 'Fruits & Vegetables',
  //     'subCategories': [
  //       {
  //         'categoryId': Uuid().v4(),
  //         'categoryName': 'Fruits',
  //         'photo':
  //             'https://image.freepik.com/free-photo/basket-full-vegetables_1112-316.jpg',
  //       },
  //       {
  //         'categoryId': Uuid().v4(),
  //         'categoryName': 'Vegetables',
  //         'photo':
  //             'https://image.freepik.com/free-photo/basket-full-vegetables_1112-316.jpg',
  //       }
  //     ]
  //   };
  //   Map dairy_eggs = {
  //     'categoryId': Uuid().v4(),
  //     'categoryName': 'Dairy & Eggs',
  //     'subCategories': [
  //       {
  //         'categoryId': Uuid().v4(),
  //         'categoryName': 'Milk',
  //         'photo':
  //             'https://cdn.gourmetegypt.com/media/catalog/product/cache/c687aa7517cf01e65c009f6943c2b1e9/7/4/745114685704.jpg',
  //       },
  //       {
  //         'categoryId': Uuid().v4(),
  //         'categoryName': 'Eggs',
  //         'photo':
  //             'https://media.istockphoto.com/photos/set-of-egg-isolated-picture-id1028690210?k=6&m=1028690210&s=612x612&w=0&h=FjvNfRMM_afPkdpZsQqMq9Hlmc6q1LEWeXsG1_l0Lg4='
  //       },
  //       {
  //         'categoryId': Uuid().v4(),
  //         'categoryName': 'Cheese',
  //         'photo':
  //             'https://sc04.alicdn.com/kf/Ua9ddbc0277b84e37b4395c2dfe5eb40aV.jpg'
  //       }
  //     ]
  //   };
  //   Map baby_products = {
  //     'categoryId': Uuid().v4(),
  //     'categoryName': 'Baby Products',
  //     'subCategories': [
  //       {
  //         'categoryId': Uuid().v4(),
  //         'categoryName': 'Baby Food',
  //         'photo': 'https://images.heb.com/is/image/HEBGrocery/002986021',
  //       },
  //       {
  //         'categoryId': Uuid().v4(),
  //         'categoryName': 'Baby Diapers',
  //         'photo': 'https://sc04.alicdn.com/kf/U0d10f1e16b604c9e950619c9616dfda0A.jpg',
  //       }
  //     ]
  //   };
  //   List categories = [fruits_vegetables, dairy_eggs , baby_products];
  //   categories.forEach((category) async{
  //     print('categoryId is ${category['categoryId']}');
  //    await _firestore
  //         .collection('categories')
  //         .document(category['categoryId'])
  //         .setData(Map.from(category));
  //   });
  // }

  Future fetchMainCategories() async {
    QuerySnapshot data = await _firestore.collection('mainCategories').get();
    return data.docs;
  }
}
