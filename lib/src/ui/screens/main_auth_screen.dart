// import 'package:admin_side_ecommerce/src/bloc/auth/auth.dart';
// import 'package:admin_side_ecommerce/src/di/app_injector.dart';
// import 'package:admin_side_ecommerce/src/enums/auth_type.dart';
// import 'package:admin_side_ecommerce/src/ui/common/common_button.dart';
// import 'package:admin_side_ecommerce/src/ui/screens/login_screen.dart';
// import 'package:flutter/material.dart';
//
// class MainAuthScreen extends StatefulWidget {
//   @override
//   _MainAuthScreenState createState() => _MainAuthScreenState();
// }
//
// class _MainAuthScreenState extends State<MainAuthScreen> {
//   @override
//   Widget build(BuildContext context) {
//     // final authCubit = AppInjector.get<AuthCubit>();
//     return Scaffold(
//       appBar: AppBar(),
//       body: Center(
//         child: Container(
//           height: MediaQuery.of(context).size.height * 0.7,
//           // alignment: Alignment.center,
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//               Container(
//                 child: Text(
//                   'Login or create an account',
//                   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
//                   textAlign: TextAlign.center,
//                 ),
//                 width: MediaQuery.of(context).size.width * 0.98,
//               ),
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   // CommonButton(
//                   //   title: 'continue with Google',
//                   //   textStyle: TextStyle(
//                   //       fontWeight: FontWeight.normal,
//                   //       color: Colors.white,
//                   //       fontSize: 17),
//                   //   // titleColor: Colors.white,
//                   //   fontSize: 25,
//                   //   buttonColor: Colors.blue,
//                   //   // leadingIcon: Icon(
//                   //   //   Icons.g_translate,
//                   //   // ),
//                   //   textAlign: TextAlign.center,
//                   //   width: MediaQuery.of(context).size.width * 0.95,
//                   //   height: 60,
//                   // ),
//                   // SizedBox(
//                   //   height: 25,
//                   // ),
//                   // CommonButton(
//                   //   height: 60,
//                   //   textStyle: TextStyle(
//                   //       fontWeight: FontWeight.normal,
//                   //       color: Colors.black,
//                   //       fontSize: 17),
//                   //   title: 'continue with Facebook',
//                   //   titleColor: Colors.black,
//                   //   // leadingIcon: Icon(
//                   //   //   Icons.favorite,
//                   //   //   color: Colors.blue,
//                   //   // ),
//                   //   width: MediaQuery.of(context).size.width * 0.95,
//                   //   buttonColor: Colors.white,
//                   //   elevation: 5,
//                   // ),
//                   // SizedBox(
//                   //   height: 25,
//                   // ),
//                   // CommonButton(
//                   //   height: 60,
//                   //   textStyle: TextStyle(
//                   //       fontWeight: FontWeight.normal,
//                   //       color: Colors.black,
//                   //       fontSize: 17),
//                   //   title: 'continue with Email',
//                   //   onTap: () {
//                   //     // authCubit.enterEmail();
//                   //     Navigator.push(
//                   //       context,
//                   //       MaterialPageRoute(
//                   //         builder: (_) => LoginScreen(
//                   //           authType: AuthType.Email,
//                   //         ),
//                   //       ),
//                   //     );
//                   //   },
//                   //   // leadingIcon: Icon(
//                   //   //   Icons.email,
//                   //   // ),
//                   //   buttonColor: Colors.white,
//                   //   elevation: 5,
//                   //   titleColor: Colors.black,
//                   //   width: MediaQuery.of(context).size.width * 0.95,
//                   // ),
//                   // SizedBox(
//                   //   height: 25,
//                   // ),
//                   CommonButton(
//                     buttonColor: Colors.white,
//                     elevation: 5,
//                     height: 60,
//                     // titleColor: Colors.black,
//                     title: 'continue with Phone number',
//                     textStyle: TextStyle(
//                         fontWeight: FontWeight.normal,
//                         color: Colors.black,
//                         fontSize: 17),
//                     onTap: () {
//                       // authCubit.enterPhoneNumber();
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (_) => LoginScreen(),
//                         ),
//                       );
//                     },
//                     // leadingIcon: Icon(
//                     //   Icons.phone_android,
//                     // ),
//                     width: MediaQuery.of(context).size.width * 0.95,
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
