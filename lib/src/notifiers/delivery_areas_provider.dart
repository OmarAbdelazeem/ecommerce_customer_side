import 'package:baqal/src/models/delivery_area.dart';
import 'package:flutter/cupertino.dart';

class DeliveryAreasProvider extends ChangeNotifier {
  List<DeliveryAreaModel> _deliveryAreas = [];

  List<DeliveryAreaModel> get deliveryAreas => _deliveryAreas;

  set setDeliveryAreas(List<DeliveryAreaModel> value) {
    _deliveryAreas = value;
    notifyListeners();
  }

  double getDeliveryFee(String areaName) {

    late double deliveryFee;

     bool isMatched = false;

     _deliveryAreas.forEach((area) {

       isMatched = area.name == areaName;

       if(isMatched){
         deliveryFee = area.deliveryFee!.toDouble();
         return ;
       }
     });


    return deliveryFee;
  }
}

// when customer tap checkout then he must have address with the same chosen area
