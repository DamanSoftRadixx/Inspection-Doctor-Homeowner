import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:inspection_doctor_homeowner/features/login_signup_process/login/screens/login_screen.dart';

import '../../../../../../core/constants/app_strings.dart';
import '../../../../../../core/constants/common_strings.dart';
import '../../../../../../core/theme/app_color_palette.dart';

extension FlowsScreenExtension on LoginScreen {
  loginTextFormField() {
    return Column(
      children: [
        TextField(
          controller: controller.emailController,
          style: lightTextTheme.bodyLarge?.copyWith(
              fontSize: 14.sp,
              fontFamily: CommonStrings.vitnamPro,
              fontWeight: FontWeight.w400,
              color: lightColorPalette.additionalSwatch1.shade700),
          decoration: InputDecoration(
            hintText: AppStrings.loginEmail,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(12.0.r)),
                borderSide: BorderSide(
                    color: lightColorPalette.additionalSwatch1.shade800)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(12.0.r)),
                borderSide: BorderSide(
                    color: lightColorPalette.additionalSwatch1.shade800)),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(12.0.r)),
                borderSide: BorderSide(
                    color: lightColorPalette.additionalSwatch1.shade800)),
          ),
        ).paddingOnly(left: 20.w, right: 20.w, top: 20.h, bottom: 20.h),
      ],
    );
    // CommonTextFormField(
    //   keyboardType: TextInputType.emailAddress,
    //   controller: controller.emailController,
    //   hintText:AppStrings.loginEmail,
    //   decoration: InputDecoration(
    //     border:  OutlineInputBorder(
    //         borderRadius: BorderRadius.all(Radius.circular(5.0.r)),
    //         borderSide: BorderSide(color: lightColorPalette.additionalSwatch1.shade800)),
    //     focusedBorder: OutlineInputBorder(
    //         borderRadius: BorderRadius.all(Radius.circular(5.0.r)),
    //         borderSide: BorderSide(color:  lightColorPalette.additionalSwatch1.shade800)),
    //     enabledBorder: OutlineInputBorder(
    //         borderRadius: BorderRadius.all(Radius.circular(5.0.r)),
    //         borderSide: BorderSide( color:  lightColorPalette.additionalSwatch1.shade800)
    //     ),
    //     errorBorder: OutlineInputBorder(
    //         borderRadius: BorderRadius.all(Radius.circular(5.0.r)),
    //         borderSide: BorderSide(color: lightColorPalette.additionalSwatch1.shade800)
    //
    //     ),
    //     focusedErrorBorder:OutlineInputBorder(
    //         borderRadius: BorderRadius.all(Radius.circular(5.0.r)),
    //         borderSide: BorderSide(color:  lightColorPalette.additionalSwatch1.shade800)),
    //     hintText: AppStrings.theMoreDetailsYouGive.tr,
    //     errorText:AppStrings.helperText.tr,
    //     errorStyle: lightTextTheme.bodyText1?.copyWith(
    //
    //         fontSize: 14.sp,
    //         fontFamily: CommonStrings.vitnamPro,
    //         fontWeight: FontWeight.w400,
    //         color:  lightColorPalette.additionalSwatch1.shade700
    //     ),
    //     hintStyle:  lightTextTheme.bodyText1?.copyWith(
    //
    //         fontSize: 16.sp,
    //         fontFamily: CommonStrings.vitnamPro,
    //         fontWeight: FontWeight.w400,
    //         color:  lightColorPalette.additionalSwatch1.shade700
    //     ),
    //   ),
    //
    // ),
  }
}
