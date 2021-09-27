import 'package:baqal/src/bloc/banners/banners.dart' as banners;
import 'package:baqal/src/bloc/internet_connection/internet_connection.dart';
import 'package:baqal/src/bloc/main_categories/main_categories.dart'
    as main_categories;
import 'package:baqal/src/notifiers/language_notifier.dart';
import 'package:baqal/src/res/string_constants.dart';
import 'package:baqal/src/ui/common/banner_item.dart';
import 'package:baqal/src/ui/common/loading_main_categories.dart';
import 'package:baqal/src/ui/common/main_category_item.dart';
import 'package:baqal/src/ui/common/no_internet_connection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:baqal/src/di/app_injector.dart';
import 'package:shimmer/shimmer.dart';

class CategoriesScreen extends StatefulWidget {
  @override
  _CategoriesScreenState createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen>
    with AutomaticKeepAliveClientMixin {
  final categoriesCubit = getItInstance<main_categories.MainCategoriesCubit>();
  final bannersCubit = getItInstance<banners.BannersCubit>();
  final internetConnectionCubit = getItInstance<InternetConnectionCubit>();
  final languageProvider = getItInstance<LanguageProvider>();
  bool isConnected = true;

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  fetchData() async {
    categoriesCubit.fetchMainCategories();
    bannersCubit.fetchBanners();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(languageProvider.getTranslated(context, StringsConstants.home)!),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.notifications))
        ],
      ),
      body: BlocConsumer<InternetConnectionCubit, InternetConnectionState>(
        bloc: internetConnectionCubit,
        listener: (context, state) {
          state.when(
              idle: () {},
              noInternetConnection: () {
                print('from categories noInternetConnection');
                isConnected = false;
              },
              connectedSuccessfully: () {
                isConnected = true;
                print('from categories connectedSuccessfully');
                fetchData();
              });
        },
        builder: (context, state) {
          return isConnected
              ? RefreshIndicator(
                  onRefresh: () => fetchData(),
                  child: ListView(
                    children: [
                      Column(
                        children: [
                          bannersDataBuilder(),
                          SizedBox(
                            height: 20,
                          ),
                          mainCategoriesDataBuilder(),
                        ],
                      )
                    ],
                  ))
              : Center(child: noInternetConnection());
        },
      ),
    );
  }

  Widget mainCategoriesDataBuilder() {
    return BlocBuilder<main_categories.MainCategoriesCubit,
            main_categories.MainCategoriesState>(
        bloc: categoriesCubit,
        builder:
            (BuildContext context, main_categories.MainCategoriesState state) {
          if (state is main_categories.Loading) {
            return loadingMainCategories();
          } else if (state is main_categories.Loaded) {
            return ListView.builder(
              shrinkWrap: true,
              itemCount: state.mainCategories.length,
              itemBuilder: (BuildContext context, int index) {
                return MainCategoryItem(
                  mainCategory: state.mainCategories[index],
                );
              },
            );
          } else if (state is main_categories.Error) {
            return Text(state.error);
          }
          return Container();
        });
  }

  Widget bannersDataBuilder() {
    return BlocBuilder(
      bloc: bannersCubit,
      builder: (context, state) {
        if (state is banners.Loaded) {
          return Container(
            height: 220,
            child: PageView.builder(
                itemCount: state.banners.length,
                itemBuilder: (BuildContext context, int i) {
                  return (BannerItem(banner: state.banners[i]));
                }),
          );
        } else if (state is banners.Loading)
          return Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              // enabled: _enabled,
              child: Container(
                height: 220,
                color: Colors.white,
              ));
        return Container();
      },
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
