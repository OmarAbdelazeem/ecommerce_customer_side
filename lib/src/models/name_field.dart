class NameField {
  String arabic;
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