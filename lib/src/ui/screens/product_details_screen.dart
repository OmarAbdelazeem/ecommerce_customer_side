import 'package:baqal/src/notifiers/account_provider.dart';
import 'package:baqal/src/notifiers/language_notifier.dart';
import 'package:baqal/src/res/string_constants.dart';
import 'package:baqal/src/ui/common/add_to_cart_view.dart';
import 'package:baqal/src/ui/common/cart_icon.dart';
import 'package:baqal/src/ui/common/product_not_available.dart';
import 'package:baqal/src/ui/common/snack_bar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:baqal/src/bloc/add_to_cart/add_to_cart_cubit.dart';
import 'package:baqal/src/bloc/add_to_cart/add_to_cart_state.dart';
import 'package:baqal/src/di/app_injector.dart';
import 'package:baqal/src/models/product_model.dart';

import 'package:baqal/src/res/text_styles.dart';

class ProductDetailsScreen extends StatefulWidget {
  final ProductModel product;

  ProductDetailsScreen(this.product);

  @override
  _ProductDetailsScreenState createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  var addToCartCubit = getItInstance<AddToCartCubit>();
  final languageProvider = getItInstance<LanguageProvider>();
  final accountProvider = getItInstance<AccountProvider>();

  @override
  void initState() {
    super.initState();
    addToCartCubit.listenToCartItem(widget.product.productId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: widget.product.remainQuantity! > 0
          ? BlocConsumer<AddToCartCubit, AddToCartState>(
              bloc: addToCartCubit,
              builder: (BuildContext context, AddToCartState state) {
                return AddToCartView(
                    addToCartCubit: addToCartCubit,
                    product: widget.product,
                    context: context);
              },
              listener: (BuildContext context, AddToCartState state) {
                if (state is UpdateCartError)
                  showSnackBar(title: state.errorMessage, context: context);
                else if (state is AddToCartError)
                  showSnackBar(title: state.errorMessage, context: context);
                else if (state is DeleteCartError) {
                  showSnackBar(title: state.errorMessage, context: context);
                }
              },
            )
          : Container(),
      appBar: AppBar(
        title: Container(
          child: Text(languageProvider.isEnglish
              ? widget.product.name.english
              : widget.product.name.arabic),
          width: MediaQuery.of(context).size.width * 0.6,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CartIcon(
              isClickable: true,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            CachedNetworkImage(
              imageUrl: widget.product.image!,
              fit: BoxFit.fill,
            ),
            Container(
              margin: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    languageProvider.isEnglish
                        ? widget.product.name.english
                        : widget.product.name.arabic,
                    style: AppTextStyles.normalText,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(languageProvider.isEnglish
                      ? widget.product.description!.english
                      : widget.product.description!.arabic),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "${languageProvider.getTranslated(context, StringsConstants.egyptCurrency)} ${widget.product.price}",
                        style: AppTextStyles.normalText,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      widget.product.remainQuantity == 0
                          ? Align(
                              alignment: Alignment.center,
                              child: productNotAvailable())
                          : Container()
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
