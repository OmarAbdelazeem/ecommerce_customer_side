import 'package:baqal/src/di/app_injector.dart';
import 'package:baqal/src/notifiers/account_provider.dart';
import 'package:baqal/src/notifiers/cart_status_provider.dart';
import 'package:baqal/src/notifiers/provider_notifier.dart';
import 'package:baqal/src/res/text_styles.dart';
import 'package:baqal/src/routes/router_utils.dart';
import 'package:baqal/src/routes/routes_constants.dart';
import 'package:flutter/material.dart';

class CartIcon extends StatelessWidget {
  final bool isOutlined;
  final bool isClickable;

  CartIcon({this.isOutlined = false, this.isClickable = false});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: isClickable
          ? () {
              final routerUtils = getItInstance<RouterUtils>();
              routerUtils.pushNamedRoot(context, Routes.cartScreen);
            }
          : null,
      child: Stack(
        children: <Widget>[
          Center(
            child: isClickable
                ? Icon(
                    Icons.shopping_cart,
                    size: 30,
                  )
                : Icon(
                    isOutlined
                        ? Icons.shopping_cart_outlined
                        : Icons.shopping_cart,
                    size: 30,

                  ),
          ),
          ProviderNotifier<CartStatusProvider>(
            child: (CartStatusProvider value) {
              return Visibility(
                visible: value.noOfItemsInCart > 0,
                child: Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Align(
                    alignment: Alignment.center,
                    child: CircleAvatar(
                      minRadius: 6,
                      maxRadius: 7,
                      backgroundColor: Colors.red,
                      child: Text(
                        "${value.noOfItemsInCart}",
                        style: AppTextStyles.normalText,
                      ),
                    ),
                  ),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
