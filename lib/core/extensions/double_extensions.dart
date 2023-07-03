import 'package:inspection_doctor_homeowner/core/extensions/string_extensions.dart';

extension DoubleExtensions on double? {
  String toDoubleToStringConversionWithDelimiters() {
    var value = this ?? 0.0;

    String valueInString = value.toString();
    var finalValue = "0";
    var valueArr = valueInString.split(".");
    if (valueArr.length > 1 && valueArr[1].toIntConversion() == 0) {
      var valueInInt = value.toInt();
      finalValue = valueInInt.toString();
    } else {
      finalValue = valueInString;
    }

    RegExp reg = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
    mathFunc(Match match) => '${match[1]},';
    return finalValue.replaceAllMapped(reg, mathFunc);
  }

  String toRoundToStringConversionWithDelimiters() {
    var value = this ?? 0.0;

    String valueInString = value.round().toString();
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
    } else {
      finalValue = valueInString;
    }

    RegExp reg = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
    mathFunc(Match match) => '${match[1]},';
    return finalValue.replaceAllMapped(reg, mathFunc);
  }

  String get priceString {
    final numberString = toString();
    final numberDigits = List.from(numberString.split(''));
    int index = numberDigits.length - 3;
    while (index > 0) {
      numberDigits.insert(index, ',');
      index -= 3;
    }
    return numberDigits.join();
  }

  String toDoubleToStringConversion() {
    var value = this ?? 0.0;

    String valueInString = value.toString();
    print("valueInString : $valueInString");

    if (valueInString.contains(".0")) {
      var valueInInt = value.toInt();
      print("valueInInt : $valueInInt");
      return valueInInt.toString();
    } else {
      var stringWithRound = double.parse(valueInString).toStringAsFixed(2);
      return stringWithRound;
    }
  }
}
