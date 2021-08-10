import 'package:baqal/src/models/main_category_model.dart';
import 'package:baqal/src/ui/common/sub_category_item.dart';
import 'package:flutter/material.dart';

class MainCategoryItem extends StatelessWidget {
  final MainCategoryModel mainCategory;

  MainCategoryItem({required this.mainCategory});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8.0),
          child: Text(
            mainCategory.name.english,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),
        SizedBox(
          height: 5,
        ),
        GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisSpacing: 1,
                mainAxisSpacing: 1,
                crossAxisCount: 4,
                childAspectRatio: 0.72),
            itemCount: mainCategory.subCategoriesIds.length,
            itemBuilder: (BuildContext context, int index) {
              return SectionItem(
                mainCategory.subCategoriesIds[index],
                forMainCategory: true,
                forAllProductPage: false,
              );
            })
      ],
    );
  }
}


