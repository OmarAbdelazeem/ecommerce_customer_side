import 'package:baqal/src/core/navigation.dart';
import 'package:baqal/src/ui/common/common_button.dart';
import 'package:baqal/src/ui/common/sign_in.dart';
import 'package:baqal/src/ui/screens/account_details_screen.dart';
import 'package:baqal/src/ui/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:baqal/src/notifiers/account_provider.dart';
import 'package:baqal/src/notifiers/provider_notifier.dart';
import 'package:baqal/src/di/app_injector.dart';
import 'package:baqal/src/notifiers/navigation_provider.dart';
import 'package:flutter/material.dart';

class AccountScreen extends StatefulWidget {
  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return ProviderNotifier<AccountProvider>(
        child: (AccountProvider accountProvider) {
          if(accountProvider.user == null){
            return signInAndRegister(context);
          }
          else{
            return AccountDetailsScreen();
          }

        }
    );

    //   Scaffold(
    //   appBar: AppBar(),
    //   body: SafeArea(child:
    //       ProviderNotifier<AccountProvider>(
    //           child: (AccountProvider accountProvider) {
    //             if(accountProvider.firebaseUser == null){
    //               return signInAndRegister(context);
    //             }
    //             else{
    //               return AccountDetailsScreen();
    //             }
    //
    //           }
    //       ),
    //       ),
    // );
  }


}

Future<Widget> signWidget(BuildContext context){
  return Future.delayed(Duration(seconds: 2)).then((value){
    return signInAndRegister(context);
  });
}



Widget signInAndRegister(BuildContext context) {
  return Scaffold(
    body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Sign in to start shopping',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 15,
            ),
            CommonButton(
              width: MediaQuery.of(context).size.width * 0.9,
              title: 'Log In',
              onTap: () {
                final navigationProvider = getItInstance<NavigationProvider>();
                navigationProvider.setIsFromMainHomeScreen = true;
                Navigation.push(context , LoginScreen());
              },
            ),
            SizedBox(
              height: 15,
            ),
            CommonButton(
              width: MediaQuery.of(context).size.width * 0.9,
              title: 'Register',
              onTap: () {
                Navigation.push(context , LoginScreen());
              },
            ),
          ],
        ),
      ),
    ),
  );
}