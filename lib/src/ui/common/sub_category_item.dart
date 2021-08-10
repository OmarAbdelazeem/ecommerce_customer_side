import 'package:baqal/src/bloc/all_products/all_product_cubit.dart';
import 'package:baqal/src/di/app_injector.dart';
import 'package:baqal/src/models/sub_category_model.dart';

import 'package:baqal/src/notifiers/provider_notifier.dart';
import 'package:baqal/src/notifiers/selected_category_provider.dart';
import 'package:baqal/src/ui/screens/all_product_list_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SectionItem extends StatelessWidget {
  final SubCategoryModel subCategory;
  final bool forMainCategory;
  final bool forAllProductPage;

  SectionItem(this.subCategory,
      {required this.forMainCategory, required this.forAllProductPage});

  @override
  // ignore: missing_return
  Widget build(BuildContext context) {
    if (forMainCategory) {
      return forMainCategoryItem(context);
    } else if (forAllProductPage) {
      return forAllProductPageItem(context);
    }
    return Container();
  }

  Widget forMainCategoryItem(BuildContext context) {
    final selectedCategoryProvider =
    getItInstance<SelectedCategoryProvider>();
    return GestureDetector(
      onTap: () {
        selectedCategoryProvider.selectMainCategory(subCategory.mainCategoryId);
        selectedCategoryProvider.selectSubCategory(subCategory.id);
        Navigator.push(
            context, MaterialPageRoute(builder: (_) => AllProductListScreen(subCategory.name.english)));
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Card(
            elevation: 4,
            child: Image.network(
              subCategory.image!,
              height: 75,
              width: 75,
              // fit: BoxFit.cover,
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            subCategory.name.english,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget forAllProductPageItem(BuildContext context) {
    return ProviderNotifier(
      child: (SelectedCategoryProvider selectedCategoryProvider) {
        return GestureDetector(
          onTap: () {

            selectedCategoryProvider.selectSubCategory(subCategory.id);
            final allProductsCubit = getItInstance<AllProductCubit>();
            allProductsCubit.fetchProducts(subCategory.name.english);
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
                subCategory.name.english,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 14,
                    color: subCategory.id ==
                            selectedCategoryProvider.selectedSubCategoryId
                        ? Colors.green
                        : Colors.black),
              ),
            ],
          ),
        );
      },
    );
  }
}
