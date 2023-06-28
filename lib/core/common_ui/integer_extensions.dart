import 'package:inspection_doctor_homeowner/core/common_ui/string_extensions.dart';

extension IntExtensions on int? {
  String toIntToStringConversionWithDelimiters() {
    var value = this ?? 0.0;

    String valueInString = value.toString();
    print("valueInString : $valueInString");

    var finalValue = "0";
    var valueArr = valueInString.split(".");
    print("valueArr : $valueArr");
    if (valueArr.length > 1 && valueArr[1].toIntConversion() == 0) {
      var valueInInt = value.toInt();
      print("valueInInt : $valueInInt");
      print(
          "valueInString[1].toIntConversion() : ${valueInString[1].toIntConversion()}");

      finalValue = valueInInt.toString();
    }

    RegExp reg = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
    mathFunc(Match match) => '${match[1]},';
    return finalValue.replaceAllMapped(reg, mathFunc);
  }
}
