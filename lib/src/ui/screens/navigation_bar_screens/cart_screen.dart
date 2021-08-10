import 'package:baqal/src/bloc/auth/auth_cubit.dart';
import 'package:baqal/src/core/navigation.dart';
import 'package:baqal/src/models/cartModel_model.dart';
import 'package:baqal/src/repository/auth_repository.dart';
import 'package:baqal/src/repository/firestore_repository.dart';
import 'package:baqal/src/ui/common/sign_in.dart';
import 'package:baqal/src/ui/screens/add_address_screen.dart';
import 'package:baqal/src/ui/screens/checkout_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:baqal/src/bloc/place_order/place_order_cubit.dart';
import 'package:baqal/src/di/app_injector.dart';
import 'package:baqal/src/notifiers/account_provider.dart';
import 'package:baqal/src/notifiers/cart_status_provider.dart';
import 'package:baqal/src/notifiers/provider_notifier.dart';
import 'package:baqal/src/res/app_colors.dart';
import 'package:baqal/src/res/string_constants.dart';
import 'package:baqal/src/ui/common/cart_item_card.dart';
import 'package:baqal/src/ui/common/common_button.dart';
import 'package:baqal/src/ui/screens/base_screen_mixin.dart';

import '../login_screen.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> with BaseScreenMixin {
  // var paymentCubit = AppInjector.get<PaymentCubit>();
  var placeOrderCubit = getItInstance<PlaceOrderCubit>();
  var firebaseRepo = getItInstance<FirestoreRepository>();
  var authRepo = getItInstance<FirebaseRepository>();
  var cartStatusProvider = getItInstance<CartStatusProvider>();

  @override
  void initState() {
    listenToCartValues();
    super.initState();
  }

  listenToCartValues() async {
    firebaseRepo.cartStatusListen(await authRepo.getUid()).listen((event) {
      var noOfItemsInCart = event.docs.length ?? 0;
      if (noOfItemsInCart > 0) {
        cartStatusProvider.cartItems =
            List<CartModel>.generate(event.docs.length ?? 0, (index) {
          DocumentSnapshot documentSnapshot = event.docs[index];
          return CartModel.fromJson(documentSnapshot);
        });
      } else {
        cartStatusProvider.cartItems = [];
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ProviderNotifier<CartStatusProvider>(
      child: (CartStatusProvider cartItemStatus) {
        return ProviderNotifier<AccountProvider>(
            child: (AccountProvider accountProvider) {
          return Scaffold(
            key: scaffoldKey,
            backgroundColor: AppColors.colorF8F8F8,
            appBar: AppBar(
              title: Text(StringsConstants.cart),
              elevation: 1,
            ),
            body: accountProvider.user == null
                ? SignInAndRegister()
                : cartItemStatus.noOfItemsInCart > 0
                    ? cartView(cartItemStatus)
                    : Container(),
            bottomNavigationBar: Visibility(
                visible: cartItemStatus.noOfItemsInCart > 0 &&
                    accountProvider.user != null,
                child: checkOut(cartItemStatus)),
          );
        });
      },
    );
  }

  Widget cartView(CartStatusProvider cartItemStatus) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(right: 10, left: 10, top: 21),
          child: Column(
            children: [
              Container(
                //  margin: EdgeInsets.only(bottom: 20),
                child: Column(
                  children: List<Widget>.generate(
                      cartItemStatus.cartItems.length, (index) {
                    return CartItemCard(
                      cartModel: cartItemStatus.cartItems[index],
                      margin: EdgeInsets.only(bottom: 20),
                    );
                  }),
                ),
              ),
              SizedBox(
                height: 50,
              ),
              paymentSummary(),
            ],
          ),
        ),
      ),
    );
  }

  Widget checkOut(CartStatusProvider cartItemStatus) {
    return Container(
      height: 94,
      width: MediaQuery.of(context).size.width * 0.98,
      color: AppColors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CommonButton(
            title: 'Add items',
            width: 170,
            height: 50,
            margin: EdgeInsets.only(left: 15),
            onTap: () {},
          ),
          CommonButton(
            title: 'Checkout',
            width: 170,
            height: 50,
            margin: EdgeInsets.only(right: 15),
            onTap: () {
              //Todo fix this as before
              var addressProvider = getItInstance<AccountProvider>();
              if (addressProvider.addressSelected != null) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) {
                      return CheckOutScreen();
                    },
                  ),
                );
              } else {
                Navigation.push(context , AddAddressScreen(false));
              }
            },
          ),
        ],
      ),
    );
  }

  Widget paymentSummary() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Payment Summary',
          style: TextStyle(fontSize: 19, fontWeight: FontWeight.w600),
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Subtotal'),
            Text('EGP 50'),
          ],
        ),
        SizedBox(
          height: 5,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Service charge'),
            Text('EGP 10'),
          ],
        ),
        SizedBox(
          height: 5,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Total amount'),
            Text('EGP 60'),
          ],
        ),
      ],
    );
  }
}
