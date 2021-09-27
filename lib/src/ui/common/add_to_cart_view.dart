import 'package:baqal/src/di/app_injector.dart';
import 'package:baqal/src/models/product_model.dart';
import 'package:baqal/src/notifiers/account_provider.dart';
import 'package:baqal/src/notifiers/language_notifier.dart';
import 'package:baqal/src/res/app_colors.dart';
import 'package:baqal/src/res/string_constants.dart';
import 'package:baqal/src/routes/routes_constants.dart';
import 'package:flutter/material.dart';
import 'package:baqal/src/bloc/add_to_cart/add_to_cart_cubit.dart';
import 'package:baqal/src/bloc/add_to_cart/add_to_cart_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'add_or_minus_button.dart';
import 'common_app_loader.dart';

class AddToCartView extends StatefulWidget {
  final AddToCartCubit addToCartCubit;
  final ProductModel product;
  final BuildContext context;
  final bool isForProductCard;
  final double height;
  final double margin;

  AddToCartView(
      {required this.context,
      required this.product,
      required this.addToCartCubit,
      this.margin = 10,
      this.height = 50.0,
      this.isForProductCard = false});

  @override
  State<AddToCartView> createState() => _AddToCartViewState();
}

class _AddToCartViewState extends State<AddToCartView> {
  int initialCartValue = 0;
  final languageProvider = getItInstance<LanguageProvider>();

  @override
  Widget build(BuildContext context) {
    Widget addButton(AddToCartState state) {
      return AnimatedCrossFade(
        firstChild: InkWell(
          onTap: state is ShowCartValue
              ? null
              : () {
                  widget.addToCartCubit.addItemToCart(widget.product);
                },
          child: Container(
            width: MediaQuery.of(context).size.width * 0.8,
            height: widget.height,
            margin: EdgeInsets.symmetric(horizontal: widget.margin),
            padding: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.circular(10)),
            child: Center(
              child: Text(
                languageProvider.getTranslated(context, StringsConstants.addToCart)!,
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
        secondChild: SizedBox(
          height: 30,
          width: 110,
          child: Center(
            child: CommonAppLoader(
              size: 20,
              strokeWidth: 3,
            ),
          ),
        ),
        crossFadeState: state is AddToCardLoading
            ? CrossFadeState.showSecond
            : CrossFadeState.showFirst,
        duration: Duration(milliseconds: 100),
      );
    }

    return BlocBuilder<AddToCartCubit, AddToCartState>(
      bloc: widget.addToCartCubit,
      builder: (context, state) {
        if (state is ShowCartValue) {
          initialCartValue = state.cartItemNumber.toInt();
        }
        return AnimatedCrossFade(
            firstChild: addButton(state),
            secondChild: Container(
              height: widget.height,
              margin: EdgeInsets.symmetric(horizontal: widget.margin),
              padding: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.circular(10)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  widget.isForProductCard
                      ? Container()
                      : Text(
                          '${initialCartValue * widget.product.price} ${languageProvider.getTranslated(context, StringsConstants.egyptCurrency)}',
                          style: TextStyle(color: Colors.white),
                        ),
                  Row(
                    children: [
                      addOrMinusButton(
                          false,
                          state is CartDataLoading
                              ? null
                              : () {
                                  widget.addToCartCubit.updateCartItem(
                                      widget.product,
                                      initialCartValue,
                                      false);
                                }),
                      SizedBox(
                        width: 8,
                      ),
                      state is CartDataLoading
                          ? Center(
                              child: CommonAppLoader(
                              size: 20,
                              strokeWidth: 3,
                            ))
                          : Center(
                              child: Container(
                              height: 32,
                              width: 50,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(2),
                                  color: Colors.white),
                              child: Center(
                                child: Text(
                                  "$initialCartValue",
                                  style: TextStyle(
                                    color: AppColors.black,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            )),
                      SizedBox(
                        width: 8,
                      ),
                      addOrMinusButton(
                          true,
                          state is CartDataLoading
                              ? null
                              : () {
                                  widget.addToCartCubit.updateCartItem(
                                      widget.product, initialCartValue, true);
                                }),
                    ],
                  ),
                ],
              ),
            ),
            crossFadeState: (state is ShowCartValue ||
                    state is CartDataLoading ||
                    state is UpdateCartError ||
                    state is DeleteCartError)
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            duration: Duration(milliseconds: 100));
      },
    );
  }
}
