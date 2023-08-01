import 'package:get/get_utils/src/extensions/string_extensions.dart';
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

String getDateFormated({required DateTime date}) {
  String formattedDate = DateFormat('dd/MM/yyyy').format(date);
  return formattedDate;
}
