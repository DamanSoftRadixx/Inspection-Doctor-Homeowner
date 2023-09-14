import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/text/app_text_widget.dart';
import 'package:inspection_doctor_homeowner/core/constants/app_strings.dart';
import 'package:inspection_doctor_homeowner/core/routes/routes.dart';
import 'package:inspection_doctor_homeowner/core/theme/app_color_palette.dart';
import 'package:inspection_doctor_homeowner/features/payments/payment/screens/payment_screen.dart';

import '../../../../core/common_ui/common_button/common_button.dart';

extension NoCardAddedYetExtension on PaymentScreen {
  noCardAddedYetWidget({required bool isNoCard}) {
    return isNoCard
        ? Container(
            width: 1.sw,
            margin: EdgeInsets.symmetric(horizontal: 20.w),
            padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 40.h),
            decoration: decorationWithElevationOnly(),
            child: Column(
              children: [
                AppTextWidget(
                  textAlign: TextAlign.center,
                  text: AppStrings.noCardAdded.tr,
                  style: CustomTextTheme.heading1WithLetterSpacing(
                      color: lightColorPalette.black),
                ),
                SizedBox(height: 10.h),
                AppTextWidget(
                  textAlign: TextAlign.center,
                  text: AppStrings.lookLikeYouHaveNotAdded.tr,
                  style:
                      CustomTextTheme.normalText(color: lightColorPalette.grey),
                ),
                SizedBox(height: 14.h),
                CommonButton(
                    commonButtonBottonText: AppStrings.addCard.tr,
                    onPress: () {
                      Get.toNamed(Routes.addCardScreen);
                    })
              ],
            ),
          )
        : const SizedBox();
  }
}
