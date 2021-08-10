import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class ProductModel {
  String productId;
  String categoryId;
  String image;
  String name;
  String description;
  String category;
  String section;
  bool isTopProduct;

  bool isOnSale;

  bool isSpecialOrder;

  int basicQuantity;
  int remainQuantity;
  int soldQuantity;

  num currentPrice = 0.0;
  num discountPrice = 0.0;
  bool isProductAvailable;

  ProductModel(
      {required this.productId,
        required this.categoryId,
        required this.image,
        required this.name,
        required this.section,
        required this.category,
        // @required this.categories,
       this.isTopProduct = false,
       this.isOnSale = false,
       this.isSpecialOrder = false,
       this.isProductAvailable = true,
        required this.currentPrice,
        required this.discountPrice,
        required this.basicQuantity,
        this.remainQuantity = 0,
        this.soldQuantity = 0,
        this.description = '',
       });

  factory ProductModel.fromJson(DocumentSnapshot json) {
    return ProductModel(
        productId: json['productId'] as String,
        categoryId: json['categoryId'],
        image: json['image'] as String,
        name: json['name'] as String,
        description: json['description'] as String,
        section: json['section'],
        category:json['category'],
        // categories:
        //     (json['section'] as List)?.map((e) => e as String)?.toList(),
        isTopProduct: json['isTopProduct'],
        isOnSale: json['isOnSale'],
        isSpecialOrder: json['isSpecialOrder'],
        isProductAvailable: json['isProductAvailable'] as bool,
        currentPrice: json['currentPrice'] ,
        discountPrice: json['discountPrice'] ,
        basicQuantity: json['basicQuantity'] ,
        remainQuantity: json['remainQuantity'] ,
        soldQuantity: json['soldQuantity'] );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'productId': productId,
    'categoryId': categoryId,
    'image': image,
    'name': name,
    'basicQuantity': basicQuantity,
    'remainQuantity': remainQuantity,
    'soldQuantity': soldQuantity,
    'description': description,
    'section': section,
    'category': category,
    'isTopProduct': isTopProduct,
    'isOnSale': isOnSale,
    'isSpecialOrder': isSpecialOrder,
    'isProductAvailable': isProductAvailable,
    'currentPrice': currentPrice ?? 0.0,
    'discountPrice': discountPrice ?? 0.0,
  };

  @override
  String toString() {
    return 'ProductModel{productId: $productId, image: $image, name: $name,  section: $section,currentPrice: $currentPrice, discountPrice: $discountPrice}';
  }


}
