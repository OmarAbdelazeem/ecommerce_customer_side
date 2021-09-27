import 'package:baqal/src/core/utils/date_time_util.dart';
import 'package:baqal/src/di/app_injector.dart';
import 'package:baqal/src/models/account_details_model.dart';
import 'package:baqal/src/models/order_model.dart';
import 'package:baqal/src/notifiers/language_notifier.dart';
import 'package:baqal/src/res/string_constants.dart';
import 'package:baqal/src/res/text_styles.dart';
import 'package:baqal/src/routes/router_utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:baqal/src/bloc/order_item/order_item.dart' as order_item;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderDetailsScreen extends StatefulWidget {
  final String orderId;

  OrderDetailsScreen(this.orderId);

  @override
  _OrderDetailsScreenState createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  final orderCubit = getItInstance<order_item.OrderCubit>();
  final languageProvider= getItInstance<LanguageProvider>();
  final routerUtils = getItInstance<RouterUtils>();

  @override
  void initState() {
    fetchOrderDetails();
    super.initState();
  }

  void fetchOrderDetails() {
    orderCubit.listenToOrderDetails(widget.orderId);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: Text(getTranslated(context, StringsConstants.orderDetails)!),
        title: Text(languageProvider.getTranslated(context, StringsConstants.orderDetails)!),
      ),
      body: BlocConsumer(
        bloc: orderCubit,
        listener: (BuildContext context, state) {},
        builder: (BuildContext context, state) {
          if (state is order_item.Loaded) {
            return orderView(state.order);
          } else if (state is order_item.Loading)
            return Center(
              child: CircularProgressIndicator(),
            );
          return Container();
        },
      ),
    );
  }

  Widget orderView(OrderModel order) {
    return SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
                margin: EdgeInsets.only(top: 20, left: 16, right: 16),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              getOrderStatusColor(order.orderStatus!),
                              SizedBox(
                                height: 10,
                              ),
                              order.orderStatus == 'Processing'
                                  ? TextButton(
                                  onPressed: showConfirmationDialogue,
                                  child: Text(languageProvider.getTranslated(context, StringsConstants.cancelOrder)!, style: TextStyle(
                                      color: Colors.red, fontSize: 16),))
                                  : Container(),
                              Text(
                                getOrderedTime(order.orderedAt!,isEnglish: languageProvider.isEnglish),
                                style: AppTextStyles.normalText,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    ...List<Widget>.generate(order.orderItems!.length,
                            (index) => orderCard(order.orderItems![index]!)),
                    SizedBox(
                      height: 10,
                    ),
                    deliveryAddress(order.orderAddress),
                    SizedBox(
                      height: 30,
                    ),
                    paymentSummary(total: order.total),
                  ],
                )),
            // (orderListIndex < orderList.length) ? Divider() : Container()
          ],
        ));
  }

  Widget orderCard(OrderItem orderItem) {
    return Container(
      margin: EdgeInsets.only(top: 16, bottom: 20),
      child: Card(
          child: Container(
            padding: EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CachedNetworkImage(
                      imageUrl: orderItem.image,
                      height: 46,
                      width: 46,
                      fit: BoxFit.fill,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Text(
                        //   orderItem.name,
                        //   style: AppTextStyles.normal14Black,
                        // ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "${languageProvider.getTranslated(context, StringsConstants.egyptCurrency)} ${orderItem.price}",
                          style: AppTextStyles.normalText,
                        ),
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
               languageProvider.isEnglish ? Text(
                  "${orderItem.noOfItems} item ${orderItem.noOfItems > 1
                      ? "s"
                      : ""}",
                  style: AppTextStyles.normalText,
                ) : Text(
                 "${orderItem.noOfItems} عنصر ${orderItem.noOfItems > 1
                     ? "عناصر"
                     : ""}",
                 style: AppTextStyles.normalText,
               ),
              ],
            ),
          )),
    );
  }

  Widget deliveryAddress(Address address) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.shopping_basket_outlined,
              size: 35,
            ),
            SizedBox(
              width: 15,
            ),
            Text(
              languageProvider.getTranslated(context, StringsConstants.deliveryAddress)!,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            )
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(left: 15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Text(
              //   address.name,
              //   style: TextStyle(fontSize: 17),
              // ),
              SizedBox(
                height: 10,
              ),
              Text(address.area, style: TextStyle(fontSize: 17)),
              SizedBox(
                height: 10,
              ),
              Text(address.streetName, style: TextStyle(fontSize: 17)),
              SizedBox(
                height: 10,
              ),
              Text('${languageProvider.getTranslated(context, StringsConstants.phoneNumber)}: ${address.phoneNumber}',
                  style: TextStyle(fontSize: 17)),
            ],
          ),
        )
      ],
    );
  }

  Widget paymentSummary({required num total, num? subTotal, num? deliveryFee}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.receipt_long,
              size: 35,
            ),
            SizedBox(
              width: 15,
            ),
            Text(
              languageProvider.getTranslated(context, StringsConstants.paymentSummary)!,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(languageProvider.getTranslated(context, StringsConstants.subtotal)!),
            Text('${languageProvider.getTranslated(context, StringsConstants.egyptCurrency)} $total'),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(languageProvider.getTranslated(context, StringsConstants.deliveryFee)!),
            Text('${languageProvider.getTranslated(context, StringsConstants.egyptCurrency)} 10'),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(languageProvider.getTranslated(context, StringsConstants.totalAmount)!),
            Text('${languageProvider.getTranslated(context, StringsConstants.egyptCurrency)} 32'),
          ],
        ),
        SizedBox(
          height: 20,
        )
      ],
    );
  }

  Widget getOrderStatusColor(String status) {
    if (status == 'Processing') {
      return Text(
        languageProvider.getTranslated(context, status)!,
        style: TextStyle(color: Colors.amber, fontSize: 18),
      );
    } else if (status == 'Delivering') {
      return Text(languageProvider.getTranslated(context, status)!,
          style: TextStyle(color: Colors.blue.shade500, fontSize: 18));
    } else if (status == 'Delivered') {
      return Text(
        languageProvider.getTranslated(context, status)!,
        style: TextStyle(color: Colors.green.shade500, fontSize: 18),
      );
    } else {
      return Text(
        'Cancelled',
        style: TextStyle(color: Colors.red.shade500, fontSize: 18),
      );
    }
  }

  void showConfirmationDialogue() async {
    await showDialog(context: context, builder: (BuildContext dialogueContext) {
      return AlertDialog(
        title: Text(languageProvider.getTranslated(context, StringsConstants.cancelOrder)!),
        content: Text(languageProvider.getTranslated(context, StringsConstants.cancelOrderStatementText)!),
        actions: [
          TextButton(onPressed: () async {
            routerUtils.pop(context);
            // Navigator.pop(context);
            await orderCubit.cancelOrder(widget.orderId);
          }, child: Text(languageProvider.getTranslated(context, StringsConstants.yes)!)),
          TextButton(onPressed: () {
            routerUtils.pop(context);
            // Navigator.pop(context);
          }, child: Text(languageProvider.getTranslated(context, StringsConstants.no)!))
        ],
      );
    });
  }
}
