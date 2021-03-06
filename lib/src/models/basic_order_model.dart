
class BasicOrderModel {
late String orderId;
 int ? orderNumber;
late num total;
late String orderedAt;
late String orderStatus;
late String image;

  BasicOrderModel({
   required this.orderId,
    required this.total,
   required this.orderedAt,
   required this.orderStatus,
    this.orderNumber,
  });

  factory BasicOrderModel.fromJson(json) {
    return BasicOrderModel(
        orderId: json['order_id'] as String,
        total: json['total'] as num,
        orderStatus: json['order_status'] as String,
        orderedAt: json['ordered_at'] as String,
        orderNumber: json['order_number']);
  }

static fromJsonOrderModelToJson(orderModel) {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['order_id'] = orderModel['order_id'];
    data['total'] = orderModel['total'];
    data['order_status'] = orderModel['order_status'];
    data['ordered_at'] = orderModel['ordered_at'];
    data['order_number'] = orderModel['order_number'];
    data['image'] = orderModel['order_items'][0]['image'];
    data['customer_id'] = orderModel['customer_id'];
    return data;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['order_id'] = this.orderId;
    data['total'] = this.total;
    data['order_status'] = this.orderStatus;
    data['ordered_at'] = this.orderedAt;
    data['order_number'] = this.orderNumber;

    return data;
  }
}
