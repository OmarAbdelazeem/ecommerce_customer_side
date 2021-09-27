import 'package:baqal/src/notifiers/account_provider.dart';
import 'package:baqal/src/notifiers/language_notifier.dart';
import 'package:baqal/src/res/string_constants.dart';
import 'package:baqal/src/routes/router_utils.dart';
import 'package:baqal/src/ui/common/snack_bar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:baqal/src/bloc/cart_item/cart_item.dart';
import 'package:baqal/src/di/app_injector.dart';
import 'package:baqal/src/models/cart_model.dart';
import 'package:baqal/src/res/app_colors.dart';
import 'package:baqal/src/ui/common/common_app_loader.dart';

import 'add_or_minus_button.dart';

class CartItemCard extends StatefulWidget {
  final CartItemModel cartModel;

  CartItemCard({required this.cartModel});

  @override
  State<CartItemCard> createState() => _CartItemCardState();
}

class _CartItemCardState extends State<CartItemCard> {
  var cartItemCubit = getItInstance<CartItemCubit>();
  final accountProvider = getItInstance<AccountProvider>();
  final languageProvider = getItInstance<LanguageProvider>();
  final routerUtils = getItInstance<RouterUtils>();

  @override
  void initState() {
    if(accountProvider.user !=null)cartItemCubit.listenToCartItemUpdates(widget.cartModel.productId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    void showConfirmationDialogue() async {
      await showDialog(
          context: context,
          builder: (dialogueContext) {
            return AlertDialog(
              title: Text(languageProvider.getTranslated(context, StringsConstants.removeItem)!),
              content: Text(languageProvider.getTranslated(context, StringsConstants.removeItemConfigurationText)!),
              actions: [
                TextButton(
                    onPressed: () {
                      cartItemCubit.deleteCartItem(widget.cartModel.productId);
                      routerUtils.pop(context);
                    },
                    child: Text(languageProvider.getTranslated(context, StringsConstants.yes)!)),
                TextButton(
                    onPressed: () {
                      routerUtils.pop(context);
                    },
                    child: Text(languageProvider.getTranslated(context, StringsConstants.no)!))
              ],
            );
          });
    }

    return Container(
      margin: EdgeInsets.only(bottom: 20),
      child: Card(
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CachedNetworkImage(
                        imageUrl: widget.cartModel.image,
                        height: 68,
                        width: 68,
                        fit: BoxFit.fill,
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.6,
                            child: Text(
                              languageProvider.isEnglish ? widget.cartModel.name.english : widget.cartModel.name.arabic,
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15,
                                  color: AppColors.black),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "${languageProvider.getTranslated(context, StringsConstants.egyptCurrency)} ${widget.cartModel.price} ",
                            style: TextStyle(
                                fontSize: 14, color: AppColors.color81819A),
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 26,
              ),
              BlocConsumer<CartItemCubit, CartItemState>(
                listener: (BuildContext context, CartItemState state) {
                  if (state is UpdateCartError)
                    showSnackBar(title: state.errorMessage, context: context);
                  else if (state is DeleteCartError)
                    showSnackBar(title: state.errorMessage, context: context);
                },
                bloc: cartItemCubit,
                builder: (BuildContext context, CartItemState state) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 110,
                        child: Row(
                          children: [
                            addOrMinusButton(
                                false,
                                state is CartDataLoading
                                    ? null
                                    : () {
                                        cartItemCubit.updateCartItem(
                                            widget.cartModel,
                                            widget.cartModel.numberOfItems,
                                            false);
                                      }),
                            Expanded(
                                child: Center(
                                    child: state is CartDataLoading
                                        ? CommonAppLoader(
                                            size: 20,
                                            strokeWidth: 3,
                                          )
                                        : Text(
                                            "${widget.cartModel.numberOfItems}",
                                            style: TextStyle(
                                              color: AppColors.black,
                                              fontSize: 14,
                                            ),
                                          ))),
                            addOrMinusButton(
                                true,
                                state is CartDataLoading
                                    ? null
                                    : () {
                                        cartItemCubit.updateCartItem(
                                            widget.cartModel,
                                            widget.cartModel.numberOfItems,
                                            true);
                                      })
                          ],
                        ),
                      ),
                      BlocBuilder<CartItemCubit, CartItemState>(
                        bloc: cartItemCubit,
                        builder: (BuildContext context, CartItemState state) {
                          if (state is CartDeleteLoading) {
                            return CommonAppLoader(
                              size: 20,
                            );
                          }
                          return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: IconButton(
                                icon: Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                                onPressed: () {
                                  showConfirmationDialogue();
                                },
                              ));
                        },
                      )
                    ],
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
