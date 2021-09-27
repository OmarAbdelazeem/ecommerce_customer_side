import 'package:baqal/src/bloc/add_to_cart/add_to_cart_cubit.dart';
import 'package:baqal/src/bloc/add_to_cart/add_to_cart_state.dart';
import 'package:baqal/src/di/app_injector.dart';
import 'package:baqal/src/notifiers/account_provider.dart';
import 'package:baqal/src/notifiers/cart_status_provider.dart';
import 'package:baqal/src/notifiers/language_notifier.dart';
import 'package:baqal/src/res/string_constants.dart';
import 'package:baqal/src/routes/router_utils.dart';
import 'package:baqal/src/routes/routes_constants.dart';
import 'package:baqal/src/ui/common/product_not_available.dart';
import 'package:baqal/src/ui/common/snack_bar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:baqal/src/models/product_model.dart';
import 'package:baqal/src/res/text_styles.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'add_to_cart_view.dart';

class ProductCard extends StatefulWidget {
  final ProductModel product;

  ProductCard({required this.product});

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  var addToCartCubit = getItInstance<AddToCartCubit>();
  final accountProvider = getItInstance<AccountProvider>();
  final cartStatusProvider = getItInstance<CartStatusProvider>();
  final languageProvider = getItInstance<LanguageProvider>();
  final routerUtils = getItInstance<RouterUtils>();
  @override
  void initState() {
    // if (accountProvider.user != null) {
    addToCartCubit.listenToCartItem(widget.product.productId);
    // }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: () {
        routerUtils.pushNamedRoot(context, Routes.productDetailsScreen,arguments: widget.product);
        // Navigator.pushNamed(context, Routes.productDetailsScreen,
        //     arguments: widget.product);
      },
      child: Container(
        width: 180,
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          color: Colors.white,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10)),
                  child: CachedNetworkImage(
                    imageUrl: widget.product.image!,
                    fit: BoxFit.contain,
                    height: 100,
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        languageProvider.isEnglish
                            ? widget.product.name.english
                            : widget.product.name.arabic,
                        style: AppTextStyles.normalText,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Text(
                            "${languageProvider.getTranslated(context, StringsConstants.egyptCurrency)} ${widget.product.discountPrice}",
                            // style: AppTextStyles.normal12Black,
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          widget.product.discountPrice != widget.product.price
                              ? Text(
                                  "${languageProvider.getTranslated(context, StringsConstants.egyptCurrency)} ${widget.product.price}",
                                  style: TextStyle(
                                      decoration: TextDecoration.lineThrough),
                                )
                              : Container(),
                        ],
                      ),
                    ],
                  ),
                ),
                widget.product.remainQuantity! > 0
                    ? BlocConsumer<AddToCartCubit, AddToCartState>(
                        bloc: addToCartCubit,
                        builder: (BuildContext context, AddToCartState state) {
                          return AddToCartView(
                              addToCartCubit: addToCartCubit,
                              product: widget.product,
                              isForProductCard: true,
                              height: 40,
                              context: context);
                        },
                        listener: (BuildContext context, AddToCartState state) {
                          if (state is UpdateCartError)
                            showSnackBar(
                                title: state.errorMessage, context: context);
                          else if (state is AddToCartError)
                            showSnackBar(
                                title: state.errorMessage, context: context);
                          else if (state is DeleteCartError) {
                            showSnackBar(
                                title: state.errorMessage, context: context);
                          }
                        },
                      )
                    : productNotAvailable(),
                SizedBox(
                  height: 10,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
