import 'dart:async';

import 'package:baqal/src/core/utils/connectivity.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'internet_connection_state.dart';

class InternetConnectionCubit extends Cubit<InternetConnectionState> {
  InternetConnectionCubit() : super(InternetConnectionState.idle());
  MyConnectivity _connectivity = MyConnectivity.instance;

  void listenToInternetConnection() {
    _connectivity.initialize();
     _connectivity.myStream.listen((event) {
      bool status = _connectivity.getInternetStatus(event);

      if (status) {
        emit(InternetConnectionState.connectedSuccessfully());
      } else
        emit(InternetConnectionState.noInternetConnection());
    });
  }

      getInternetConnectionStatus()async{
  bool hasConnection = await _connectivity.checkInternetConnection();
  return hasConnection;
}


  void disposeStream() {
    _connectivity.disposeStream();
  }
}
