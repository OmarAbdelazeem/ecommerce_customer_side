import 'dart:async';
import 'package:baqal/src/bloc/add_to_cart/add_to_cart.dart';
import 'package:baqal/src/res/app_colors.dart';
import 'package:baqal/src/routes/router_utils.dart';
import 'package:baqal/src/routes/routes_constants.dart';
import 'package:baqal/src/ui/common/dot_progress_indicator.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:baqal/src/res/app_assets.dart';
import 'package:baqal/src/bloc/account_details/account_details.dart';
import 'package:baqal/src/bloc/addresses/addresses.dart';
import 'package:baqal/src/bloc/check_user_data/check_user_data.dart';
import 'package:baqal/src/bloc/delivery_areas/delivery_areas_cubit.dart';
import 'package:baqal/src/notifiers/account_provider.dart';
import 'package:baqal/src/notifiers/language_notifier.dart';
import 'package:baqal/src/di/app_injector.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final checkUserDataCubit = getItInstance<CheckUserDataCubit>();
  final accountDetailsCubit = getItInstance<AccountDetailsCubit>();
  final deliveryAreasCubit = getItInstance<DeliveryAreasCubit>();
  final addressesCubit = getItInstance<AddressesCubit>();
  final accountProvider = getItInstance<AccountProvider>();
  final languageProvider = getItInstance<LanguageProvider>();
  final addToCartCubit = getItInstance<AddToCartCubit>();
  final routerUtils = getItInstance<RouterUtils>();



  @override
  void initState() {
    super.initState();
    // fetch app delivery areas
    deliveryAreasCubit.fetchDeliveryAreas().then((_) {
      // setUp customer data
      setUpCustomerData();
    });

  }

  void setUpCustomerData() {
    checkUserDataCubit.checkUserData().then((_) async {
      // subscribe to notification of user language
        FirebaseMessaging.instance
            .subscribeToTopic('${languageProvider.locale!.languageCode}CustomersNotifications');
    });
  }


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Scaffold(
        backgroundColor: AppColors.primaryColor,
        body: Container(
          height: MediaQuery.of(context).size.height * 0.98,
          child: BlocConsumer(
            bloc: checkUserDataCubit,
            listener: (context, CheckUserDataState state) async {
              if (state is UserDataNotFound) {
                Future.delayed(Duration(milliseconds: 1)).then((value) =>
                routerUtils.pushNamedAndRemoveUntil(context, Routes.addUserNameScreen,arguments: true));
              } else if (state is Finished) {

                FirebaseMessaging.instance
                    .subscribeToTopic('${languageProvider.locale!.languageCode}CustomersNotifications');

                await accountDetailsCubit.updateLanguage(languageProvider.locale!.languageCode);
                // get customer token
                FirebaseMessaging.instance.getToken().then((token) async {
                  print('token is $token');
                  await accountDetailsCubit.updateToken(token!);
                });

                await addToCartCubit.transformItemsFromLocalCartToOnlineCart();
                addressesCubit.fetchAddresses();


                Future.delayed(Duration(milliseconds: 10)).then((_) {
                  if(routerUtils.previousRoot == Routes.otpLoginScreen)
                    routerUtils.popUntil(context);
                  else
                    routerUtils.pushNamedAndRemoveUntil(context, Routes.mainHomeScreen);
                });


              } else if (state is ConnectionError) {
                Future.delayed(Duration(milliseconds: 1)).then((value) =>
                    routerUtils.pushNamedAndRemoveUntil(context, Routes.connectionErrorScreen));
              }
            },
            builder: (context, CheckUserDataState state) {
              return Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.35,
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.asset(
                          AppAssets.logo,
                          height: 245,
                          width: 245,
                        ),
                        DotProgressIndicator(),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
