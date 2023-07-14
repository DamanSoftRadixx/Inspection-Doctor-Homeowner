import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:inspection_doctor_homeowner/core/theme/app_color_palette.dart';
import 'package:inspection_doctor_homeowner/features/add_new_property/home/model/network_model/property_list_response_model.dart';

DateTime? loginClickTime;

bool isRedundentClick(DateTime currentTime) {
  if (loginClickTime == null) {
    loginClickTime = currentTime;
    print("first click");
    return false;
  }
  // print('diff is ${currentTime.difference(loginClickTime!).inSeconds}');
  if (currentTime.difference(loginClickTime!).inMilliseconds < 500) {
    //set this difference time in seconds
    return true;
  }
  loginClickTime = currentTime;
  return false;
}

class NoLeadingSpaceFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.startsWith(' ')) {
      final String trimedText = newValue.text.trimLeft();

      return TextEditingValue(
        text: trimedText,
        selection: TextSelection(
          baseOffset: trimedText.length,
          extentOffset: trimedText.length,
        ),
      );
    }

    return newValue;
  }
}

void showResponseData(var data, {required String type}) {
  String json = jsonEncode(data);
  log("********************** $type response start **********************");
  log("$type $json");
  log("********************** $type  response end **********************");
}

Widget disableScreen({required bool isDisable}) {
  return isDisable
      ? Container(color: lightColorPalette.transparentColor)
      : const SizedBox();
}

String getAddressFormat(PropertyListData property) {
  return "${property.street}, ${property.city}, ${property.state}, ${property.zipCode}";
}
