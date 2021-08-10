import 'package:baqal/src/bloc/my_address/my_address.dart';
import 'package:baqal/src/bloc/place_order/place_order_cubit.dart';
import 'package:baqal/src/core/navigation.dart';
import 'package:baqal/src/di/app_injector.dart';
import 'package:baqal/src/res/string_constants.dart';
import 'package:baqal/src/res/text_styles.dart';
import 'package:flutter/material.dart';
import '../../notifiers/account_provider.dart';
import '../../notifiers/provider_notifier.dart';
import '../common/common_card.dart';

class OrderConfirmationScreen extends StatefulWidget {
  String orderId;
  OrderConfirmationScreen(this.orderId);
  @override
  _OrderConfirmationScreenState createState() =>
      _OrderConfirmationScreenState();
}

class _OrderConfirmationScreenState extends State<OrderConfirmationScreen> {
  MyAddressCubit myAddressCubit = getItInstance<MyAddressCubit>();
  final placeOrderCubit = getItInstance<PlaceOrderCubit>();

  @override
  void initState() {
    // TODO: implement initState
    myAddressCubit.listenToAccountDetails();
    myAddressCubit.fetchAccountDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigation.popUntil(context);
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Order conformation'),
        ),
        body: Container(
          width: MediaQuery.of(context).size.width * 0.99,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Your order sent to the market',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 22),
              ),
              Text(
                'Waiting for response...',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 22),
              ),
              FlatButton(
                  onPressed: () {
                    placeOrderCubit.cancelOrder(widget.orderId);
                    Navigation.popUntil(context);
                  },
                  child: Text(
                    'Cancel order',
                    style: TextStyle(fontSize: 17, color: Colors.red),
                  )),
              SizedBox(
                height: 20,
              ),
              deliverTo()
            ],
          ),
        ),
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
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                '${accountProvider.addressSelected.city} , ${accountProvider.addressSelected.state}',
                style: AppTextStyles.medium12Color81819A,
              ),
              SizedBox(
                height: 15,
              ),
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
}
