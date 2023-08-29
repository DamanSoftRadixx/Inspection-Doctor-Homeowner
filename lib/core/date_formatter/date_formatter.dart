import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

getLocalDateFromUtc({required String dateTimeString}) {
  if (dateTimeString != "" && dateTimeString != "null") {
    var giveDateTime = DateTime.parse(dateTimeString);
    var localDateTime = giveDateTime.toLocal();
    var localDate = DateFormat("dd MMM At hh:mm a").format(localDateTime);
    localDate = localDate.replaceAll("At", "at");
    return localDate;
  }
  return "";
}

getLocalTimeFromUtc({required String dateTimeString}) {
  if (dateTimeString != "" && dateTimeString != "null") {
    var giveDateTime = DateTime.parse(dateTimeString);
    var localDateTime = giveDateTime.toLocal();
    var localDate = DateFormat("hh a").format(localDateTime);
    // localDate = localDate.replaceAll("At", "at");
    return localDate;
  }
  return "";
}

get24HoursLocalTimeFromUtc({required String dateTimeString}) {
  if (dateTimeString != "" && dateTimeString != "null") {
    var giveDateTime = DateTime.parse(dateTimeString);
    var localDateTime = giveDateTime.toLocal();
    var localDate = DateFormat("HH:mm").format(localDateTime);
    // localDate = localDate.replaceAll("At", "at");
    return localDate;
  }
  return "";
}

String getUtcDateString(
    {String givenFormat = "dd/MM/yyyy",
    required String date,
    String time = ""}) {
  if (date != "") {
    DateFormat formatterDate = DateFormat(givenFormat);
    DateFormat formatterTime = DateFormat("HH:mm");
    var formattedDate = formatterDate.parse(date.removeAllWhitespace);
    DateTime formattedTime;

    if (time != "") {
      formattedTime = formatterTime.parse(time.removeAllWhitespace);
    } else {
      formattedTime = DateTime.now();
    }

    DateTime resultedDate = DateTime(formattedDate.year, formattedDate.month,
        formattedDate.day, formattedTime.hour, formattedTime.minute, 0);
    DateTime utcDateTime = resultedDate.toUtc();

    return "$utcDateTime";
  }

  return "";
}

String getDateFormatedFromDateTime({
  required DateTime date,
  String? newPattern,
}) {
  String formattedDate = DateFormat(newPattern ?? 'dd/MM/yyyy').format(date);
  return formattedDate;
}

// String getDateFormattedFromString({
//   required String dateString,
//   String? newPattern,
// }) {
//   String result = "";
//   if (date != "") {
//     if (date.contains("/")) {
//       String year = date.split("/").last;
//       String month = date.split("/")[1];
//       String day = date.split("/").first;

//       DateTime tempDate = DateFormat("yyyy-MM-dd").parse("$year-$month-$day");

//       result = DateFormat(newPattern ?? 'dd MMMM yyyy').format(tempDate);
//     } else {
//       DateTime temp = parseDated(text: date) ?? DateTime.now();
//       result = DateFormat(newPattern ?? 'dd MMMM yyyy').format(temp);
//     }
//   }

//   return result;
// }

String getDateFormattedFromString({
  required String dateString,
  String? inputFormat,
}) {
  String result = "";
  if (dateString != "") {
    if (dateString.contains("/")) {
      String year = dateString.split("/").last;
      String month = dateString.split("/")[1];
      String day = dateString.split("/").first;

      DateTime tempDate = DateFormat("yyyy-MM-dd").parse("$year-$month-$day");

      result = DateFormat(inputFormat ?? 'dd MMMM yyyy').format(tempDate);
    } else {
      var temp = DateFormat("yyyy-MM-dd").parse(dateString);

      result = DateFormat('dd MMMM yyyy').format(temp);
    }
  }

  return result;
}

DateTime? parseDated({required String text}) {
  final MaterialLocalizations localizations =
      MaterialLocalizations.of(Get.context!);
  return localizations.parseCompactDate(text);
}
