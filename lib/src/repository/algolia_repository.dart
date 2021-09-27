import 'package:algolia/algolia.dart';

class AlgoliaRepository{

  var algolia = Application.algolia;
  // String ?  _searchTerm ;

  // Stream _operation(String? input)  {
  //   AlgoliaQuery query = algolia.instance.index("users").query(input!);
  //   Stream<AlgoliaQuerySnapshot> querySnap =  query.getObjects().asStream();
  //   // List<AlgoliaObjectSnapshot> results = querySnap.hits;
  //   return querySnap;
  // }

  Stream<AlgoliaQuerySnapshot> searchForProduct(String productName){
    AlgoliaQuery query = algolia.instance.index("products").query(productName);
    Stream<AlgoliaQuerySnapshot> querySnap =  query.getObjects().asStream();
    // List<AlgoliaObjectSnapshot> results = querySnap.hits;
    return querySnap;
  }

  Stream<AlgoliaQuerySnapshot> searchForCustomer(String customerName){
    AlgoliaQuery query = algolia.instance.index("customers").setHitsPerPage(3).query(customerName);
    Stream<AlgoliaQuerySnapshot> querySnap =  query.getObjects().asStream();
    // List<AlgoliaObjectSnapshot> results = querySnap.hits;
    return querySnap;
  }

}


class Application {
  static Algolia algolia = Algolia.init(
    applicationId: "D607WH5J8L",
    apiKey: "981568ab5e402a5baeb60099d39c110a",
  );
}