import 'package:baqal/src/bloc/place_order/place_order.dart';
import 'package:baqal/src/di/app_injector.dart';
import 'package:baqal/src/notifiers/addresses_provider.dart';
import 'package:baqal/src/notifiers/delivery_areas_provider.dart';
import 'package:baqal/src/notifiers/language_notifier.dart';
import 'package:baqal/src/notifiers/provider_notifier.dart';
import 'package:baqal/src/res/string_constants.dart';
import 'package:baqal/src/res/text_styles.dart';
import 'package:baqal/src/routes/router_utils.dart';
import 'package:baqal/src/routes/routes_constants.dart';
import 'package:baqal/src/ui/common/action_text.dart';
import 'package:baqal/src/ui/common/commom_text_field.dart';
import 'package:baqal/src/ui/common/common_button.dart';
import 'package:baqal/src/ui/common/common_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../di/app_injector.dart';
import '../../notifiers/cart_status_provider.dart';

class CheckOutScreen extends StatefulWidget {
  @override
  _CheckOutScreenState createState() => _CheckOutScreenState();
}

class _CheckOutScreenState extends State<CheckOutScreen> {
  var placeOrderCubit = getItInstance<PlaceOrderCubit>();
  CartStatusProvider cartItemStatus = getItInstance<CartStatusProvider>();
  final deliveryAreasProvider = getItInstance<DeliveryAreasProvider>();
  final languageProvider = getItInstance<LanguageProvider>();
  final routerUtils = getItInstance<RouterUtils>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(languageProvider.getTranslated(
            context, StringsConstants.checkout)!),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              deliverTo(),
              SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 15,
                  ),
                  Text(
                    languageProvider.getTranslated(
                        context, StringsConstants.notes)!,
                    style: TextStyle(fontSize: 22),
                  ),
                ],
              ),
              notesView(),
              SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 15,
                  ),
                  Text(
                    languageProvider.getTranslated(
                        context, StringsConstants.payWith)!,
                    style: TextStyle(fontSize: 22),
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(width: 0.5, color: Colors.black)),
                  child: ListTile(
                    title: Row(
                      children: [
                        Icon(Icons.money),
                        SizedBox(
                          width: 10,
                        ),
                        Text(languageProvider.getTranslated(
                            context, StringsConstants.cashOnDelivery)!),
                      ],
                    ),
                    leading: Radio<bool>(
                      value: true,
                      groupValue: true,
                      onChanged: (_) {},
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ProviderNotifier(
                  child: (AddressesProvider addressesProvider) {
                    double? deliveryFee = deliveryAreasProvider.getDeliveryFee(
                        addressesProvider.selectedAddress!.area);

                    return paymentSummary(
                      deliveryFee: deliveryFee,
                      priceInCart: cartItemStatus.priceInCart,
                    );
                  },
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: BlocConsumer<PlaceOrderCubit, PlaceOrderState>(
              bloc: placeOrderCubit,
              listener: (BuildContext context, PlaceOrderState state) {
                state.when(
                    loading: () {},
                    idle: () {},
                    orderCanceled: () {},
                    error: (String message) {},
                    orderSuccessfullyPlaced: () {
                      routerUtils.popAndPushNamed(context, Routes.orderConfirmationScreen,
                          arguments: placeOrderCubit.orderId);
                      // Navigator.popAndPushNamed(
                      //     context, Routes.orderConfirmationScreen,
                      //     arguments: placeOrderCubit.orderId);
                    });
              },
              builder: (BuildContext context, PlaceOrderState placeOrderState) {
                return CommonButton(
                  title: languageProvider.getTranslated(
                      context, StringsConstants.placeOrder),
                  width: MediaQuery.of(context).size.width * 0.92,
                  height: 50,
                  replaceWithIndicator:
                      (placeOrderState is Loading) ? true : false,
                  margin: EdgeInsets.only(bottom: 20),
                  onTap: () {
                    placeOrderCubit.placeOrder(
                      cartItemStatus,
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget deliverTo() {
    return ProviderNotifier(
      child: (AddressesProvider addressesProvider) {
        return GestureDetector(
          onTap: () {
            routerUtils.pushNamedRoot(context, Routes.addOrEditAddressScreen,
                arguments: addressesProvider.selectedAddress);
            // Navigator.pushNamed(context, Routes.addOrEditAddressScreen,
            //     arguments: addressesProvider.selectedAddress);
          },
          child: CommonCard(
              child: Container(
            margin: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      languageProvider.getTranslated(
                          context, StringsConstants.deliverTo)!,
                      style: AppTextStyles.normalText,
                    ),
                    ActionText(
                      title: addressesProvider.selectedAddress == null
                          ? languageProvider.getTranslated(
                              context, StringsConstants.addNewTextCapital)!
                          : languageProvider.getTranslated(
                              context, StringsConstants.changeTextCapital)!,
                      onTap: () {
                        routerUtils.pushNamedRoot(context, Routes.myAddressScreen,
                            arguments: true);
                        // Navigator.pushNamed(context, Routes.myAddressScreen,
                        //     arguments: true);
                      },
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  '${addressesProvider.selectedAddress!.area} , ${addressesProvider.selectedAddress!.streetName}',
                  style: AppTextStyles.normalText,
                ),
                addressesProvider.selectedAddress!.landmarkSign != null
                    ? Column(
                        children: [
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            addressesProvider.selectedAddress!.landmarkSign!,
                            style: AppTextStyles.normalText,
                          ),
                        ],
                      )
                    : Container(),
              ],
            ),
          )),
        );
      },
    );
  }

  Widget paymentSummary(
      {required num priceInCart, required double deliveryFee}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          languageProvider.getTranslated(
              context, StringsConstants.paymentSummary)!,
          style: TextStyle(fontSize: 19, fontWeight: FontWeight.w600),
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(languageProvider.getTranslated(
                context, StringsConstants.subtotal)!),
            Text(
                '${languageProvider.getTranslated(context, StringsConstants.egyptCurrency)} $priceInCart'),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(languageProvider.getTranslated(
                context, StringsConstants.deliveryFee)!),
            Text(
                '${languageProvider.getTranslated(context, StringsConstants.egyptCurrency)!} $deliveryFee'),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              languageProvider.getTranslated(
                  context, StringsConstants.totalAmount)!,
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 17),
            ),
            Text(
              '${languageProvider.getTranslated(context, StringsConstants.egyptCurrency)!} ${deliveryFee + priceInCart}',
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 17),
            ),
          ],
        ),
      ],
    );
  }

  Widget notesView() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: CustomTextField(
        maxLines: 3,
        hint: languageProvider.getTranslated(
            context, StringsConstants.orderNotesStatement),
      ),
    );
  }
}
