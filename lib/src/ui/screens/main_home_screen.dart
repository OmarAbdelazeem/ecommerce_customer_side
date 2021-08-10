import 'package:baqal/src/core/navigation.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:baqal/src/di/app_injector.dart';
import 'package:baqal/src/models/cartModel_model.dart';
import 'package:baqal/src/notifiers/account_provider.dart';
import 'package:baqal/src/notifiers/cart_status_provider.dart';
import 'package:baqal/src/notifiers/main_screen_provider.dart';
import 'package:baqal/src/notifiers/provider_notifier.dart';
import 'package:baqal/src/repository/auth_repository.dart';
import 'package:baqal/src/repository/firestore_repository.dart';
import 'package:baqal/src/res/app_colors.dart';
import 'package:baqal/src/res/string_constants.dart';
import 'package:baqal/src/res/text_styles.dart';

import 'login_screen.dart';
import 'navigation_bar_screens/SearchScreen.dart';
import 'navigation_bar_screens/account_screen.dart';
import 'navigation_bar_screens/cart_screen.dart';
import 'navigation_bar_screens/home_page.dart';

class MainHomeScreen extends StatefulWidget {
  @override
  _MainHomeScreenState createState() => _MainHomeScreenState();
}

class _MainHomeScreenState extends State<MainHomeScreen> {
  var mainScreenProvider = getItInstance<MainScreenProvider>();
  var firebaseRepo = getItInstance<FirestoreRepository>();
  var authRepo = getItInstance<FirebaseRepository>();
  var cartStatusProvider = getItInstance<CartStatusProvider>();
  var accountProvider = getItInstance<AccountProvider>();
  // final _locationCubit = AppInjector.get<LocationCubit>();

  @override
  void initState() {
    super.initState();
    if (accountProvider.user != null) {
       listenToCartValues();
      // listenToAccountDetails();
    }
    // getLocation();
  }

  // getLocation()async{
  //   if(_locationCubit.location == null){
  //    await _locationCubit.getCurrentLocation();
  //   }
  // }

  listenToCartValues() async {
    firebaseRepo.cartStatusListen(await authRepo.getUid()).listen((event) {
      var noOfItemsInCart = event?.docs?.length ?? 0;
      if (noOfItemsInCart > 0) {
        cartStatusProvider.cartItems =
            List<CartModel>.generate(event?.docs?.length ?? 0, (index) {
          DocumentSnapshot documentSnapshot = event.docs[index];
          return CartModel.fromJson(documentSnapshot);
        });
      } else {
        cartStatusProvider.cartItems = [];
      }
    });
  }

  // void listenToAccountDetails() async {
  //   firebaseRepo.streamUserDetails(await authRepo.getUid()).listen((event) {
  //     AccountDetails accountDetails = AccountDetails.fromDocument(event);
  //     accountDetails.addresses = accountDetails.addresses.reversed.toList();
  //
  //     Address address;
  //     List.generate(accountDetails.addresses.length, (index) {
  //       Address add = accountDetails.addresses[index];
  //       if (add.isDefault) {
  //         address = add;
  //       }
  //     });
  //     if (address == null && accountDetails.addresses.isNotEmpty) {
  //       address = accountDetails.addresses[0];
  //       accountProvider.addressSelected = address;
  //     } else {
  //       accountProvider.addressSelected = address;
  //     }
  //     accountProvider.accountDetails = accountDetails;
  //   });
  // }

  @override
  Widget build(BuildContext context) {

    return ProviderNotifier<MainScreenProvider>(
      child: (MainScreenProvider mainScreenProvider) {
        return ProviderNotifier(
          child: (AccountProvider accountProvider) {
            return Scaffold(
              body: [
                HomePageScreen(),
                SearchItemScreen(),
                CartScreen(),
                AccountScreen(),
              ][mainScreenProvider.bottomBarIndex],
              bottomNavigationBar: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                //  backgroundColor: AppColors.primaryColor,
                unselectedItemColor: AppColors.color81819A,
                selectedItemColor: AppColors.primaryColor,
                showSelectedLabels: true,
                showUnselectedLabels: true,
                items: [
                  BottomNavigationBarItem(
                      icon: Icon(Icons.home),
                      label: StringsConstants.home,),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.search),
                      label: StringsConstants.search,),
                  BottomNavigationBarItem(
                      icon: Stack(
                        children: <Widget>[
                          Center(child: Icon(Icons.shopping_cart)),
                          ProviderNotifier<CartStatusProvider>(
                            child: (CartStatusProvider value) {
                              return Visibility(
                                visible: value.noOfItemsInCart > 0 &&
                                    accountProvider.user != null,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 20),
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: CircleAvatar(
                                      minRadius: 7,
                                      maxRadius: 7,
                                      backgroundColor: Colors.red,
                                      child: Text(
                                        "${value.noOfItemsInCart}",
                                        style: AppTextStyles.normal9White,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          )
                        ],
                      ),
                      label: StringsConstants.cart,),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.person),
                      label: StringsConstants.account),
                ],
                onTap: (index) {
                  if (index == 2 && accountProvider.user == null) {
                   Navigation.push(context, LoginScreen());
                  }else{
                    mainScreenProvider.bottomBarIndex = index;
                  }
                },
                currentIndex: mainScreenProvider.bottomBarIndex,
              ),
            );
          },
        );
      },
    );
  }
}
