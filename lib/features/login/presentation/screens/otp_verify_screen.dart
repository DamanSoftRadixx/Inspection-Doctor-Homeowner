import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/app_text_widget.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/authentication_module_common_widgets.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/common_loader.dart';
import 'package:inspection_doctor_homeowner/core/constants/app_strings.dart';
import 'package:inspection_doctor_homeowner/features/login/presentation/controller/verify_screen_controlller.dart';

import '../../../../core/common_ui/app_common_text_form_field.dart';
import '../../../../core/common_ui/common_button.dart';
import '../../../../core/common_ui/custom_icon_button.dart';
import '../../../../core/constants/common_strings.dart';
import '../../../../core/theme/app_color_palette.dart';

class OTPVerifyScreen extends GetView<VerifyScreenController> {
  const OTPVerifyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: lightColorPalette.primarySwatch.shade900,
        // appBar: PreferredSize(preferredSize: Size(0,0),child: Text(""),),
        body: Obx(() => GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                FocusScope.of(context).requestFocus(FocusNode());
              },
              child: Stack(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(children: [
                            appBarWidget(isShowCancel: true),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 15.w),
                              child: Column(
                                children: [
                                  verificationHeadingWidget(),
                                  SizedBox(
                                    height: 5.h,
                                  ),
                                  verificationSubHeadingWidget(),
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  otpTextFieldWidget(),
                                  SizedBox(
                                    height: 24.h,
                                  ),
                                  confirmOtpButtonWidget(),
                                ],
                              ),
                            )

                            /*   Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(AppStrings.verifyScreenText.tr,
                                    style: lightTextTheme.subtitle1?.copyWith(
                                        color: lightColorPalette
                                            .whiteColorPrimary.shade900,
                                        fontFamily: CommonStrings.vitnamPro,
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w500)),
                                SizedBox(width: 6.w),
                                CustomIconButton(
                                  padding: EdgeInsets.zero,
                                  icon: Text(AppStrings.verifyScreenResend.tr,
                                      style: lightTextTheme.subtitle1?.copyWith(
                                          color: lightColorPalette
                                              .additionalSwatch1.shade600,
                                          fontFamily: CommonStrings.vitnamPro,
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w800)),
                                  onPressed: () {
                                    controller.onPressResendButton();
                                  },
                                )
                              ],
                            ).paddingOnly(left: 20.w, top: 20.h),*/
                          ]),
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      resendButtonWidget(),
                      SizedBox(
                        height: 30.h,
                      )
                    ],
                  ),
                  controller.isLoading.value == true
                      ? const CommonLoader()
                      : Container()
                ],
              ),
            )));
  }

  verificationSubHeadingWidget() {
    return Align(
      alignment: Alignment.topLeft,
      child: AppTextWidget(
        text:
            '${AppStrings.verificationCodeHasSentToYourEmail.tr} ${controller.signupData?.email ?? ""}',
        style: TextStyle(
          fontSize: 14.sp,
          color: lightColorPalette.whiteColorPrimary.shade900,
          fontWeight: FontWeight.w400,
        ),
      ),
    ).paddingOnly(left: 4.w);
  }

  verificationHeadingWidget() {
    return Align(
      alignment: Alignment.topLeft,
      child: AppTextWidget(
        text: AppStrings.verificationCode.tr,
        style: lightTextTheme.bodyLarge?.copyWith(
          fontSize: 24.sp,
          color: lightColorPalette.whiteColorPrimary.shade900,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  otpTextFieldWidget() {
    return AppTextFormField(
      maxLength: 4,
      controller: controller.verificationController,
      focusNode: controller.verificationFocusNode,
      keyboardType: TextInputType.number,
      hintText: AppStrings.verificationCode.tr,
      isCheckValidation: controller.errorVerify.value,
      validationMsg: AppStrings.verifyScreenValidation.tr,
      showCursor: true,
      onChanged: (value) {
        controller.onChangedVerificationCode(value: value);
      },
    );
  }

  confirmOtpButtonWidget() {
    return CommonButton(
      minWidth: 1.sw,
      commonButtonBottonText: AppStrings.verifyScreenButton.tr,
      bgColor: lightColorPalette.secondarySwatch.shade900,
      radius: 8.r,
      style: lightTextTheme.displaySmall?.copyWith(
          fontSize: 16.sp,
          fontFamily: CommonStrings.vitnamPro,
          fontWeight: FontWeight.w500,
          color: lightColorPalette.whiteColorPrimary.shade900),
      onPress: () {
        controller.onPressConfirmButton();
      },
    );
  }

  resendButtonWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(AppStrings.verifyScreenText.tr,
            style: lightTextTheme.titleMedium?.copyWith(
              color: lightColorPalette.whiteColorPrimary.shade900,
              fontFamily: CommonStrings.vitnamPro,
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
            )),
        SizedBox(height: 16.h),
        controller.start.value == 0
            ? CustomIconButton(
                padding: EdgeInsets.zero,
                icon: Text(AppStrings.verifyScreenResend.tr,
                    style: lightTextTheme.titleMedium?.copyWith(
                        decoration: TextDecoration.underline,
                        color: lightColorPalette.whiteColorPrimary.shade600,
                        fontFamily: CommonStrings.vitnamPro,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w400)),
                onPressed: () {
                  if (controller.start.value == 0) {
                    controller.onPressResendButton();
                  }
                },
              )
            : Text(getTimerLabel(),
                style: lightTextTheme.titleMedium?.copyWith(
                    decoration: TextDecoration.underline,
                    color: lightColorPalette.whiteColorPrimary.shade600,
                    fontFamily: CommonStrings.vitnamPro,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400)),
      ],
    );
  }

  getTimerLabel() {
    if (controller.start.toString().length < 2) {
      return "${AppStrings.resendCode} in ${controller.start.toString()} secs";
    }
    return "${AppStrings.resendCode} in ${controller.start.toString()} secs";
  }
}
