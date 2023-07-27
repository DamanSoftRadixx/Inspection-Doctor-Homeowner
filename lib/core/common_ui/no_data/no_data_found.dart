import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/text/app_text_widget.dart';
import 'package:inspection_doctor_homeowner/core/constants/app_strings.dart';
import 'package:inspection_doctor_homeowner/core/theme/app_color_palette.dart';

Column showNoDataFound() {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      AppTextWidget(
        textAlign: TextAlign.start,
        text: AppStrings.noData.tr,
        style: CustomTextTheme.heading1WithLetterSpacing(
          color: lightColorPalette.black,
        ),
      ),
      AppTextWidget(
        textAlign: TextAlign.start,
        text: AppStrings.listEmpty.tr,
        style: CustomTextTheme.normalText(
          color: lightColorPalette.grey,
        ),
      ),
    ],
  );
}
