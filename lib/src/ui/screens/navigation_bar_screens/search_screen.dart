import 'package:baqal/src/bloc/base_states/result_state/result_state.dart';
import 'package:baqal/src/bloc/internet_connection/internet_connection.dart';
import 'package:baqal/src/bloc/product_search/product_search.dart'
    as product_search;
import 'package:baqal/src/bloc/products/products.dart';
import 'package:baqal/src/notifiers/language_notifier.dart';
import 'package:baqal/src/ui/common/product_card.dart';
import 'package:baqal/src/ui/common/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:baqal/src/di/app_injector.dart';
import 'package:baqal/src/res/string_constants.dart';
import 'package:baqal/src/ui/common/commom_search_text_field.dart';
import '../base_screen_mixin.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  ProductsCubit productsCubit = getItInstance<ProductsCubit>();

  InternetConnectionCubit internetConnectionCubit =
      getItInstance<InternetConnectionCubit>();

  product_search.ProductSearchCubit productSearchCubit =
      getItInstance<product_search.ProductSearchCubit>();
  final languageProvider = getItInstance<LanguageProvider>();

  ScrollController controller = ScrollController();

  bool isSearching = false;

  bool isConnected = true;

  @override
  void initState() {
    productsCubit.fetchTopProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<InternetConnectionCubit, InternetConnectionState>(
      bloc: internetConnectionCubit,
      listener: (context, state) {
        state.when(
            idle: () {},
            connectedSuccessfully: () {
              isConnected = true;
              productsCubit.fetchTopProducts();
            },
            noInternetConnection: () {
              isConnected = false;
            });
      },
      builder: (context, state) {
        print('connection from search screen is $isConnected');
        return Scaffold(
            appBar: CommonSearchBar(
              hintText: languageProvider.getTranslated(context, StringsConstants.searchForProduct),
              onTextChanged: (String value) {
                setState(() {
                  if (value.length >= 1)
                    isSearching = true;
                  else
                    isSearching = false;
                });
                productSearchCubit.searchForProduct(value);
              },
            ),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                isSearching
                    ? Container()
                    : isConnected
                        ? topProducts()
                        : Container(),
                searchResults()
              ],
            ));
      },
    );
  }

  Widget searchResults() {
    return BlocBuilder(
      bloc: productSearchCubit,
      builder: (BuildContext context, product_search.ProductSearchState state) {
        if (state is product_search.Loading)
          return Center(
            child: CircularProgressIndicator(),
          );
        else if (state is product_search.Loaded) {
          return Container(
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 12.0, left: 12, right: 12, bottom: 12),
              child: GridView.builder(
                shrinkWrap: true,
                controller: controller,
                itemCount: state.products.length,
                padding:
                    EdgeInsets.only(left: 16, right: 16, top: 20, bottom: 30),
                itemBuilder: (BuildContext context, int index) {
                  return ProductCard(
                    product: state.products[index],
                  );
                },
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  childAspectRatio: 0.62,
                  crossAxisSpacing: 10,
                ),
              ),
            ),
          );
        } else if (state is product_search.Error)
          Future.delayed(Duration(milliseconds: 1)).then(
              (value) => showSnackBar(title: state.error, context: context));

        return Container();
      },
    );
  }

  Widget topProducts() {
    return BlocBuilder(
      bloc: productsCubit,
      builder: (BuildContext context, ProductsState state) {
        if (state is Loading)
          return CircularProgressIndicator();
        else if (state is Loaded)
          return Padding(
            padding: EdgeInsets.only(left: 16, right: 16, top: 20, bottom: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  languageProvider.getTranslated(context, StringsConstants.topProducts)!,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 1,
                  height: MediaQuery.of(context).size.height * 0.39,
                  child: ListView.builder(
                    controller: controller,
                    itemCount: state.products.length,
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Align(
                          child: ProductCard(
                            product: state.products[index],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        return Container();
      },
    );
  }
}
