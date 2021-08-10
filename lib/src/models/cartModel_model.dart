import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:baqal/src/models/product_model.dart';

class CartModel {
 late String productId;
 late String image;
 late String name;

  // String currency;
 late num currentPrice;

 late int numOfItems;

  CartModel(
      {required this.productId,
     required this.image,
     required this.name,
      // this.currency,
     required this.currentPrice,
     required this.numOfItems});

  factory CartModel.fromJson(DocumentSnapshot json) {
    return CartModel(
      productId: json['product_id'] as String,
      image: json['image'] as String,
      name: json['name'] as String,
      // currency: json['currency'] as String,
      currentPrice: json['current_price'] as num,
      numOfItems: json['no_of_items'] ,
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'product_id': productId,
        'image': image,
        'name': name,

        // 'currency': currency,
        'current_price': currentPrice,
        'no_of_items': numOfItems,
      };

  factory CartModel.fromProduct(ProductModel productModel, int numOfItems) {
    return CartModel(
        productId: productModel.productId,
        image: productModel.image,
        name: productModel.name,
        // currency: productModel.currency,
        currentPrice: productModel.currentPrice,
        // quantityPerUnit: productModel.quantityPerUnit,
        numOfItems: numOfItems);
  }
}
