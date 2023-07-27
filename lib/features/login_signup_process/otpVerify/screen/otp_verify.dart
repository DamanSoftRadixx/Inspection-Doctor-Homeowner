import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/app_bar/common_appbar.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/asset_widget/common_image_widget.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/common_button/common_button.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/common_button/custom_icon_button.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/common_loader/common_loader.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/text/app_text_widget.dart';
import 'package:inspection_doctor_homeowner/core/constants/app_strings.dart';
import 'package:inspection_doctor_homeowner/core/theme/app_color_palette.dart';
import 'package:inspection_doctor_homeowner/core/utils/image_resources.dart';
import 'package:inspection_doctor_homeowner/features/login_signup_process/otpVerify/controller/otp_verify_controller.dart';
import 'package:pinput/pinput.dart';

class OtpVerifyScreen extends GetView<OtpVerifyController> {
  const OtpVerifyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightColorPalette.whiteColorPrimary.shade900,
      appBar: showAppBar(),
      body: SafeArea(
        child: Obx(() => Stack(
              children: [
                SingleChildScrollView(
                  child: Column(
                    children: [
                      showHeadingText(),
                      showPinView(),
                      showVerifyButton(),
                      showResendOTP()
                    ],
                  ),
                ),
                CommonLoader(isLoading: controller.isShowLoader.value)
              ],
            )),
      ),
    );
  }

  showResendOTP() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        AppTextWidget(
          style: CustomTextTheme.normalText(color: lightColorPalette.grey),
          text: controller.timerCountdown.value > 0
              ? AppStrings.expiresIn.tr
              : AppStrings.dontYouReceivedOTP.tr,
        ),
        CustomInkwell(
          padding: EdgeInsets.only(left: 3.w),
          onTap: () {
            controller.resendOtpButtonPressed();
          },
          child: AppTextWidget(
            style: CustomTextTheme.normalTextWithWeight600(
                color: lightColorPalette.black),
            text: controller.timerCountdown.value > 0
                ? controller.getTimerLabel()
                : AppStrings.resendOTP.tr,
          ),
        ),
      ],
    ).paddingOnly(top: 50.h);
  }

  showVerifyButton() {
    return CommonButton(
            commonButtonBottonText: AppStrings.verify.tr,
            onPress: controller.verifyCode.value.length == 4
                ? () {
                    controller.onTapVerifyButton();
                  }
                : null)
        .paddingOnly(left: 20.w, right: 20.w, top: 50.h);
  }

  showPinView() {
    return Column(
      children: [
        Pinput(
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          defaultPinTheme: defaultPinTheme,
          focusedPinTheme: focusedPinTheme,
          submittedPinTheme: submittedPinTheme,
          showCursor: true,
          onCompleted: (pin) {
            controller.verifyCode.value = pin;
            controller.isOtpError.value = false;
          },
          onChanged: (text) {
            controller.verifyCode.value = text;
            controller.isOtpError.value = false;

            /* if (text.length < 4) {
            }*/
          },
        ).paddingOnly(top: 31.h),
        Visibility(
          visible: controller.isOtpError.value,
          child: Align(
            alignment: Alignment.center,
            child: AppTextWidget(
              text: controller.otpError.value,
              style: CustomTextTheme.subtext(
                color: lightColorPalette.redDark,
              ),
            ).paddingOnly(top: 10.h),
          ),
        )
      ],
    );
  }

  AppBar showAppBar() {
    return commonAppBarWithElevation(
      onPressBackButton: () {
        Get.back();
      },
      title: AppStrings.otp.tr,
      centerWidget: AssetWidget(
        asset: Asset(type: AssetType.svg, path: ImageResource.cid_new),
        boxFit: BoxFit.fitWidth,
      ),
    );
  }

  Column showHeadingText() {
    return Column(
      children: [
        Center(
          child: AppTextWidget(
            text: AppStrings.codeVerification.tr,
            style: CustomTextTheme.heading1(
              color: lightColorPalette.black,
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
                color: lightColorPalette.grey,
              ),
            ),
            AppTextWidget(
              textAlign: TextAlign.center,
              text: controller.phoneNumberOrEmail.value,
              style: CustomTextTheme.categoryText(
                height: 0,
                color: lightColorPalette.black,
              ),
            ).paddingOnly(left: 2.w),
            controller.email.value.isNotEmpty
                ? AppTextWidget(
                    textAlign: TextAlign.center,
                    text: AppStrings.and.tr,
                    style: CustomTextTheme.normalText(
                      color: lightColorPalette.grey,
                    ),
                  )
                : const SizedBox(),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppTextWidget(
              textAlign: TextAlign.center,
              text: controller.email.value,
              style: CustomTextTheme.categoryText(
                height: 0,
                color: lightColorPalette.black,
              ),
            )
          ],
        )
      ],
    );
  }
}

final defaultPinTheme = PinTheme(
  width: 44.w,
  height: 44.h,
  margin: EdgeInsets.only(left: 5.w),
  textStyle: CustomTextTheme.heading2(color: lightColorPalette.black),
  decoration: BoxDecoration(
    color: lightColorPalette.whiteColorPrimary.shade900,
    border: Border.all(color: lightColorPalette.grey, width: 0.3.w),
    borderRadius: BorderRadius.circular(10.r),
  ),
);

final focusedPinTheme = defaultPinTheme.copyDecorationWith(
  color: lightColorPalette.whiteColorPrimary.shade900,
  boxShadow: [
    BoxShadow(
      blurRadius: 14,
      color: lightColorPalette.black.withOpacity(0.25),
      offset: const Offset(0, 6),
      spreadRadius: 0,
    ),
  ],
  border: Border.all(color: lightColorPalette.black, width: 1.w),
  borderRadius: BorderRadius.circular(10.r),
);

final submittedPinTheme = defaultPinTheme.copyWith(
  decoration: defaultPinTheme.decoration?.copyWith(
      color: lightColorPalette.black.withOpacity(0.05),
      borderRadius: BorderRadius.circular(6.r)),
);
