import 'package:baqal/src/bloc/add_to_cart/add_to_cart_cubit.dart';
import 'package:baqal/src/bloc/internet_connection/internet_connection.dart';
import 'package:baqal/src/models/cart_model.dart';
import 'package:baqal/src/notifiers/addresses_provider.dart';
import 'package:baqal/src/notifiers/delivery_areas_provider.dart';
import 'package:baqal/src/notifiers/language_notifier.dart';
import 'package:baqal/src/routes/router_utils.dart';
import 'package:baqal/src/routes/routes_constants.dart';
import 'package:baqal/src/ui/common/no_internet_connection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:baqal/src/di/app_injector.dart';
import 'package:baqal/src/notifiers/account_provider.dart';
import 'package:baqal/src/notifiers/cart_status_provider.dart';
import 'package:baqal/src/notifiers/provider_notifier.dart';
import 'package:baqal/src/res/string_constants.dart';
import 'package:baqal/src/ui/common/cart_item_card.dart';
import 'package:baqal/src/ui/common/common_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen>
    with AutomaticKeepAliveClientMixin {
  final _addToCartCubit = getItInstance<AddToCartCubit>();
  var _addressesProvider = getItInstance<AddressesProvider>();
  var accountProvider = getItInstance<AccountProvider>();
  final internetConnectionCubit = getItInstance<InternetConnectionCubit>();
  final deliveryAreasProvider = getItInstance<DeliveryAreasProvider>();
  final languageProvider = getItInstance<LanguageProvider>();
  final routerUtils = getItInstance<RouterUtils>();
  bool isConnected = true;

  @override
  void initState() {
    // _addToCartCubit.checkIfProductsUpdated().then((value) =>
    //     _addToCartCubit.listenToCartValues());
    // _addToCartCubit.checkIfProductsUpdated();
    if (accountProvider.user != null) _addToCartCubit.listenToCart();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ProviderNotifier<CartStatusProvider>(
      child: (CartStatusProvider cartItemStatus) {
        return ProviderNotifier<AccountProvider>(
            child: (AccountProvider accountProvider) {
          return BlocConsumer<InternetConnectionCubit, InternetConnectionState>(
            bloc: internetConnectionCubit,
            listener: (context, state) {
              state.when(
                  idle: () {},
                  noInternetConnection: () {
                    isConnected = false;
                  },
                  connectedSuccessfully: () {
                    isConnected = true;
                    // _addToCartCubit.listenToCartValues();
                  });
            },
            builder: (context, state) {
              print('internet connection from cart screen is $isConnected');
              return Scaffold(
                backgroundColor: Colors.white,
                appBar: AppBar(
                  title: Text(languageProvider.getTranslated(
                      context, StringsConstants.cart)!),
                  elevation: 1,
                ),
                body: isConnected
                    ? cartItemStatus.noOfItemsInCart > 0
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              cartView(cartItemStatus),
                              Container(
                                  color: Colors.white70,
                                  child: Column(
                                    children: [
                                      Divider(
                                        thickness: 0.5,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              languageProvider.getTranslated(
                                                  context,
                                                  StringsConstants.total)!,
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            Text(
                                              '${cartItemStatus.priceInCart} ${languageProvider.getTranslated(context, StringsConstants.egyptCurrency)!}',
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w500),
                                            )
                                          ],
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.bottomRight,
                                        child: CommonButton(
                                          title: languageProvider.getTranslated(
                                              context,
                                              StringsConstants
                                                  .proceedToCheckout),
                                          margin: EdgeInsets.all(8),
                                          onTap: () {
                                            if (isConnected) {
                                              if (_addressesProvider
                                                      .selectedAddress !=
                                                  null) {
                                                routerUtils.pushNamedRoot(context, Routes.checkOutScreen);
                                                // Navigator.pushNamed(context,
                                                //     Routes.checkOutScreen);
                                              } else {
                                                routerUtils.pushNamedRoot(context, Routes.addOrEditAddressScreen,);
                                                // Navigator.pushNamed(
                                                //   context,
                                                //   Routes.addOrEditAddressScreen,
                                                // );
                                              }
                                            }
                                          },
                                        ),
                                      ),
                                    ],
                                  ))
                            ],
                          )
                        : Center(child: emptyCartView())
                    : noInternetConnection(),

              );
            },
          );
        });
      },
    );
  }

  Widget cartView(CartStatusProvider cartStatusProvider) {
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
                      cartStatusProvider.cartItems.length, (index) {
                    return CartItemCard(
                      cartModel: cartStatusProvider.cartItems[index],
                    );
                  }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget emptyCartView() {
    return Column(
      children: [
        Image.asset(
          'assets/images/empty-cart.gif',
        ),
        SizedBox(
          height: 15,
        ),
        Text(
          languageProvider.getTranslated(
              context, StringsConstants.emptyCartStatementText)!,
          style: TextStyle(
              fontSize: 25, fontWeight: FontWeight.bold, color: Colors.black),
        )
      ],
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
