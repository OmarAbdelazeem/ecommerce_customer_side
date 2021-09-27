import 'package:hive/hive.dart';

part 'name_field.g.dart';


@HiveType(typeId: 2)
class NameField {
  @HiveField(0)
  String arabic;
  @HiveField(1)
  String english;

  NameField({ required this.arabic, required this.english});

  // NameField copyWith(String arabic, String english) {
  //   return NameField(
  //       arabic: arabic ?? this.arabic, english: english ?? this.english);
  // }

  factory NameField.fromJson(json) {
    return NameField(arabic: json['ar'], english: json['en']);
  }

  Map<String? , String ?> ?  toJson() {
    return {'ar': arabic, 'en': english};
  }
}