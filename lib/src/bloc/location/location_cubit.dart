// import 'package:baqal/src/di/app_injector.dart';
// import 'package:baqal/src/models/location.dart';
// import 'package:baqal/src/repository/location_service.dart';
// import 'package:bloc/bloc.dart';
// import 'package:geolocator/geolocator.dart';
// import 'location_state.dart';
//
// class LocationCubit extends Cubit<LocationState> {
//   LocationCubit() : super(LocationState.idle());
//   final _locationService = AppInjector.get<LocationService>();
//    Location _location;
//
//   Future getCurrentLocation()async{
//     emit(LocationState.loading());
//     try{
//       _location = await _locationService.getCurrentLocation();
//       print('from LocationCubit _location is $_location');
//       emit(LocationState.locationGotSuccessful(_location));
//     }catch(e){
//       print(e);
//       emit(LocationState.locationFailed());
//     }
//
//   }
//
//   Stream<Position> getCurrentPositionAsStream(){
//     return _locationService.getCurrentPositionAsStream();
//   }
//
//   get location => _location;
// }
