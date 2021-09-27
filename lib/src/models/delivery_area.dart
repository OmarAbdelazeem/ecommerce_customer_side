
class DeliveryAreaModel {
  String? name;
  String? id;
  num? deliveryFee;

  DeliveryAreaModel({this.name, this.id, this.deliveryFee});

  DeliveryAreaModel.fromJson(dynamic json) {
    name = json['name'];
    id = json['id'];
    deliveryFee = json['delivery_fee'];
  }
}
