import 'package:baqal/src/bloc/place_order/place_order.dart';
import 'package:baqal/src/core/utils/date_time_util.dart';
import 'package:baqal/src/di/app_injector.dart';
import 'package:baqal/src/models/account_details_model.dart';
import 'package:baqal/src/models/order_model.dart';
import 'package:baqal/src/res/string_constants.dart';
import 'package:baqal/src/res/text_styles.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

enum OrderStatus { Processing, Delivering, Delivered, Cancelled }

class OrderDetailsScreen extends StatefulWidget {
  final OrderModel order;

  OrderDetailsScreen(this.order);

  @override
  _OrderDetailsScreenState createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  final placeOrderCubit = getItInstance<PlaceOrderCubit>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order details'),
      ),
      body: orderView(),
    );
  }

  Widget orderView() {
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
                            getOrderStatusStatement(widget.order.orderStatus!),
                            // Text(
                            //   'Your order is in processing...',
                            //   style: TextStyle(fontSize: 20),
                            // ),
                            // SizedBox(
                            //   height: 10,
                            // ),
                            TextButton(
                              child: Text('Cancel order',
                                  style: TextStyle(
                                      color: Colors.red, fontSize: 17)),
                              onPressed: () {
                                placeOrderCubit.cancelOrder(widget.order.orderId!);
                              },
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Order ID: ${widget.order.orderId}',
                              // style: AppTextStyles.normal12Color81819A,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              getOrderedTime(widget.order.orderedAt!),
                              style: AppTextStyles.medium14Black,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  ...List<Widget>.generate(widget.order.orderItems!.length,
                      (index) => orderCard(widget.order.orderItems![index]!)),
                  SizedBox(
                    height: 10,
                  ),
                  deliveryAddress(widget.order.orderAddress!),
                  SizedBox(
                    height: 30,
                  ),
                  paymentSummary(),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     Row(
                  //       children: [
                  //         Text(
                  //           StringsConstants.totalCaps,
                  //           style: AppTextStyles.normal12Color81819A,
                  //         ),
                  //         SizedBox(
                  //           width: 13,
                  //         ),
                  //         Text(
                  //           "EGP ${widget.order.total}",
                  //           style: AppTextStyles.normal14Black,
                  //         )
                  //       ],
                  //     ),
                  //     Row(
                  //       children: [
                  //         Text(
                  //           "${widget.order.orderStatus}",
                  //           style: AppTextStyles.normal14Color81819A,
                  //         ),
                  //         SizedBox(
                  //           width: 10,
                  //         ),
                  //       ],
                  //     )
                  //   ],
                  // ),
                  // SizedBox(
                  //   height: 20,
                  // )
                ],
              )),
          // (orderListIndex < orderList.length) ? Divider() : Container()
        ],
      ),
    );
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
                    Text(
                      orderItem.name,
                      style: AppTextStyles.normal14Black,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "EGP ${orderItem.price}",
                      style: AppTextStyles.normal14Color81819A,
                    ),
                  ],
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "${orderItem.noOfItems} item${orderItem.noOfItems > 1 ? "s" : ""}",
              style: AppTextStyles.normal14Color81819A,
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
              Icons.motorcycle_outlined,
              size: 35,
            ),
            SizedBox(
              width: 15,
            ),
            Text(
              'Delivery Address',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            )
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(left: 15.0, top: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                address.name,
                style: TextStyle(fontSize: 17),
              ),
              SizedBox(
                height: 10,
              ),
              Text(address.city, style: TextStyle(fontSize: 17)),
              SizedBox(
                height: 10,
              ),
              Text(address.address, style: TextStyle(fontSize: 17)),
              SizedBox(
                height: 10,
              ),
              Text('Mobile: ${address.phoneNumber}',
                  style: TextStyle(fontSize: 17)),
            ],
          ),
        )
      ],
    );
  }

  Widget paymentSummary() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Payment Summary',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Subtotal'),
            Text('EGP ${widget.order.total}'),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Service charge'),
            Text('EGP 10'),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Total amount'),
            Text('EGP 32'),
          ],
        ),
        SizedBox(
          height: 20,
        )
      ],
    );
  }

  Widget getOrderStatusStatement(String status) {
    if (status == 'Processing') {
      return Text(
        'Your order is in processing',
        style: TextStyle(color: Colors.amber),
      );
    } else if (status == 'Delivering') {
      return Text('You will receive your order soon',
          style: TextStyle(color: Colors.deepPurple));
    } else if (status == 'Delivered') {
      return Text(
        'You received your order',
        style: TextStyle(color: Colors.green),
      );
    } else {
      return Text(
        'You cancelled your order',
        style: TextStyle(color: Colors.red),
      );
    }
  }
}
