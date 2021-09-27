import 'package:baqal/src/di/app_injector.dart';
import 'package:baqal/src/models/sub_category_model.dart';
import 'package:baqal/src/notifiers/categories_provider.dart';
import 'package:baqal/src/notifiers/language_notifier.dart';
import 'package:baqal/src/res/app_colors.dart';
import 'package:baqal/src/routes/router_utils.dart';
import 'package:baqal/src/routes/routes_constants.dart';
import 'package:baqal/src/ui/screens/products_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SubCategoryItem extends StatelessWidget {
  final SubCategoryModel subCategory;
  final bool forProductsScreen;

  SubCategoryItem({required this.subCategory, this.forProductsScreen= false});

  final _categoriesProvider = getItInstance<CategoriesProvider>();
  final _languageProvider= getItInstance<LanguageProvider>();
  final _routerUtils = getItInstance<RouterUtils>();
  @override
  // ignore: missing_return
  Widget build(BuildContext context) {
    Widget forMainCategoryItem(BuildContext context) {
      return GestureDetector(
        onTap: () {
          _categoriesProvider.setCurrentSubCategory = subCategory;
          _routerUtils.pushNamedRoot(context, Routes.productsScreen);
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12.0),
              child: Card(
                elevation: 4,
                child: Image.network(
                  subCategory.image!,
                  height: 75,
                  width: 75,
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              _languageProvider.isEnglish ? subCategory.name.english : subCategory.name.arabic,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ],
        ),
      );
    }

    Widget forProductsScreenView(BuildContext context) {
      return GestureDetector(
        onTap: () {
          _categoriesProvider.setCurrentSubCategory = subCategory;
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Card(
              elevation: 4,
              child: Image.network(
                subCategory.image!,
                height: 65,
                width: 65,
                // fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              _languageProvider.isEnglish ? subCategory.name.english : subCategory.name.arabic,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 14,
                  color:
                      subCategory.id == _categoriesProvider.currentSubCategory!.id
                          ? AppColors.yellow
                          : AppColors.black),
            ),
          ],
        ),
      );
    }

    if (forProductsScreen) {
      return forProductsScreenView(context);
    } else {
      return forMainCategoryItem(context);
    }
  }
}
