// import 'package:baqal/src/models/location.dart';
// import 'package:geolocator/geolocator.dart';
//
// class LocationService {
//   final Geolocator _geolocator = Geolocator()..forceAndroidLocationManager;
//   Position _currentPosition;
//   Placemark _place;
//   Location _location;
//
//   Future getCurrentLocation() async {
//     try {
//       print('_getCurrentLocation 0 called');
//     final status = await _geolocator.checkGeolocationPermissionStatus();
//     print('location status $status}');
//       _currentPosition = await _geolocator.getCurrentPosition(
//         desiredAccuracy: LocationAccuracy.high,
//       );
//
//       print('_getCurrentLocation 1 called');
//       await _getAddressFromLatLng();
//       // await searchForArea();
//       return _location;
//       // print(
//       //     '_location is ${_location.cityName} , _location is ${_location.provinceName}');
//     } catch (e) {
//       print(e);
//     }
//
//
//   }
//
//   Future _getAddressFromLatLng() async {
//     try {
//       List<Placemark> p = await _geolocator.placemarkFromCoordinates(
//           _currentPosition.latitude, _currentPosition.longitude);
//       _place = p[0];
//       print(
//           '{_place.subAdministrativeArea} is ${_place.subAdministrativeArea} && {_place.name} is ${_place.name} && {_place.position} is ${_place.position} && {_place.country} is ${_place.country} && {_place.administrativeArea} is ${_place.administrativeArea} && {_place.locality} is ${_place.locality} && {_place.thoroughfare} is ${_place.thoroughfare} && {_place.subThoroughfare} is ${_place.subThoroughfare} && {_place.isoCountryCode} is ${_place.isoCountryCode} && {_place.postalCode} is ${_place.postalCode} && {_place.subLocality} is ${_place.subLocality}');
//
//       _location = Location(
//           country: _place.country,
//           administrativeArea: _place.administrativeArea,
//           subAdministrativeArea: _place.subAdministrativeArea,
//           locality: _place.locality,
//           latitude: _place.position.latitude,
//           longitude: _place.position.longitude);
//     } catch (e) {
//       print(e);
//     }
//   }
//
//   Stream<Position> getCurrentPositionAsStream(){
//     return _geolocator.getCurrentPosition(
//       desiredAccuracy: LocationAccuracy.high,
//     ).asStream();
//   }
// }
