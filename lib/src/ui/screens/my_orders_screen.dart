import 'package:baqal/src/models/basic_order_model.dart';
import 'package:baqal/src/notifiers/language_notifier.dart';
import 'package:baqal/src/routes/router_utils.dart';
import 'package:baqal/src/routes/routes_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:baqal/src/bloc/base_states/result_state/result_api_builder.dart';
import 'package:baqal/src/bloc/base_states/result_state/result_state.dart';
import 'package:baqal/src/bloc/my_orders/my_orders_cubit.dart';
import 'package:baqal/src/core/utils/date_time_util.dart';
import 'package:baqal/src/di/app_injector.dart';
import 'package:baqal/src/res/string_constants.dart';
import 'package:baqal/src/res/text_styles.dart';
import 'package:baqal/src/ui/common/common_app_loader.dart';

class MyOrdersScreen extends StatefulWidget {
  @override
  _MyOrdersScreenState createState() => _MyOrdersScreenState();
}

class _MyOrdersScreenState extends State<MyOrdersScreen> {
  MyOrdersCubit ordersCubit = getItInstance<MyOrdersCubit>();
  ScrollController controller = ScrollController();
  final languageProvider= getItInstance<LanguageProvider>();
  final routerUtils = getItInstance<RouterUtils>();

  @override
  void initState() {
    super.initState();
    ordersCubit.listenToOrders();
    controller.addListener(_scrollListener);
  }

  void _scrollListener() {
    if (controller.offset >= controller.position.maxScrollExtent &&
        !controller.position.outOfRange) {
      print("at the end of list");
      ordersCubit.fetchNextList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(languageProvider.getTranslated(context, StringsConstants.myOrders)!),
      ),
      body: BlocBuilder<MyOrdersCubit, ResultState<List<BasicOrderModel>>>(
        bloc: ordersCubit,
        builder:
            (BuildContext context, ResultState<List<BasicOrderModel>> state) {
          print('state  is $state');

          return ResultStateBuilder(
            state: state,
            loadingWidget: (bool isReloading) {
              return Center(
                child: CommonAppLoader(),
              );
            },
            dataWidget: (List<BasicOrderModel> orders) {
              return orderView(orders);
            },
            errorWidget: (String error) {
              return Container();
            },
          );
        },
      ),
    );
  }

  Widget orderView(List<BasicOrderModel> orderList) {
    return ListView.builder(
      controller: controller,
      itemCount: orderList.length,
      itemBuilder: (BuildContext context, int orderListIndex) {
        return Padding(
          padding: const EdgeInsets.only(top: 30),
          child: InkWell(
            onTap: () {
              routerUtils.pushNamedRoot(context, Routes.orderDetailsScreen,
                  arguments: orderList[orderListIndex].orderId);
              // Navigator.pushNamed(context, Routes.orderDetailsScreen,
              //     arguments: orderList[orderListIndex].orderId);
            },
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
                              child: Row(
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      orderList[orderListIndex].orderNumber !=
                                              null
                                          ? Text(
                                              '${languageProvider.getTranslated(context, StringsConstants.orderNumber)}: ${orderList[orderListIndex].orderNumber}',
                                              // style: AppTextStyles.normal12Color81819A,
                                            )
                                          : Container(),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                          '${languageProvider.getTranslated(context, StringsConstants.total)} : ${orderList[orderListIndex].total} ${languageProvider.getTranslated(context, StringsConstants.egyptCurrency)}'),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        getOrderedTime(orderList[orderListIndex]
                                            .orderedAt ,isEnglish: languageProvider.isEnglish),
                                        style: AppTextStyles.normalText,
                                      )
                                    ],
                                  ),
                                  Text(
                                    '${languageProvider.getTranslated(context, orderList[orderListIndex].orderStatus)}',
                                    style: TextStyle(
                                        color: Colors.amber, fontSize: 17),
                                  )
                                ],
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                              ),
                            ),
                          ],
                        ),

                        // orderCard(orderList[orderListIndex].orderItems![0]!),
                        Icon(Icons.more_horiz),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(languageProvider.getTranslated(context, StringsConstants.viewOrderDetails)!),
                            Icon(Icons.arrow_forward_ios)
                          ],
                        )
                      ],
                    )),
                (orderListIndex < orderList.length) ? Divider() : Container()
              ],
            ),
          ),
        );
      },
    );
  }

  // Widget getOrderStatusIcon(String orderStatus) {
  //   // Processing ,Shipped, Delivered , Cancelled
  //   if (orderStatus == "Delivered") {
  //     return Icon(
  //       Icons.check_circle,
  //       color: AppColors.color5EB15A,
  //     );
  //   } else if (orderStatus == "Cancelled") {
  //     return Icon(
  //       Icons.close,
  //       color: AppColors.color5EB15A,
  //     );
  //   } else {
  //     return Icon(
  //       Icons.info,
  //       color: AppColors.colorFFE57F,
  //     );
  //   }
  // }
}
