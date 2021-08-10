import 'package:baqal/src/models/product_model.dart';

class HomePageModel {
  List<ProductModel> topProducts;
  List<ProductModel> dealOfTheDay;

  List<ProductModel> onSale;

  HomePageModel({required this.topProducts, required this.dealOfTheDay,required this.onSale});

  @override
  String toString() {
    return 'HomePageModel{topProducts: $topProducts, dealOfTheDay: $dealOfTheDay, onSale: $onSale}';
  }
}
