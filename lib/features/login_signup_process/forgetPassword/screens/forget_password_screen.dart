import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:inspection_doctor_homeowner/core/common_functionality/dismiss_keyboard.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/app_bar/common_appbar.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/common_button/common_button.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/common_button/custom_icon_button.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/text/app_text_widget.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/textfields/app_common_text_form_field.dart';
import 'package:inspection_doctor_homeowner/core/constants/app_strings.dart';
import 'package:inspection_doctor_homeowner/core/routes/routes.dart';
import 'package:inspection_doctor_homeowner/core/theme/app_color_palette.dart';
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
            showEmailField(),
            showSendLinkButton(),
            // showResendOTP(),
          ],
        ).paddingSymmetric(horizontal: 20.w),
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
          text: AppStrings.dontYouReceivedLink.tr,
        ),
        CustomInkwell(
          padding: EdgeInsets.only(left: 3.w),
          onTap: () {},
          child: AppTextWidget(
            style: CustomTextTheme.normalTextWithWeight600(
                color: lightColorPalette.primaryBlue),
            text: AppStrings.resendlink.tr,
          ),
        ),
      ],
    ).paddingOnly(top: 50.h);
  }

  showSendLinkButton() {
    return CommonButton(
        commonButtonBottonText: AppStrings.sendOTP.tr,
        onPress: () {
          dismissKeyboard();
          Get.toNamed(Routes.otpVerifyScreen,
              arguments: GetArgumentConstants.otpFromForget);
        }).paddingOnly(top: 50.h);
  }

  AppBar showAppBar() {
    return commonAppBarWithElevation(
      onPressBackButton: () {
        Get.back();
      },
      title: AppStrings.forgot.tr,
    );
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
            Expanded(
              child: AppTextWidget(
                textAlign: TextAlign.center,
                text: AppStrings.forgetPleaseEnterEmail.tr,
                style: CustomTextTheme.normalText(
                    color: lightColorPalette.primaryGrey),
              ).paddingSymmetric(horizontal: 30.w),
            ),
          ],
        ),
      ],
    );
  }

  Widget showEmailField() {
    return commonTextFieldWidget(
      focusNode: controller.emailFocusNode.value,
      controller: controller.emailController,
      title: AppStrings.email.tr,
      hint: AppStrings.email.tr,
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      onChanged: (value) {},
    ).paddingOnly(bottom: 11.h, top: 50.h);
  }
}
