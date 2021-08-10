import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'name_field.dart';

class MainCategoryModel extends Equatable{
  String id;
  NameField name;
  List subCategoriesIds;

  MainCategoryModel({required this.subCategoriesIds, required this.id, required this.name});

  factory MainCategoryModel.fromJson(DocumentSnapshot documentSnapshot) {
    return MainCategoryModel(
        id:  documentSnapshot['id'],
        name: NameField.fromJson(documentSnapshot['name']),
        subCategoriesIds: documentSnapshot['sub_categories_ids']
    );
  }


  @override
  // TODO: implement props
  List<Object> get props => [id ,name,subCategoriesIds];
}

