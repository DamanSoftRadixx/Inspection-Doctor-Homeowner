import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

getLocalDateFromUtc({required String dateString}) {
  if (dateString != "" && dateString != "null") {
    var giveDateTime = DateTime.parse(dateString);
    var localDateTime = giveDateTime.toLocal();
    // var localDate = DateFormat("dd MMM At hh:mm a").format(localDateTime);
    var localDate = DateFormat("MM/dd/yyyy").format(localDateTime);
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

String getDDMMYYYFormet({
  required DateTime date,
  String? newPattern,
}) {
  String formattedDate = DateFormat(newPattern ?? 'dd/MM/yyyy').format(date);
  return formattedDate;
}

String getMMDDYYYYFormetFromString({
  required String date,
  String? newPattern,
}) {
  var formattedDate = DateFormat("dd/MM/yyyy").parse(date);

  String formattedDateString =
      DateFormat(newPattern ?? 'MM/dd/yyyy').format(formattedDate);
  return formattedDateString;
}

// String getDateFormattedFromString({
//   required String dateString,
//   String? inputFormat,
// }) {
//   String result = "";
//   if (dateString != "") {
//     if (dateString.contains("/")) {
//       String year = dateString.split("/").last;
//       String month = dateString.split("/")[1];
//       String day = dateString.split("/").first;

//       DateTime tempDate = DateFormat("yyyy-MM-dd").parse("$year-$month-$day");

//       result = DateFormat(inputFormat ?? 'MM/dd/yyyy').format(tempDate);
//     } else {
//       var temp = DateFormat("yyyy-MM-dd").parse(dateString);

//       result = DateFormat('MM/dd/yyyy').format(temp);
//     }
//   }

//   return result;
// }

DateTime? parseDated({required String text}) {
  final MaterialLocalizations localizations =
      MaterialLocalizations.of(Get.context!);
  return localizations.parseCompactDate(text);
}
