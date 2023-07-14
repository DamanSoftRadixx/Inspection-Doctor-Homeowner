import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/text/app_text_widget.dart';
import 'package:inspection_doctor_homeowner/core/theme/app_color_palette.dart';

snackbar(String message) {
  return Get.snackbar(
    "",
    message,
    titleText: Container(),
    messageText: AppTextWidget(
      style: CustomTextTheme.normalText(
          color: lightColorPalette.whiteColorPrimary.shade900),
      text: message,
    ),
    backgroundColor: lightColorPalette.primaryDarkblue,
    borderRadius: 10,
    margin: const EdgeInsets.all(10),
    duration: const Duration(seconds: 3),
    isDismissible: true,
    dismissDirection: DismissDirection.endToStart,
    forwardAnimationCurve: Curves.linearToEaseOut,
  );
}
