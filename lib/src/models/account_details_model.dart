class AccountDetails {
  String? name;
  String? phoneNumber;
  String? id;
  String? date;
  String? token;
  String? language;

  AccountDetails({
    this.name,
    this.phoneNumber,
    this.token,
    this.language
  });

  AccountDetails.fromDocument(json) {
    name = json['name'];
    phoneNumber = json['phone_number'];
    date = json['date'];
    id = json['id'];
    token = json['token'];
    language = json['language'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['date'] = DateTime.now().toIso8601String();
    data['phone_number'] = this.phoneNumber;
    data['id'] = this.id;
    data['token'] = this.token;
    data['language'] = this.language;
    return data;
  }
}

class Address {
  late String name;
  late String id;
  String? landmarkSign;
  late String streetName;
  late String area;
  String? buildingNumber;
  String? floorNumber;
  late String? addressDescription;
  late String phoneNumber;
  late bool isDefault;

  Address(
      {required this.name,
      required this.landmarkSign,
      required this.streetName,
      required this.area,
      required this.id,
      required this.addressDescription,
      required this.phoneNumber,
      this.floorNumber,
      this.buildingNumber,
      this.isDefault = false});

  Address.fromDocument(json) {
    name = json['name'];
    floorNumber = json['floor_number'];
    buildingNumber = json['building_number'];
    area = json['area'];
    id = json['id'];
    landmarkSign = json['landmark_sign'];
    streetName = json['street_name'];
    addressDescription = json['address_description'];
    phoneNumber = json['phone_number'];
    isDefault = json['is_default'] ?? false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['landmark_sign'] = this.landmarkSign;
    data['floor_number'] = this.floorNumber;
    data['area'] = this.area;
    data['id'] = this.id;
    data['building_number'] = this.buildingNumber;
    data['street_name'] = this.streetName;
    data['address_description'] = this.addressDescription;
    data['phone_number'] = this.phoneNumber;
    data['is_default'] = this.isDefault;
    return data;
  }
}
