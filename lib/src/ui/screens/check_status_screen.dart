// import 'package:baqal/src/bloc/account_details/account_details.dart';
// import 'package:baqal/src/bloc/addresses/addresses.dart';
// import 'package:baqal/src/bloc/check_user_data/check_user_data.dart';
// import 'package:baqal/src/bloc/delivery_areas/delivery_areas_cubit.dart';
// import 'package:baqal/src/notifiers/account_provider.dart';
// import 'package:baqal/src/notifiers/language_notifier.dart';
// import 'package:baqal/src/routes/routes_constants.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
// import 'package:baqal/src/di/app_injector.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// class CheckStatusScreen extends StatefulWidget {
//   final String pushingRootName;
//
//   CheckStatusScreen(this.pushingRootName);
//
//   @override
//   _CheckStatusScreenState createState() => _CheckStatusScreenState();
// }
//
// class _CheckStatusScreenState extends State<CheckStatusScreen> {
//   final checkUserDataCubit = getItInstance<CheckUserDataCubit>();
//   final accountDetailsCubit = getItInstance<AccountDetailsCubit>();
//   final deliveryAreasCubit = getItInstance<DeliveryAreasCubit>();
//   final addressesCubit = getItInstance<AddressesCubit>();
//   final accountProvider = getItInstance<AccountProvider>();
//   final languageProvider = getItInstance<LanguageProvider>();
//
//   @override
//   void initState() {
//     super.initState();
//
//     // fetch app delivery areas
//     deliveryAreasCubit.fetchDeliveryAreas().then((_) {
//       // check customer data
//       checkUserDataCubit.checkUserData().then((_) async {
//
//         // check customer language
//         languageProvider.checkIfThereIsASavedLocale().then((locale) async{
//           FirebaseMessaging.instance
//               .subscribeToTopic('${locale.languageCode}CustomersNotifications');
//
//           if (accountProvider.user != null &&
//               accountProvider.accountDetails != null) {
//             // update customer language in firestore
//             await accountDetailsCubit.updateLanguage(locale.languageCode);
//             // get customer token
//             FirebaseMessaging.instance.getToken().then((token) async {
//               print('token is $token');
//               await accountDetailsCubit.updateToken(token!);
//             });
//
//
//             addressesCubit.fetchAddresses();
//           }
//         });
//
//
//
//       });
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: SizedBox(
//           height: 70,
//           width: 70,
//           child: BlocConsumer(
//             bloc: checkUserDataCubit,
//             listener: (context, CheckUserDataState state) {
//               if (state is UserDataNotFound) {
//                 Future.delayed(Duration(milliseconds: 1)).then((value) =>
//                     Navigator.pushNamedAndRemoveUntil(
//                         context, Routes.addUserNameScreen, (route) => false,
//                         arguments: true));
//               } else if (state is Finished) {
//                 Future.delayed(Duration(milliseconds: 10)).then((_) {
//                   if (widget.pushingRootName == Routes.otpLoginScreen)
//                     Navigator.of(context).popUntil((route) => route.isFirst);
//                   else
//                     Navigator.pushNamedAndRemoveUntil(
//                         context, Routes.mainHomeScreen, (_) => false);
//                 });
//               } else if (state is ConnectionError) {
//                 Future.delayed(Duration(milliseconds: 1)).then((value) =>
//                     Navigator.pushNamedAndRemoveUntil(
//                         context, Routes.connectionErrorScreen, (_) => false));
//               }
//             },
//             builder: (context, CheckUserDataState state) {
//               return CircularProgressIndicator(
//                 strokeWidth: 7,
//               );
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }
