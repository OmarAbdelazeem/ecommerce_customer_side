import 'package:baqal/src/core/utils/connectivity.dart';
import 'package:baqal/src/di/app_injector.dart';
import 'package:baqal/src/routes/router_utils.dart';
import 'package:baqal/src/routes/routes_constants.dart';
import 'package:baqal/src/ui/common/common_button.dart';
import 'package:baqal/src/ui/common/no_internet_connection.dart';
import 'package:flutter/material.dart';

class ConnectionErrorScreen extends StatelessWidget {
  final _routerUtils = getItInstance<RouterUtils>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            noInternetConnection(),
            SizedBox(
              height: 20,
            ),
            CommonButton(
              title: 'Retry',
              onTap: () async {
                MyConnectivity _connectivity = MyConnectivity.instance;
                bool hasConnection =
                    await _connectivity.checkInternetConnection();
                print('from connection error screen is internet is $hasConnection');
                if (hasConnection)
                  Future.delayed(Duration(milliseconds: 1)).then((value) =>
                  _routerUtils.pushNamedAndRemoveUntil(context, Routes.splashScreen,arguments: Routes.connectionErrorScreen));
                      // Navigator.pushNamedAndRemoveUntil(
                      //     // context, Routes.checkStatusScreen, (_) => false,
                      //     context, Routes.splashScreen, (_) => false,
                      //     arguments: Routes.connectionErrorScreen));
              },
              width: 280,
            )
          ],
        ),
      ),
    );
  }
}
