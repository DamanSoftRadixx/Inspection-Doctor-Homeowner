import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/text/app_text_widget.dart';
import 'package:inspection_doctor_homeowner/core/constants/app_strings.dart';
import 'package:inspection_doctor_homeowner/core/theme/app_color_palette.dart';
import 'package:inspection_doctor_homeowner/features/notification/screens/notification_screen.dart';

extension NoNotificationExtension on NotificationScreen {
  noCardAddedYetWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 1.sw,
            margin: EdgeInsets.symmetric(horizontal: 20.w),
            padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 40.h),
            decoration: decorationWithElevationOnly(),
            child: Column(
              children: [
                const Icon(EvaIcons.bellOffOutline, size: 80),
                AppTextWidget(
                  textAlign: TextAlign.center,
                  text: AppStrings.noNotificationYet.tr,
                  style: CustomTextTheme.heading1WithLetterSpacing(
                      color: lightColorPalette.black),
                ),
                SizedBox(height: 10.h),
                AppTextWidget(
                  textAlign: TextAlign.center,
                  text: AppStrings.yourNotiFicationlisting.tr,
                  style:
                      CustomTextTheme.normalText(color: lightColorPalette.grey),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
