import 'package:intl/intl.dart';


getLocalDateFromUtc({required String dateTimeString}){
  if (dateTimeString != "" && dateTimeString != "null") {
    var giveDateTime = DateTime.parse(dateTimeString);
    var localDateTime = giveDateTime.toLocal();
    var localDate = DateFormat("dd MMM At hh:mm a").format(localDateTime);
    localDate = localDate.replaceAll("At", "at");
    return localDate;
  }
  return "";
}
