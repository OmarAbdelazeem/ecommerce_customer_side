import 'package:baqal/src/bloc/place_order/place_order.dart';
import 'package:baqal/src/bloc/place_order/place_order_cubit.dart';
import 'package:baqal/src/di/app_injector.dart';
import 'package:baqal/src/notifiers/addresses_provider.dart';
import 'package:baqal/src/notifiers/language_notifier.dart';
import 'package:baqal/src/res/string_constants.dart';
import 'package:baqal/src/res/text_styles.dart';
import 'package:baqal/src/ui/common/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../common/common_card.dart';

class OrderConfirmationScreen extends StatefulWidget {
  final String orderId;

  OrderConfirmationScreen(this.orderId);

  @override
  _OrderConfirmationScreenState createState() =>
      _OrderConfirmationScreenState();
}

class _OrderConfirmationScreenState extends State<OrderConfirmationScreen> {
  final placeOrderCubit = getItInstance<PlaceOrderCubit>();
  final languageProvider = getItInstance<LanguageProvider>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Order conformation'),
        ),
        body: BlocBuilder<PlaceOrderCubit, PlaceOrderState>(
          bloc: placeOrderCubit,
          builder: (context, state) {
            if (state is OrderCanceled)
              return orderCanceledView();
            else {
              if (state is Error)
                showSnackBar(context: context, title: state.message);
              return orderConfirmationView();
            }
          },
        ));
  }

  Widget orderCanceledView() {
    return Column(
      children: [
        Image.asset('assets/images/order-canceled.gif'),
        Text(
          'Order was canceled',
          style: TextStyle(fontSize: 25, color: Colors.red),
        ),
      ],
    );
  }

  Widget orderConfirmationView() {
    Widget deliverTo() {
      final addressesProvider = getItInstance<AddressesProvider>();
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
                  languageProvider.getTranslated(context, StringsConstants.deliverTo)!,
                  style: AppTextStyles.normalText,
                ),
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
      ));
    }

    return Container(
      width: MediaQuery.of(context).size.width * 0.99,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 15,
          ),
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
              },
              child: Text(
                'Cancel order',
                style: TextStyle(fontSize: 17, color: Colors.red),
              )),
          SizedBox(
            height: 20,
          ),
          deliverTo(),
          Image.asset(
            'assets/images/order-success.gif',
          )
        ],
      ),
    );
  }
}
