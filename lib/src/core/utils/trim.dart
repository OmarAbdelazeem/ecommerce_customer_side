class TrimUtils{
  static trimDisplayedPhoneNumber(String phoneNumber){
   return phoneNumber.replaceFirst('+20', '');
  }
  static trimEnteredNumber(String phoneNumber){
    if(phoneNumber[0]=='0')
    return phoneNumber.replaceFirst('0', '');
    else
      return phoneNumber;
  }

  static String trimSearchName(String searchName) =>
      searchName.trim().replaceFirst(RegExp(r'[^\p{L}\s]+', unicode: true), '');

  static String trimName(String searchName){
    String trimmedName = searchName.trim().replaceFirst(RegExp(r'[^\p{L}\s]+', unicode: true), '');
    if(trimmedName.isNotEmpty)
      trimmedName = trimmedName.replaceFirst(trimmedName[0], trimmedName[0].toUpperCase());
    return  trimmedName;
  }

}