import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:baqal/src/di/app_injector.dart';
import 'package:baqal/src/models/account_details_model.dart';
import 'package:baqal/src/models/cartModel_model.dart';
import 'package:baqal/src/models/order_model.dart';
import 'package:baqal/src/models/basic_order_model.dart';
import 'package:baqal/src/models/product_model.dart';
import 'package:flutter/cupertino.dart';
import 'auth_repository.dart';
import 'package:uuid/uuid.dart';

class FirestoreRepository {
  var authRepo = getItInstance<FirebaseRepository>();
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<DocumentSnapshot> getCategoyInfo(
      {String? categoryName, bool isMainCategories = false}) async {
    var data = await _firestore
        .collection('categories')
        .doc(!isMainCategories ? categoryName : 'mainCategories')
        .get();
    return data;
  }

  Future<List<DocumentSnapshot>> getAllProducts(
      {DocumentSnapshot? documentSnapshot, String ?condition}) async {
    late List<DocumentSnapshot> documentList;
    // var query = _firestore.collection("final_products").limit(20).orderBy("name");
    var query = _firestore.collection("products").limit(20);
    if (condition != null) {
      documentList =
          (await query.where('section', isEqualTo: condition).get())
              .docs;
    }

    if (documentSnapshot != null) {
      documentList =
          (await query.startAfterDocument(documentSnapshot).get())
              .docs;
    }
    // else {
    //   documentList = (await query.getDocuments()).documents;
    // }
    return documentList;
  }

  Future cancelOrder(String orderId) async {
    final orderRef = _firestore
        .collection('users')
        .doc(await authRepo.getUid())
        .collection('orders')
        .doc(orderId);
    await orderRef.update({'order_status': 'Canceled'});
    
    await orderRef
        .collection('details')
        .doc('details')
        .update({'order_status': 'Canceled'});
  }

  Future<List<DocumentSnapshot>> getAllOrders(
      [DocumentSnapshot? documentSnapshot]) async {
    List<DocumentSnapshot> documentList;
    var query = _firestore
        .collection("users")
        .doc(await authRepo.getUid())
        .collection("orders")
        .limit(20)
        .orderBy("ordered_at", descending: true);
    if (documentSnapshot != null) {
      documentList =
          (await query.startAfterDocument(documentSnapshot).get())
              .docs;
    } else {
      documentList = (await query.get()).docs;
    }
    return documentList;
  }

  Future<List<DocumentSnapshot>> searchProducts(String query) async {
    List<DocumentSnapshot> documentList = (await _firestore
            .collection("products")
            .where("name_search", arrayContains: query)
            .get())
        .docs;
    return documentList;
  }

  Future<List<ProductModel>> getProductsData(String condition) async {
    List<DocumentSnapshot> docList = (await _firestore
            .collection("products")
            .where(condition, isEqualTo: true)
            .get())
        .docs;
    return List.generate(docList.length, (index) {
      return ProductModel.fromJson(docList[index]);
    });
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

  Future<List<DocumentSnapshot>> getAllCategoryProducts(
    String categoryId,
  ) async {
    print(categoryId);
    List<DocumentSnapshot> documentList = (await _firestore
            .collection("test_products")
            .doc(categoryId)
            .collection('categoryProducts')
            .get())
        .docs;
    return documentList;
  }

  Future<AccountDetails> getAllFaq() async {
    DocumentSnapshot document = await _firestore
        .collection("users")
        .doc(await authRepo.getUid())
        .collection("account")
        .doc("details")
        .get();
    return AccountDetails.fromDocument(document);
  }

  Future<int> checkItemInCart(String productId) async {
    try {
      DocumentSnapshot documentSnapshot = await _firestore
          .collection("users")
          .doc(await authRepo.getUid())
          .collection("cart")
          .doc(productId)
          .get();
      if (documentSnapshot.exists) {
        return documentSnapshot["no_of_items"];
      } else {
        return 0;
      }
    } catch (e) {
      return 0;
    }
  }

  Future<void> addProductToCart(CartModel cartModel) async {
    return await _firestore
        .collection("users")
        .doc(await authRepo.getUid())
        .collection("cart")
        .doc(cartModel.productId)
        .set(cartModel.toJson());
  }

  Future<void> delProductFromCart(String productId) async {
    return await _firestore
        .collection("users")
        .doc(await authRepo.getUid())
        .collection("cart")
        .doc(productId)
        .delete();
  }

  // Future<bool> checkUserDetail() async {
  //   try {
  //     DocumentSnapshot documentSnapshot = await _firestore
  //         .collection("users")
  //         .document(await authRepo.getUid())
  //         .collection("account")
  //         .document("details")
  //         .get();
  //     if (documentSnapshot.exists) {
  //       return true;
  //     } else {
  //       return false;
  //     }
  //   } catch (e) {
  //     return false;
  //   }
  // }

  Future checkUserDetail() async {
    try {
      DocumentSnapshot documentSnapshot = await _firestore
          .collection("users")
          .doc(await authRepo.getUid())
          // .collection("account")
          // .document("details")
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
    return await _firestore
        .collection("users")
        .doc(await authRepo.getUid())
        // .collection("account")
        // .document("details")
        .set(accountDetails.toJson());
  }

  Future<void> addUserAddress(Address address) async {
    return await _firestore
        .collection("users")
        .doc(await authRepo.getUid())
        // .collection("account")
        // .document("details")
        .update({
      'addresses': FieldValue.arrayUnion([address.toJson()])
    });
  }

  Future<AccountDetails> fetchUserDetails() async {
    return AccountDetails.fromDocument(await _firestore
        .collection("users")
        .doc(await authRepo.getUid())
        // .collection("account")
        // .document("details")
        .get());
  }

  Stream<DocumentSnapshot> streamUserDetails(String uID) {
    return _firestore
        .collection("users")
        .doc(uID)
        // .collection("account")
        // .document("details")
        .snapshots();
  }

  Stream<QuerySnapshot> cartStatusListen(String uID) {
    return _firestore
        .collection("users")
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

  Future<void> placeOrder(OrderModel orderModel) async {
    final orderRef = _firestore
        .collection("users")
        .doc(await authRepo.getUid())
        .collection("orders")
        .doc(orderModel.orderId);
    final jsonOrderModel = orderModel.toJson();

    await orderRef
        .collection('details')
        .doc('details')
        .set(Map.from(jsonOrderModel));

    await orderRef
        .set(BasicOrderModel.fromJsonOrderModelToJson(jsonOrderModel));
  }

  Future<void> emptyCart() async {
    return await _firestore
        .collection("users")
        .doc(await authRepo.getUid())
        .collection("cart")
        .get()
        .then((snapshot) {
      for (DocumentSnapshot doc in snapshot.docs) {
        doc.reference.delete();
      }
    });
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
    // List categories = [];
    QuerySnapshot data =
        await _firestore.collection('mainCategories').get();
    // data.documents.forEach((doc) {
    //   categories.add(MainCategoryModel.fromJson(doc));
    // });
    return data.docs;
  }
}
