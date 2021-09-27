import 'package:baqal/src/bloc/internet_connection/internet_connection.dart';
import 'package:baqal/src/core/utils/connectivity.dart';
import 'package:baqal/src/di/app_injector.dart';

import 'package:baqal/src/models/delivery_area.dart';

import 'package:baqal/src/notifiers/delivery_areas_provider.dart';

import 'package:baqal/src/repository/firestore_repository.dart';

import 'package:bloc/bloc.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'delivery_areas_state.dart';

class DeliveryAreasCubit extends Cubit<DeliveryAreasState> {
  DeliveryAreasCubit() : super(DeliveryAreasState.idle());
  final _firestoreRepo = getItInstance<FirestoreRepository>();
  final deliveryAreasProvider = getItInstance<DeliveryAreasProvider>();
  late List<DocumentSnapshot> _documents;
  late List<DeliveryAreaModel> deliveryAreas;

  MyConnectivity _connectivity = MyConnectivity.instance;

  Future fetchDeliveryAreas() async {
    bool hasConnection = await _connectivity.checkInternetConnection();

    emit(DeliveryAreasState.loading());

    if(hasConnection){
      try {
        _documents = await _firestoreRepo.fetchDeliveryAreas();

        deliveryAreas = List<DeliveryAreaModel>.generate(_documents.length,
                (index) => DeliveryAreaModel.fromJson(_documents[index].data()));

        deliveryAreasProvider.setDeliveryAreas = deliveryAreas;

        deliveryAreasProvider.deliveryAreas.forEach((element) {

        });

        emit(DeliveryAreasState.loaded(deliveryAreas));
      } catch (e) {
        print(e);
      }
    }

  }
}
