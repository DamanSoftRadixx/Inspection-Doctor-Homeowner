import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/app_text_widget.dart';
import 'package:inspection_doctor_homeowner/core/constants/app_strings.dart';
import 'package:inspection_doctor_homeowner/core/constants/common_strings.dart';

import '../theme/app_color_palette.dart';

AppBar commonAppBar() {
  return AppBar(
    elevation: 0,
    centerTitle: true,
    backgroundColor: lightColorPalette.whiteColorPrimary.shade900,
    title: AppTextWidget(
        text: AppStrings.selectLanguage.tr,
        style: Theme.of(Get.context!).textTheme.bodyLarge!.copyWith(
            fontSize: 16.sp,
            color: lightColorPalette.primaryDarkblue,
            fontWeight: FontWeight.w600,
            fontFamily: CommonStrings.generalSans)),
  );
}
