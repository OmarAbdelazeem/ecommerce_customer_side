import 'package:baqal/src/bloc/auth/auth.dart';
import 'package:baqal/src/bloc/main_categories/main_categories.dart';

import 'package:baqal/src/ui/common/base_app_bar.dart';

import 'package:baqal/src/ui/common/main_category.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:baqal/src/di/app_injector.dart';

class HomePageScreen extends StatefulWidget {
  @override
  _HomePageScreenState createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  final categoriesCubit = getItInstance<MainCategoriesCubit>();
  // List mainCategories = [];

  @override
  void initState() {
    fetchCategoriesData();
    super.initState();
  }


  fetchCategoriesData() async {
    categoriesCubit.fetchMainCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(),
      body: RefreshIndicator(
        onRefresh: () => fetchCategoriesData(),
        child: categoryDataBuilder(),
      ),
    );
  }

  Widget categoryDataBuilder() {
    return BlocBuilder<MainCategoriesCubit, MainCategoriesState>(
        bloc: categoriesCubit,
        builder: (BuildContext context,
            // ignore: missing_return
            MainCategoriesState state) {
          if (state is CategoriesLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is CategoriesLoaded) {
            return ListView.builder(
              shrinkWrap: true,
              itemCount: state.mainCategories.length,
              itemBuilder: (BuildContext context, int index) {
                return MainCategoryItem(
                  mainCategory: state.mainCategories[index],
                );
              },
            );
          }
          // ignore: missing_return
          else if (state is Error) {
            return Text(state.error);
          }
          return Container();
        }
        );
  }

}
