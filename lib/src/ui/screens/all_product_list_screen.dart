import 'package:baqal/src/bloc/base_states/result_state/result_api_builder.dart';
import 'package:baqal/src/bloc/base_states/result_state/result_state.dart';
import 'package:baqal/src/bloc/main_categories/main_categories_cubit.dart';
import 'package:baqal/src/bloc/selected_main_category/selected_main_category_cubit.dart';
import 'package:baqal/src/models/main_category_model.dart';
import 'package:baqal/src/notifiers/provider_notifier.dart';
import 'package:baqal/src/notifiers/selected_category_provider.dart';
import 'package:baqal/src/ui/common/common_app_loader.dart';
import 'package:baqal/src/ui/common/main_category.dart';
import 'package:baqal/src/ui/common/sub_category_item.dart';
import 'package:flutter/material.dart';
import 'package:baqal/src/bloc/all_products/all_product_cubit.dart';
import 'package:baqal/src/di/app_injector.dart';
import 'package:baqal/src/models/product_model.dart';
import 'package:baqal/src/ui/common/product_card.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

// class AllProductListScreen extends StatefulWidget {
//   final String categoryName;
//
//   AllProductListScreen(this.categoryName);
//
//   @override
//   _AllProductListScreenState createState() => _AllProductListScreenState();
// }
//
// class _AllProductListScreenState extends State<AllProductListScreen> {
//   var allProductsCubit = AppInjector.get<AllProductCubit>();
//   ScrollController controller = ScrollController();
//
//   @override
//   void initState() {
//     // allProductsCubit.fetchProducts(widget.productCondition);
//     allProductsCubit.fetchProducts(widget.categoryName);
//     if (widget.categoryName == null) {
//       controller.addListener(_scrollListener);
//     }
//     super.initState();
//   }
//
//   void _scrollListener() {
//     if (controller.offset >= controller.position.maxScrollExtent &&
//         !controller.position.outOfRange) {
//       print("at the end of list");
//       allProductsCubit.fetchNextList(widget.categoryName);
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.categoryName),
//         actions: <Widget>[
//           InkWell(
//             onTap: () {
//               // Navigator.of(context).pushNamed(Routes.searchItemScreen);
//             },
//             child: Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Icon(Icons.search),
//             ),
//           )
//         ],
//       ),
//       body: BlocConsumer<AllProductCubit, ResultState<List<ProductModel>>>(
//         cubit: allProductsCubit,
//         listener:
//             (BuildContext context, ResultState<List<ProductModel>> state) {},
//         builder: (BuildContext context, ResultState<List<ProductModel>> state) {
//           return ResultStateBuilder(
//             state: state,
//             loadingWidget: (bool isReloading) {
//               return Center(
//                 child: CommonAppLoader(),
//               );
//             },
//             errorWidget: (String error) {
//               return Container();
//             },
//             dataWidget: (List<ProductModel> value) {
//               return dataWidget(value);
//             },
//           );
//         },
//       ),
//     );
//   }
//
//   Widget dataWidget(List<ProductModel> productList) {
//     return ListView.builder(
//
//       controller: controller,
//       itemCount: productList.length,
//       padding: EdgeInsets.only(left: 16, right: 16, top: 20, bottom: 30),
//       shrinkWrap: true,
//       itemBuilder: (BuildContext context, int index) {
//         return ProductCard(productModel: productList[index],fromCategories: true,);
//       },
//       // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//       //   crossAxisCount: 2,
//       //   mainAxisSpacing: 10,
//       //   childAspectRatio: 0.7,
//       //   crossAxisSpacing: 10,
//       // ),
//     );
//   }
//
//   // Widget dataWidget(List<ProductModel> productList) {
//   //   return GridView.builder(
//   //     controller: controller,
//   //     itemCount: productList.length,
//   //     padding: EdgeInsets.only(left: 16, right: 16, top: 20, bottom: 30),
//   //     itemBuilder: (BuildContext context, int index) {
//   //       return ProductCard(productList[index]);
//   //     },
//   //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//   //       crossAxisCount: 2,
//   //       mainAxisSpacing: 10,
//   //       childAspectRatio: 0.7,
//   //       crossAxisSpacing: 10,
//   //     ),
//   //   );
//   // }
// }

class AllProductListScreen extends StatefulWidget {
  final String condition;

  AllProductListScreen(this.condition);

  @override
  _AllProductListScreenState createState() => _AllProductListScreenState();
}

class _AllProductListScreenState extends State<AllProductListScreen> {
  var allProductsCubit = getItInstance<AllProductCubit>();
  final categoriesCubit = getItInstance<MainCategoriesCubit>();
  final _selectedCategoryProvider = getItInstance<SelectedCategoryProvider>();
  ScrollController controller = ScrollController();
 late List<MainCategoryModel> mainCategories;
  int mainCategoryIndex = 0;

  @override
  void initState() {
    mainCategories = categoriesCubit.mainCategories;
    allProductsCubit.fetchProducts(widget.condition);
    // if (widget.categoryName == null) {
    //   controller.addListener(_scrollListener);
    // }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Products'),
          actions: <Widget>[
            InkWell(
              onTap: () {
                // Navigator.of(context).pushNamed(Routes.searchItemScreen);
              },
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Icon(Icons.search),
              ),
            )
          ],
        ),
        body: SingleChildScrollView(
            child: Column(
          children: [mainCategoriesList(), subCategoriesList(), products()],
        )));
  }

  Widget products() {
    return BlocConsumer<AllProductCubit, ResultState<List<ProductModel>>>(
        bloc : allProductsCubit,
        listener:
            (BuildContext context, ResultState<List<ProductModel>> state) {},
        builder: (BuildContext context, ResultState<List<ProductModel>> state) {
          return ResultStateBuilder(
            state: state,
            loadingWidget: (bool isReloading) {
              return Center(
                child: CommonAppLoader(),
              );
            },
            errorWidget: (String error) {
              return Container();
            },
            dataWidget: (List<ProductModel> value) {
              return dataWidget(value);
            },
          );
        });
  }

  Widget dataWidget(List<ProductModel> productList) {
    return GridView.builder(
      shrinkWrap: true,
      controller: controller,
      itemCount: productList.length,
      padding: EdgeInsets.only(left: 16, right: 16, top: 20, bottom: 30),
      itemBuilder: (BuildContext context, int index) {
        return ProductCard(
          productModel: productList[index],
        );
      },
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 10,
        childAspectRatio: 0.7,
        crossAxisSpacing: 10,
      ),
    );
  }

  Widget mainCategoriesList() {
    return Container(
      height: 60,
      child: ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          mainCategoryIndex = index;
          return mainCategoryWidget(mainCategories[index], index);
        },
        itemCount: mainCategories.length,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
      ),
    );
  }

  Widget subCategoriesList() {
    return ProviderNotifier<SelectedCategoryProvider>(
      child: (SelectedCategoryProvider selectedCategoryProvider) {
        List subCategories = [];
        MainCategoryModel displayedMainCategories;
        var searchResult = mainCategories.where((MainCategoryModel element) {
          if (element.id == selectedCategoryProvider.selectedMainCategoryId) {
            displayedMainCategories = element;
            subCategories = displayedMainCategories.subCategoriesIds;
            return true;
          }
          return false;
        });
        print('searchResult is $searchResult');

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
                  child: SectionItem(
                    subCategories[index],
                    forAllProductPage: true,
                    forMainCategory: false,
                  ));
            },
            itemCount: subCategories.length,
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
          ),
        );
      },
    );
  }

  Widget mainCategoryWidget(MainCategoryModel mainCategory, int index) {
    return ProviderNotifier(
      child: (SelectedCategoryProvider selectedCategoryProvider) {
        return GestureDetector(
          onTap: () {
            selectedCategoryProvider.selectMainCategoryIndex(index);
            selectedCategoryProvider.selectMainCategory(mainCategory.id);
            selectedCategoryProvider
                .selectSubCategory(mainCategory.subCategoriesIds[0].id);
            allProductsCubit.fetchProducts(mainCategory.subCategoriesIds[0].name);
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              padding: EdgeInsets.all(10),
              child: Text(
                '${mainCategory.name}',
                style: TextStyle(
                    color: mainCategory.id ==
                            selectedCategoryProvider.selectedMainCategoryId
                        ? Colors.green
                        : Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              ),
              decoration: BoxDecoration(
                border: Border.all(
                  color: mainCategory.id ==
                          selectedCategoryProvider.selectedMainCategoryId
                      ? Colors.green
                      : Colors.white,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
        );
      },
    );
  }
}
