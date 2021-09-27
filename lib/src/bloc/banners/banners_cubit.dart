import 'package:baqal/src/core/utils/connectivity.dart';
import 'package:baqal/src/di/app_injector.dart';
import 'package:baqal/src/models/banner_model.dart';
import 'package:baqal/src/repository/firestore_repository.dart';
import 'package:bloc/bloc.dart';

import 'banners_state.dart';

class BannersCubit extends Cubit<BannersState> {
  BannersCubit() : super(BannersState.idle());
  final _firestoreRepo = getItInstance<FirestoreRepository>();
  List<BannerModel> _bannersList = [];
  MyConnectivity _connectivity = MyConnectivity.instance;

  void fetchBanners() async {
    bool hasConnection = await _connectivity.checkInternetConnection();
   if(hasConnection){
     emit(BannersState.loading());
     try {
       final docs = await _firestoreRepo.fetchBanners();
       print(docs);
       _bannersList = List.generate(docs.length, (index) {
         Object? doc = docs[index].data();
         return BannerModel.fromJson(doc);
       });
       emit(BannersState.loaded(_bannersList));
     } catch (e) {
       emit(BannersState.error(e.toString()));
       print('banners cubit fetchBanners function error is $e');
     }
   }
  }

  Future<BannerModel?> getBannerData(String bannerId)async{
    try{
      var bannerDocumentSnapshot = await _firestoreRepo.getBannerData(bannerId);
      BannerModel banner = BannerModel.fromJson(bannerDocumentSnapshot.data());
      return banner;
    }catch(e){
      print(e);
      return null;
    }

  }



}
