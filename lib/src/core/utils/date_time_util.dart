import 'package:intl/intl.dart';

String formatDateTime(DateTime dateTime) {
  var formattedDate = DateFormat('yyyy-MM-dd – kk:mm').format(dateTime);
  return formattedDate;
}

String formatCurrentDateTime() {
  var now = DateTime.now();
  var formattedDate = DateFormat('yyyy-MM-dd – kk:mm').format(now);
  return formattedDate;
}

String getTimeFromTimeStamp(String timestamp, bool isEnglish) {
  try {
    var dateTime =
        DateTime.fromMillisecondsSinceEpoch(int.parse(timestamp) * 1000);

    var day = dateTime.day;
    var month = getMonthName(
      dateTime.month,
    );
    var year = dateTime.year;

    return "$day $month $year";
  } catch (E) {
    return "";
  }
}

getOrderedTime(String dateTime, {bool isEnglish = true}) {
  DateTime dateT = DateTime.parse(dateTime);
  if (isEnglish)
    return "${getMonthName(dateT.month)} ${dateT.day} , ${dateT.year} at ${_getTime(dateT)}";
  else
    return "${getMonthName(dateT.month, isEnglishLanguage: isEnglish = false)} ${dateT.day} , ${dateT.year} في ${_getTime(dateT, isEnglishLanguage: false)}";
}

String _getTime(DateTime dateTime, {bool isEnglishLanguage = true}) {
  if (isEnglishLanguage)
    return "${dateTime.hour > 12 ? dateTime.hour - 12 : dateTime.hour}:${dateTime.minute} ${dateTime.hour > 12 ? "PM" : "AM"}";
  else
    return "${dateTime.hour > 12 ? dateTime.hour - 12 : dateTime.hour}:${dateTime.minute} ${dateTime.hour > 12 ? "مساء" : "صباحا"}";
}

String getMonthName(int month, {bool isEnglishLanguage = true}) {
  const List englishMonths = [
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "November",
    "December"
  ];
  const List arabicMonths = [
    "يناير",
    "فبراير",
    "مارس",
    "ابريل",
    "مايو",
    "يونيو",
    "يوليو",
    "اغسطس",
    "سبتمبر",
    "نوفمبر",
    "ديسمبر"
  ];

  final List temp = isEnglishLanguage ? englishMonths : arabicMonths;

  switch (month) {
    case 1:
      return temp[0];

    case 2:
      return temp[1];

    case 3:
      return temp[2];

    case 4:
      return temp[3];

    case 5:
      return temp[4];

    case 6:
      return temp[5];

    case 7:
      return temp[6];

    case 8:
      return temp[7];

    case 9:
      return temp[8];

    case 10:
      return temp[9];

    case 11:
      return temp[10];

    case 12:
      return temp[11];

    default:
      return temp[0];
  }
}

String getTimeDifference() {
  var birthday = DateTime(1967, 10, 12);
  var date2 = DateTime.now();
  var difference = date2.difference(birthday).inHours;
  return difference.toString();
}
