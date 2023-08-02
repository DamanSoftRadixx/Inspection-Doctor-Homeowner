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
    var localDate = DateFormat("hh:mm aaa").format(localDateTime);
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

String getDateFormatedFromString({
  required String date,
  String? newPattern,
}) {
  DateTime result = parseDated(text: date) ?? DateTime.now();
  String formattedDate =
      DateFormat(newPattern ?? 'dd MMMM yyyy').format(result);
  return formattedDate;
}

DateTime? parseDated({required String text}) {
  final MaterialLocalizations localizations =
      MaterialLocalizations.of(Get.context!);
  return localizations.parseCompactDate(text);
}
