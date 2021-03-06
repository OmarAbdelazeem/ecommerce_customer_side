import 'package:baqal/src/di/app_injector.dart';
import 'package:baqal/src/notifiers/language_notifier.dart';
import 'package:flutter/material.dart';
import 'package:baqal/src/notifiers/cart_status_provider.dart';
import 'package:baqal/src/notifiers/provider_notifier.dart';
import 'package:baqal/src/res/app_colors.dart';
import 'package:baqal/src/res/string_constants.dart';
import 'package:baqal/src/res/text_styles.dart';

class CommonViewCartOverlay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final languageProvider = getItInstance<LanguageProvider>();
    return ProviderNotifier<CartStatusProvider>(
      child: (CartStatusProvider value) {
        return   AnimatedCrossFade(
          duration: Duration(microseconds: 3000),
          firstChild: Container(
            height: 50,
            margin: EdgeInsets.all(20),
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.circular(10)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "${value.noOfItemsInCart} item${value.noOfItemsInCart > 1 ? "s" : ""} | EGP${value.priceInCart}",
                  style: AppTextStyles.normalText,
                ),
                SizedBox(
                  width: 10,
                ),
                InkWell(
                  onTap: () {
                    // Navigator.of(context).pushNamed(Routes.cartScreen);
                  },
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.shopping_cart, color: AppColors.white),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        languageProvider.getTranslated(context, StringsConstants.viewCart)!,
                        style: AppTextStyles.normalText,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          secondChild: SizedBox(),
          crossFadeState: value.noOfItemsInCart > 0
              ? CrossFadeState.showFirst
              : CrossFadeState.showSecond,
        ) ;
      },
    );
  }
}
