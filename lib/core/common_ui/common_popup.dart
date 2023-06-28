import 'package:flutter/cupertino.dart' as cupertino_dialog;
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:inspection_doctor_homeowner/core/constants/app_strings.dart';
import 'package:inspection_doctor_homeowner/core/constants/common_strings.dart';
import 'package:inspection_doctor_homeowner/core/theme/app_color_palette.dart';

void waitingForContentAlertBox(
    {required String? title, required Function() onPressed}) {
  if (Get.isDialogOpen == null || Get.isDialogOpen == false) {
    Get.dialog(
      cupertino_dialog.CupertinoAlertDialog(
        title: Text(AppStrings.alert.tr,
                style: lightTextTheme.displaySmall?.copyWith(
                    fontSize: 16.sp,
                    fontFamily: CommonStrings.generalSans,
                    color: lightColorPalette.additionalSwatch1.shade900))
            .paddingOnly(bottom: 10.h),
        content: Text(title ?? AppStrings.somethingWentWrong.tr,
            style: lightTextTheme.labelMedium?.copyWith(
                fontWeight: FontWeight.w300,
                fontFamily: CommonStrings.generalSans,
                fontSize: 13.sp,
                color: lightColorPalette.additionalSwatch1.shade900)),
        actions: <CupertinoDialogAction>[
          CupertinoDialogAction(
            onPressed: () {
              onPressed();
            },
            child: Text(AppStrings.strOk.tr,
                style: lightTextTheme.titleSmall?.copyWith(
                    fontSize: 17.sp,
                    fontFamily: CommonStrings.generalSans,
                    color: lightColorPalette.additionalSwatch1.shade900)),
          ),
        ],
      ),
    );
  }
}
