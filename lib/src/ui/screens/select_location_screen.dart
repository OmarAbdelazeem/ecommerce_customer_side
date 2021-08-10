
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
//
// class SelectLocationScreen extends StatefulWidget {
//   @override
//   _SelectLocationScreenState createState() => _SelectLocationScreenState();
// }
//
// class _SelectLocationScreenState extends State<SelectLocationScreen> {
//   final Geolocator _geolocator = Geolocator()..forceAndroidLocationManager;
//   LatLng _initialcameraposition = LatLng(20.5937, 78.9629);
//   GoogleMapController _controller;
//   Placemark _place;
//
//   String place ='place' ;
//   void _onMapCreated(GoogleMapController _cntlr)
//   {
//     _controller = _cntlr;
//     _geolocator.getCurrentPosition(
//       desiredAccuracy: LocationAccuracy.high,
//     ).asStream().listen((position) {
//         _controller.animateCamera(
//           CameraUpdate.newCameraPosition(
//             CameraPosition(target: LatLng(position.latitude, position.longitude),zoom: 15),
//           ),
//         );
//     });
//
//   }
//
//   void getAddress({double latitude, double longitude})async{
//     List<Placemark> p = await _geolocator.placemarkFromCoordinates(
//         latitude, longitude);
//     _place = p[0];
//     setState(() {
//       place = _place.locality;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Select Delivery Location'),),
//       body: Container(
//         height: MediaQuery.of(context).size.height,
//         width: MediaQuery.of(context).size.width,
//         child: Column(
//           children: [
//             Container(
//               height: 35,
//               child: Text(place),
//             ),
//             Container(
//               height: MediaQuery.of(context).size.height * 0.85,
//               child: Stack(
//                 children: [
//                   GoogleMap(
//                     initialCameraPosition: CameraPosition(target: _initialcameraposition),
//                     mapType: MapType.normal,
//                     onMapCreated: _onMapCreated,
//                     onTap: (LatLng latLng){
//                       getAddress(latitude: latLng.latitude , longitude: latLng.longitude);
//                     },
//
//                     // scrollGesturesEnabled: true,
//                     myLocationEnabled: true,
//                     onCameraMove: (CameraPosition cameraPosition){
//                     },
//                     myLocationButtonEnabled: true,
//                   ),
//                 ],
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
//
// }

// import 'package:flutter/material.dart';
// import 'package:google_maps_place_picker/google_maps_place_picker.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
//
//
// void main() => runApp(MyApp());
//
// class MyApp extends StatelessWidget {
//   // Light Theme
//   final ThemeData lightTheme = ThemeData.light().copyWith(
//     // Background color of the FloatingCard
//     cardColor: Colors.white,
//     buttonTheme: ButtonThemeData(
//       // Select here's button color
//       buttonColor: Colors.black,
//       textTheme: ButtonTextTheme.primary,
//     ),
//   );
//
//   // Dark Theme
//   final ThemeData darkTheme = ThemeData.dark().copyWith(
//     // Background color of the FloatingCard
//     cardColor: Colors.grey,
//     buttonTheme: ButtonThemeData(
//       // Select here's button color
//       buttonColor: Colors.yellow,
//       textTheme: ButtonTextTheme.primary,
//     ),
//   );
//
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Google Map Place Picker Demo',
//       theme: lightTheme,
//       darkTheme: darkTheme,
//       themeMode: ThemeMode.light,
//       home: HomePage(),
//       debugShowCheckedModeBanner: false,
//     );
//   }
// }
//
// class HomePage extends StatefulWidget {
//   const HomePage({Key key}) : super(key: key);
//
//   static final kInitialPosition = LatLng(-33.8567844, 151.213108);
//
//   @override
//   _HomePageState createState() => _HomePageState();
// }
//
// class _HomePageState extends State<HomePage> {
//   PickResult selectedPlace;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: Text("Google Map Place Picer Demo"),
//         ),
//         body: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: <Widget>[
//               RaisedButton(
//                 child: Text("Load Google Map"),
//                 onPressed: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) {
//                         return PlacePicker(
//                           apiKey: "AIzaSyAjsRQrPi7NGtHjWhYua6i8wPeYcCw4joQ",
//                           initialPosition: HomePage.kInitialPosition,
//                           useCurrentLocation: true,
//                           selectInitialPosition: true,
//
//                           //usePlaceDetailSearch: true,
//                           onPlacePicked: (result) {
//                             selectedPlace = result;
//                             Navigator.of(context).pop();
//                             setState(() {});
//                           },
//                           //forceSearchOnZoomChanged: true,
//                           //automaticallyImplyAppBarLeading: false,
//                           //autocompleteLanguage: "ko",
//                           //region: 'au',
//                           //selectInitialPosition: true,
//                           // selectedPlaceWidgetBuilder: (_, selectedPlace, state, isSearchBarFocused) {
//                           //   print("state: $state, isSearchBarFocused: $isSearchBarFocused");
//                           //   return isSearchBarFocused
//                           //       ? Container()
//                           //       : FloatingCard(
//                           //           bottomPosition: 0.0, // MediaQuery.of(context) will cause rebuild. See MediaQuery document for the information.
//                           //           leftPosition: 0.0,
//                           //           rightPosition: 0.0,
//                           //           width: 500,
//                           //           borderRadius: BorderRadius.circular(12.0),
//                           //           child: state == SearchingState.Searching
//                           //               ? Center(child: CircularProgressIndicator())
//                           //               : RaisedButton(
//                           //                   child: Text("Pick Here"),
//                           //                   onPressed: () {
//                           //                     // IMPORTANT: You MUST manage selectedPlace data yourself as using this build will not invoke onPlacePicker as
//                           //                     //            this will override default 'Select here' Button.
//                           //                     print("do something with [selectedPlace] data");
//                           //                     Navigator.of(context).pop();
//                           //                   },
//                           //                 ),
//                           //         );
//                           // },
//                           // pinBuilder: (context, state) {
//                           //   if (state == PinState.Idle) {
//                           //     return Icon(Icons.favorite_border);
//                           //   } else {
//                           //     return Icon(Icons.favorite);
//                           //   }
//                           // },
//                         );
//                       },
//                     ),
//                   );
//                 },
//               ),
//               selectedPlace == null ? Container() : Text(selectedPlace.formattedAddress ?? ""),
//             ],
//           ),
//         ));
//   }
// }