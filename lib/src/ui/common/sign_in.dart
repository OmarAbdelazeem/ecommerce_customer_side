import 'package:baqal/src/core/navigation.dart';
import 'package:baqal/src/di/app_injector.dart';
import 'package:baqal/src/notifiers/navigation_provider.dart';
import 'package:baqal/src/ui/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'common_button.dart';

class SignInAndRegister extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
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
    );
  }
}
