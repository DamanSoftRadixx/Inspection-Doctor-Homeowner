import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:inspection_doctor_homeowner/core/common_functionality/dismiss_keyboard.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/app_text_widget.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/asset.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/common_appbar.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/common_button.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/common_image_widget.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/custom_icon_button.dart';
import 'package:inspection_doctor_homeowner/core/constants/app_strings.dart';
import 'package:inspection_doctor_homeowner/core/routes/routes.dart';
import 'package:inspection_doctor_homeowner/core/theme/app_color_palette.dart';
import 'package:inspection_doctor_homeowner/core/utils/image_resources.dart';
import 'package:inspection_doctor_homeowner/features/login_signup_process/otpVerify/controller/otp_verify_controller.dart';
import 'package:pinput/pinput.dart';

class OtpVerifyScreen extends GetView<OtpVerifyController> {
  const OtpVerifyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightColorPalette.backgroundColor,
      appBar: showAppBar(),
      body: SafeArea(
        child: Column(
          children: [
            showHeadingText(),
            showPinView(),
            showVerifyButton(),
            showResendOTP()
          ],
        ),
      ),
    );
  }

  showResendOTP() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        AppTextWidget(
          style:
              CustomTextTheme.normalText(color: lightColorPalette.primaryGrey),
          text: controller.isNeedResendOTP.value
              ? AppStrings.expiresIn.tr
              : AppStrings.dontYouReceivedOTP.tr,
        ),
        CustomInkwell(
          padding: EdgeInsets.only(left: 3.w),
          onTap: () {
            dismissKeyboard();
            Get.toNamed(Routes.forgetScreen);
          },
          child: AppTextWidget(
            style: CustomTextTheme.normalText(
                color: lightColorPalette.primaryBlue),
            text: controller.isNeedResendOTP.value
                ? "02:05"
                : AppStrings.resendOTP.tr,
          ),
        ),
      ],
    ).paddingOnly(top: 50.h);
  }

  showVerifyButton() {
    return CommonButton(
        commonButtonBottonText: AppStrings.verify.tr,
        onPress: () {
          dismissKeyboard();

          Get.until((route) =>
              route.settings.name == Routes.loginScreen ? true : false);
        }).paddingOnly(left: 20.w, right: 20.w, top: 50.h);
  }

  showPinView() {
    return Pinput(
      defaultPinTheme: defaultPinTheme,
      focusedPinTheme: focusedPinTheme,
      submittedPinTheme: submittedPinTheme,
      showCursor: true,
      onCompleted: (pin) {
        controller.verifyCode.value = pin;
        controller.isSubmitVisible.value = true;
      },
      onChanged: (text) {
        if (text.length < 4) {
          controller.isSubmitVisible.value = false;
        }
      },
    ).paddingOnly(top: 50.h);
  }

  AppBar showAppBar() {
    return commonAppBar(
        title: AppStrings.otp.tr,
        leading: CustomInkwell(
            onTap: () {
              Get.back();
            },
            child: AssetWidget(
              asset: Asset(type: AssetType.svg, path: ImageResource.backArrow),
              boxFit: BoxFit.fitWidth,
            )));
  }

  Column showHeadingText() {
    return Column(
      children: [
        Center(
          child: AppTextWidget(
            text: AppStrings.codeVerification.tr,
            style: CustomTextTheme.heading1(
              color: lightColorPalette.primaryDarkblue,
            ),
          ),
        ).paddingOnly(top: 57.h, bottom: 10.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppTextWidget(
              textAlign: TextAlign.center,
              text: AppStrings.oTPSent.tr,
              style: CustomTextTheme.normalText(
                color: lightColorPalette.primaryGrey,
              ),
            ),
            AppTextWidget(
              textAlign: TextAlign.center,
              text: " +1 8451265847",
              style: CustomTextTheme.categoryText(
                color: lightColorPalette.primaryDarkblue,
              ),
            )
          ],
        ),
      ],
    );
  }
}

final defaultPinTheme = PinTheme(
  width: 44.w,
  height: 44.h,
  margin: EdgeInsets.only(left: 5.w),
  textStyle: CustomTextTheme.heading2(color: lightColorPalette.primaryDarkblue),
  decoration: BoxDecoration(
    color: lightColorPalette.whiteColorPrimary.shade900,
    border: Border.all(color: lightColorPalette.stroke, width: 0.3.w),
    borderRadius: BorderRadius.circular(4.r),
  ),
);

final focusedPinTheme = defaultPinTheme.copyDecorationWith(
  color: lightColorPalette.whiteColorPrimary.shade900,
  boxShadow: [
    BoxShadow(
      blurRadius: 14,
      color: lightColorPalette.primaryBlue.withOpacity(0.25),
      offset: const Offset(0, 6),
      spreadRadius: 0,
    ),
  ],
  border: Border.all(color: lightColorPalette.primaryBlue, width: 1.w),
  borderRadius: BorderRadius.circular(4.r),
);

final submittedPinTheme = defaultPinTheme.copyWith(
  decoration: defaultPinTheme.decoration
      ?.copyWith(color: lightColorPalette.backgroundColor),
);
