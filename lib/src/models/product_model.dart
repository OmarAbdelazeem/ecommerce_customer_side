import 'package:baqal/src/models/name_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

// ignore: must_be_immutable
class ProductModel extends Equatable {
  late String productId;
  late String? image;
  late String? imageId;
  late NameField name;
  late NameField? description;
  late NameField? subCategory;
  late String date;
  late num? basicQuantity;
  late num? remainQuantity;
  late num? numberOfSales;
  late num price;
  late num discountPrice;
  late List categories;
  late List banners;

  ProductModel({
    required this.productId,
    this.image,
    this.imageId,
    required this.name,
    required this.subCategory,
    required this.date,
    required this.categories,
    required this.numberOfSales,
    required this.price,
    required this.discountPrice,
    required this.basicQuantity,
    required this.remainQuantity,
    this.description,
  });

  ProductModel.fromJson(json) {
    productId = json['product_id'] as String;
    image = json['image'] as String;
    imageId = json['image_id'];
    if (json['categories'] != null && json['categories'] != []) {
      categories = (json['categories'] as List)
          .map((e) => e == null ? null : NameField.fromJson(e))
          .toList();
    }

    name = NameField.fromJson(Map.from(json['name']));
    description = NameField.fromJson(json['description']);
    subCategory = json['sub_category'] != null
        ? NameField.fromJson(json['sub_category'])
        : null;
    date = json['date'];
    numberOfSales = json['number_of_sales'];
    price = json['price'];
    discountPrice = json['discount_price'];
    basicQuantity = json['basic_quantity'];
    remainQuantity = json['remain_quantity'];
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'product_id': productId,
    'categories': categories.map((e) => e.toJson()).toList(),
    'image': image,
    'name': name.toJson(),
    'image_id': imageId,
    'date': date,
    'banners': [],
    'basic_quantity': basicQuantity,
    'remain_quantity': remainQuantity,
    'description': description != null ? description!.toJson() : null,
    'number_of_sales': numberOfSales,
    'sub_category': subCategory!.toJson(),
    'price': price,
    'discount_price': discountPrice == 0.0 ? price : discountPrice,
  };

  @override
  String toString() {
    return 'ProductModel{product_id: $productId, image: $image,  section: $subCategory, current_price: $price, discount_price: $discountPrice}';
  }


  @override
  // TODO: implement props
  List<Object> get props => [
    productId,
    image!,
    name,
    description!,
    date,
    date,
    subCategory!,
    basicQuantity!,
    remainQuantity!,
    price,
    discountPrice,
  ];
}
