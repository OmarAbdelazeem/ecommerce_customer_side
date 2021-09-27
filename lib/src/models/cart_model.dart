import 'package:baqal/src/models/name_field.dart';
import 'package:baqal/src/models/product_model.dart';
import 'package:hive/hive.dart';

part 'cart_model.g.dart';

// class CartModel {
//  late String productId;
//  late String image;
//  late String name;
//  late num currentPrice;
//  late int numOfItems;
//
//   CartModel(
//       {required this.productId,
//      required this.image,
//      required this.name,
//      required this.currentPrice,
//      required this.numOfItems});
//
//   factory CartModel.fromJson(DocumentSnapshot json) {
//     return CartModel(
//       productId: json['product_id'] as String,
//       image: json['image'] as String,
//       name: json['name'] as String,
//       currentPrice: json['current_price'] as num,
//       numOfItems: json['no_of_items'] ,
//     );
//   }
//
//   Map<String, dynamic> toJson() => <String, dynamic>{
//         'product_id': productId,
//         'image': image,
//         'name': name,
//         'current_price': currentPrice,
//         'no_of_items': numOfItems,
//       };
//

// }
@HiveType(typeId: 1)
class CartItemModel {
  @HiveField(0)
  late String productId;
  @HiveField(1)
  late String image;
  @HiveField(2)
  late NameField name;
  @HiveField(3)
  late num price;
  @HiveField(4)
  late num discountPrice;
  @HiveField(5)
  late int numberOfItems;

  CartItemModel(
      {required this.productId,
      required this.image,
      required this.name,
      required this.price,
      required this.discountPrice,
      required this.numberOfItems});

  factory CartItemModel.fromJson(json) {
    return CartItemModel(
      productId: json['product_id'] as String,
      image: json['image'] as String,
      name: NameField.fromJson(json['name']),
      price: json['price'] as num,
      discountPrice: json['discount_price'],
      numberOfItems: json['number_of_items'],
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'product_id': productId,
        'image': image,
        'name': name.toJson(),
        'price': price,
        'discount_price': discountPrice,
        'number_of_items': numberOfItems,
      };

  factory CartItemModel.fromProduct(ProductModel product, int numOfItems) {
    return CartItemModel(
        productId: product.productId,
        image: product.image!,
        name: product.name,
        discountPrice: product.discountPrice,
        price: product.price,
        numberOfItems: numOfItems);
  }
}
