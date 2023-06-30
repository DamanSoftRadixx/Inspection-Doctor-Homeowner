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
import 'package:inspection_doctor_homeowner/features/login_signup_process/forgetPassword/controller/forget_password_controller.dart';

class ForgetPasswordScreen extends GetView<ForgetPasswordController> {
  const ForgetPasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightColorPalette.backgroundColor,
      appBar: showAppBar(),
      body: SafeArea(
        child: Column(
          children: [
            showHeadingText(),
            showSendLinkButton(),
            showResendOTP(),
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
          text: AppStrings.dontYouReceivedOTP.tr,
        ),
        CustomInkwell(
          padding: EdgeInsets.only(top: 5.h, left: 3.w),
          onTap: () {
            dismissKeyboard();
            Get.toNamed(Routes.signupScreen);
          },
          child: AppTextWidget(
            style: CustomTextTheme.normalText(
                color: lightColorPalette.primaryBlue),
            text: AppStrings.resendlink.tr,
          ),
        ),
      ],
    ).paddingOnly(top: 50.h);
  }

  showSendLinkButton() {
    return CommonButton(
            commonButtonBottonText: AppStrings.sendlink.tr, onPress: () {})
        .paddingOnly(left: 20.w, right: 20.w, top: 50.h);
  }

  AppBar showAppBar() {
    return commonAppBar(
        title: AppStrings.forgot.tr,
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
            text: AppStrings.donworryItOccurs.tr,
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
              text: AppStrings.forgetPleaseEnterEmail.tr,
              style: CustomTextTheme.normalText(
                  color: lightColorPalette.primaryGrey),
            ),
          ],
        ),
      ],
    );
  }
}
