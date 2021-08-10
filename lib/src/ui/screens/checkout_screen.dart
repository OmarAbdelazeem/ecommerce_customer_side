
import 'package:baqal/src/bloc/place_order/place_order.dart';
import 'package:baqal/src/core/navigation.dart';
import 'package:baqal/src/di/app_injector.dart';
import 'package:baqal/src/notifiers/account_provider.dart';
import 'package:baqal/src/notifiers/provider_notifier.dart';
import 'package:baqal/src/res/string_constants.dart';
import 'package:baqal/src/res/text_styles.dart';
import 'package:baqal/src/ui/common/action_text.dart';
import 'package:baqal/src/ui/common/common_button.dart';
import 'package:baqal/src/ui/common/common_card.dart';
import 'package:baqal/src/ui/screens/add_address_screen.dart';
import 'package:baqal/src/ui/screens/select_adress_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../di/app_injector.dart';
import '../../notifiers/cart_status_provider.dart';
import 'order_confirmation.dart';

class CheckOutScreen extends StatefulWidget {

  @override
  _CheckOutScreenState createState() => _CheckOutScreenState();
}

class _CheckOutScreenState extends State<CheckOutScreen> {
  var placeOrderCubit = getItInstance<PlaceOrderCubit>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Checkout'),
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
                    'Pay with',
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
                        const Text('Cash'),
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
                child: paymentSummary(),
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: BlocConsumer<PlaceOrderCubit, PlaceOrderState>(
              bloc: placeOrderCubit,
              listener: (BuildContext context, PlaceOrderState state) {
                state.when(
                    orderPlacedInProgress: () {},
                    idle: () {},
                    orderNotPlaced: (String message) {},
                    orderSuccessfullyPlaced: () {
                      // if (Navigator.canPop(context)) {
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) {
                          return OrderConfirmationScreen(placeOrderCubit.orderId);
                        }));
                      // }
                    });
              },
              builder: (BuildContext context, PlaceOrderState placeOrderState) {
                return CommonButton(
                  title: 'Place order',
                  width: MediaQuery.of(context).size.width * 0.92,
                  height: 50,
                  replaceWithIndicator:
                      (placeOrderState is OrderPlacedInProgress) ? true : false,
                  margin: EdgeInsets.only(bottom: 20),
                  onTap: () {
                    //Todo fix this as before
                    var addressProvider = getItInstance<AccountProvider>();
                    if (addressProvider.addressSelected != null) {
                      CartStatusProvider cartItemStatus = getItInstance<CartStatusProvider>();
                        placeOrderCubit.placeOrder(cartItemStatus,);

                    } else {
                      // showSnackBar(title: StringsConstants.noAddressSelected);
                    }

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
    return ProviderNotifier<AccountProvider>(
      child: (AccountProvider accountProvider) {
        return CommonCard(
            child: Container(
          margin: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    StringsConstants.deliverTo,
                    style: AppTextStyles.medium14Black,
                  ),
                  ActionText(
                   title:  accountProvider.addressSelected == null
                        ? StringsConstants.addNewCaps
                        : StringsConstants.changeTextCapital,
                    onTap: () {
                      if (accountProvider.addressSelected == null) {
                        Navigation.push(context, AddAddressScreen(true));

                      } 
                      else {
                        Navigation.push(context, SelectAddressScreen());
                      }
                    },
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Text(
               '${accountProvider.addressSelected.city} , ${accountProvider.addressSelected.state}',
                style: AppTextStyles.medium12Color81819A,
              ),
              SizedBox(height: 15,),
              Text(
                accountProvider.addressSelected.address,
                style: AppTextStyles.medium12Color81819A,
              ),
            ],
          ),
        ));
      },
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
