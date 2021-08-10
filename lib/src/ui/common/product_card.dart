import 'package:auto_route/auto_route.dart';
import 'package:baqal/src/core/navigation.dart';
import 'package:baqal/src/ui/screens/product_detail_page.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:baqal/src/models/product_model.dart';
import 'package:baqal/src/res/text_styles.dart';


class ProductCard extends StatelessWidget {
  final ProductModel productModel;
  final fromCategories;

  ProductCard({required this.productModel, this.fromCategories = false});

  @override
  Widget build(BuildContext context) {
    StackRouter appRouter = AutoRouter.of(context);
    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: () {
        Navigation.push(context , ProductDetailPage(productModel));

      },
      child: fromCategories
          ? _verticalProductView(context, productModel)
          : _horizontalProductView(context, productModel),
    );
  }
}

Widget _verticalProductView(BuildContext context, ProductModel productModel) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 8.0),
    child: Container(
      width: MediaQuery.of(context).size.width * 0.98,
      height: 180,
      child: Card(
        // elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        color: Colors.white,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10), topRight: Radius.circular(10)),
              child: CachedNetworkImage(
                height: MediaQuery.of(context).size.height * .4,
                width: MediaQuery.of(context).size.width * .35,
                imageUrl: productModel.image,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.5,
              margin: EdgeInsets.all(5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    productModel.name,
                    style: AppTextStyles.medium14Black,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: <Widget>[
                      Text(
                        "EGP${productModel.currentPrice}",
                        style: AppTextStyles.normal12Black,
                      ),
                      // SizedBox(
                      //   width: 10,
                      // ),
                      // Text(
                      //   "${productModel.currency}${productModel.actualPrice}",
                      //   style: AppTextStyles.normal12Color81819AStroke,
                      // ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  // Text(
                  //   "${productModel.quantityPerUnit}${productModel.unit}",
                  //   style: AppTextStyles.normal12Color81819A,
                  // ),
                ],
              ),
            )
          ],
        ),
      ),
    ),
  );
}

Widget _horizontalProductView(BuildContext context, ProductModel productModel) {
  return Container(
    width: 150,
    height: 150,
    child: Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10), topRight: Radius.circular(10)),
            child: AspectRatio(
              aspectRatio: 1.5,
              child: CachedNetworkImage(
                imageUrl: productModel.image,
                fit: BoxFit.fitWidth,
              ),
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
                  productModel.name,
                  style: AppTextStyles.medium14Black,
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  children: <Widget>[
                    Text(
                      "Egp ${productModel.currentPrice}",
                      style: AppTextStyles.normal12Black,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    // Text(
                    //   "${productModel.currency}${productModel.actualPrice}",
                    //   style: AppTextStyles.normal12Color81819AStroke,
                    // ),
                  ],
                ),
                // SizedBox(
                //   height: 10,
                // ),
                // Text(
                //   "${productModel.quantityPerUnit}${productModel.unit}",
                //   style: AppTextStyles.normal12Color81819A,
                // ),
              ],
            ),
          )
        ],
      ),
    ),
  );
}
