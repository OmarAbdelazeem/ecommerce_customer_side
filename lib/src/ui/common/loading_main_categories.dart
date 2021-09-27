import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'loading_sub_categories.dart';

Widget loadingMainCategories(){
  return Shimmer.fromColors(
    baseColor: Colors.grey[300]!,
    highlightColor: Colors.grey[100]!,
    child: ListView.builder(
      shrinkWrap: true,
      itemBuilder: (_, __) => Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Container(
                width: 100,
                height: 15.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(height: 8,),
            loadingSubCategories()
          ],
        ),
      ),
      itemCount: 6,
    ),
  );
}