import 'package:baqal/src/bloc/sub_categories/sub_categories.dart';
import 'package:baqal/src/di/app_injector.dart';
import 'package:baqal/src/models/main_category_model.dart';
import 'package:baqal/src/notifiers/language_notifier.dart';
import 'package:baqal/src/res/padding_styles.dart';
import 'package:baqal/src/res/text_styles.dart';
import 'package:baqal/src/ui/common/loading_sub_categories.dart';
import 'package:baqal/src/ui/common/sub_category_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainCategoryItem extends StatefulWidget {
  final MainCategoryModel mainCategory;

  MainCategoryItem({required this.mainCategory});

  @override
  State<MainCategoryItem> createState() => _MainCategoryItemState();
}

class _MainCategoryItemState extends State<MainCategoryItem> {
  final subCategoriesCubit = getItInstance<SubCategoriesCubit>();
  final languageProvider= getItInstance<LanguageProvider>();

  void fetchSubCategories() {
    subCategoriesCubit.fetchSubCategories(widget.mainCategory.id);
  }

  @override
  void initState() {
    fetchSubCategories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(PaddingStyles.mainCategoryItemPadding),
          child: Text(
            languageProvider.isEnglish ? widget.mainCategory.name.english : widget.mainCategory.name.arabic,
            style: AppTextStyles.boldText,
          ),
        ),
        SizedBox(
          height: 5,
        ),
        subCategoriesBuilder()
      ],
    );
  }

  Widget subCategoriesBuilder() {
    return BlocBuilder<SubCategoriesCubit, SubCategoriesState>(
        bloc: subCategoriesCubit,
        builder: (context, state) {

           if (state is Loaded) {
            return GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisSpacing: 1,
                    mainAxisSpacing: 1,
                    crossAxisCount: 4,
                    childAspectRatio: 0.72),
                itemCount: widget.mainCategory.subCategoriesIds.length,
                itemBuilder: (BuildContext context, int index) {
                  return SubCategoryItem(
                    subCategory: state.subCategories[index],
                  );
                });
          }
          return Container();
        });
  }


}
