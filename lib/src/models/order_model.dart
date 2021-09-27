import 'package:baqal/src/models/name_field.dart';

import 'account_details_model.dart';

class OrderModel {
  late String orderId;
  late int? orderNumber;
  late num total;
  String customerId;
  List<OrderItem?>? orderItems;
  String? orderedAt;
  String? orderStatus;
  late Address orderAddress;

  OrderModel(
      {required this.orderId,
      required this.total,
      required this.orderItems,
      this.orderedAt,
      this.orderStatus,
      required this.customerId,
      this.orderNumber,
      required this.orderAddress});

  factory OrderModel.fromJson(json) {
    return OrderModel(
        orderId: json['order_id'],
        total: json['total'] as num,
        orderStatus: json['order_status'] as String,
        orderedAt: json['ordered_at'] as String,
        orderNumber: json['order_number'],
        customerId: json['customer_id'],
        orderAddress: Address.fromDocument(json['order_address']),
        orderItems: (json['order_items'] as List)
            .map((e) => e == null ? null : OrderItem.fromJson(e))
            .toList());
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'total': total,
        'ordered_at': DateTime.now().toIso8601String(),
        "order_status": "Processing",
        "order_address": orderAddress.toJson(),
        'order_id': orderId,
        'order_number': orderNumber,
        'customer_id': customerId,
        'order_items': List<dynamic>.from(orderItems!.map((x) => x!.toJson())),
      };

  @override
  String toString() {
    return 'OrderModel{orderId: $orderId, price: $total, orderItems: $orderItems}';
  }
}

class OrderItem {
  late String productId;
  late String image;
  late NameField name;
  late num price;
  late num noOfItems;
  late String customerId;

  OrderItem(
      {required this.productId,
      required this.image,
      required this.price,
      required this.name,
      required this.customerId,
      required this.noOfItems});

  factory OrderItem.fromJson(json) {
    return OrderItem(
      productId: json['product_id'] as String,
      image: json['image'] as String,
      price: json['price'] as num,
      customerId: json['customer_id'],
      name: NameField.fromJson(json['name']),
      noOfItems: json['no_of_items'] as num,
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'product_id': productId,
        'image': image,
        'name': name.toJson(),
        'price': price,
    'customer_id':customerId,
        'no_of_items': noOfItems,
      };

  @override
  String toString() {
    return 'OrderItem{productId: $productId, image: $image, name: $name, currency: EGP, price: $price, noOfItems: $noOfItems}';
  }
}
