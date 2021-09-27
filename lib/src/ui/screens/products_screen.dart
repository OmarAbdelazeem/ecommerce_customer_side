import 'package:baqal/src/bloc/products/products.dart';
import 'package:baqal/src/core/utils/grid_view_height_width.dart';
import 'package:baqal/src/models/banner_model.dart';
import 'package:baqal/src/models/main_category_model.dart';
import 'package:baqal/src/models/product_model.dart';
import 'package:baqal/src/notifiers/categories_provider.dart';
import 'package:baqal/src/notifiers/language_notifier.dart';
import 'package:baqal/src/res/app_colors.dart';
import 'package:baqal/src/res/string_constants.dart';
import 'package:baqal/src/ui/common/cart_icon.dart';
import 'package:baqal/src/ui/common/sub_category_item.dart';
import 'package:flutter/material.dart';
import 'package:baqal/src/bloc/products/products_cubit.dart';
import 'package:baqal/src/di/app_injector.dart';

import 'package:baqal/src/ui/common/product_card.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class ProductsScreen extends StatefulWidget {
  final BannerModel ? banner;

  ProductsScreen({this.banner});

  @override
  _ProductsScreenState createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  final productsCubit = getItInstance<ProductsCubit>();
  final categoriesNotifier = getItInstance<CategoriesProvider>();
  final productsScrollController = ScrollController();
  final ItemScrollController mainCategoriesScrollController =
      ItemScrollController();
final languageProvider = getItInstance<LanguageProvider>();
  int mainCategoryIndex = 0;

  @override
  void initState() {
    productsCubit.fetchProducts(
        widget.banner !=null  ? widget.banner!.id! : categoriesNotifier.currentSubCategory!.id);
    if(widget.banner ==null)
      Future.delayed(Duration(milliseconds: 1))
          .then((value) => mainCategoriesScrollController.jumpTo(
        index: categoriesNotifier.currentCategoryIndex,
      ));


    productsScrollController.addListener(_scrollListener);
    super.initState();
  }

  void _scrollListener() {
    if (productsScrollController.offset >=
            productsScrollController.position.maxScrollExtent &&
        !productsScrollController.position.outOfRange) {
      print("at the end of list");
      productsCubit.fetchNextList(
          widget.banner!.id ?? categoriesNotifier.currentSubCategory!.id);
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(languageProvider.getTranslated(context, StringsConstants.products)!),
        actions: <Widget>[Padding(
          padding: const EdgeInsets.all(8.0),
          child: CartIcon(isClickable: true,),
        )],
      ),
      body: widget.banner == null
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [mainCategories(), subCategories(), products()],
            )
          : products(),
    );
  }

  Widget products() {
    return BlocBuilder<ProductsCubit, ProductsState>(
        bloc: productsCubit,
        builder: (BuildContext context, ProductsState state) {
          Widget productsView(List<ProductModel> products) {
            return GridView.builder(
                shrinkWrap: true,
                controller: productsScrollController,
                itemCount: products.length,
                padding:
                    EdgeInsets.only(left: 16, right: 16, top: 20, bottom: 30),
                itemBuilder: (BuildContext context, int index) {
                  return ProductCard(
                    product: products[index],
                  );
                },
                gridDelegate:
                    SliverGridDelegateWithFixedCrossAxisCountAndFixedHeight(
                  crossAxisCount: 2,
                  crossAxisSpacing: 4,
                  mainAxisSpacing: 5,
                  height: 230,

                ));
          }

          if (state is FetchingFirstList)
            return Center(
              child: CircularProgressIndicator(),
            );
          else if (state is Loaded)
            return productsView(state.products);
          else if (state is ErrorWhenFetchingNextList)
            return productsView(state.products);

          return Container();
        });
  }

  Widget mainCategories() {
    return Container(
      height: 60,
      child: ScrollablePositionedList.builder(
        itemCount: categoriesNotifier.mainCategories.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          mainCategoryIndex = index;
          return mainCategoryWidget(
              categoriesNotifier.mainCategories[index], index);
        },
        itemScrollController: mainCategoriesScrollController,
      ),
    );
  }

  Widget subCategories() {
    return Container(
      height: 130,
      alignment: Alignment.centerLeft,
      child: ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          return Padding(
              padding: EdgeInsets.only(
                left: 8,
                top: 5,
              ),
              child: SubCategoryItem(
                subCategory: categoriesNotifier.subCategories[index],
                forProductsScreen: true,
              ));
        },
        itemCount: categoriesNotifier.subCategories.length,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
      ),
    );
  }

  Widget mainCategoryWidget(MainCategoryModel mainCategory, int index ) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: EdgeInsets.all(10),
        child: Text(
          '${languageProvider.isEnglish ? mainCategory.name.english : mainCategory.name.arabic}',
          style: TextStyle(
              color:
                  mainCategory.id == categoriesNotifier.currentMainCategory!.id
                      ? AppColors.yellow
                      : AppColors.black,
              fontSize: 15,
              fontWeight: FontWeight.bold),
        ),
        decoration: BoxDecoration(
          border: Border.all(
            color: mainCategory.id == categoriesNotifier.currentMainCategory!.id
                ? AppColors.yellow
                : AppColors.white,
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(30),
        ),
      ),
    );
  }
}
