import 'dart:io';

import 'package:equatable/equatable.dart';

import 'name_field.dart';

// ignore: must_be_immutable
class SubCategoryModel extends Equatable {
  late String id;
  NameField name;
  String? image;
  String? imageId;
  late String mainCategoryId;

  SubCategoryModel(
      {this.image,
      required this.name,
      required this.id,
       this.imageId,
      required this.mainCategoryId,
      });

  Map<String, dynamic> toJson() => <String, dynamic>{
        'name': name.toJson(),
        'image': image,
        'image_id': imageId,
        'main_category_id': mainCategoryId,
        'id': id
      };

  factory SubCategoryModel.fromJson(json) {
    return SubCategoryModel(
        name: NameField.fromJson(json['name']),
        imageId: json['image_id'],
        id: json['id'],
        image: json['image'],
        mainCategoryId: json['main_category_id']);
  }

  @override
  // TODO: implement props
  List<Object> get props => [id, name, mainCategoryId, image!,imageId!];
}
