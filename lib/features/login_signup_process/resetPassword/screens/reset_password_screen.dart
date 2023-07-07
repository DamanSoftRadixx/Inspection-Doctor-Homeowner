import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/app_bar/common_appbar.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/common_button/common_button.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/text/app_text_widget.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/textfields/app_common_text_form_field.dart';
import 'package:inspection_doctor_homeowner/core/constants/app_strings.dart';
import 'package:inspection_doctor_homeowner/core/theme/app_color_palette.dart';
import 'package:inspection_doctor_homeowner/features/login_signup_process/resetPassword/controller/reset_password_controller.dart';

class ResetPasswordScreen extends GetView<ResetPasswordController> {
  const ResetPasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightColorPalette.backgroundColor,
      appBar: showAppBar(),
      body: SafeArea(
          child: Obx(
        () => Column(
          children: [
            showHeadingText(),
            showPasswordField(),
            showConfirmPasswordField(),
            showSendLinkButton(),
          ],
        ).paddingSymmetric(horizontal: 20.w),
      )),
    );
  }

  showSendLinkButton() {
    return CommonButton(
            commonButtonBottonText: AppStrings.reset.tr, onPress: () {})
        .paddingOnly(top: 50.h);
  }

  AppBar showAppBar() {
    return commonAppBarWithElevation(
        title: AppStrings.reset.tr,
        onPressBackButton: () {
          Get.back();
        });
  }

  Column showHeadingText() {
    return Column(
      children: [
        Center(
          child: AppTextWidget(
            text: AppStrings.resetcreatePassword.tr,
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
                text: AppStrings.resetNewPasswordMustUnique.tr,
                style: CustomTextTheme.normalText(
                    color: lightColorPalette.primaryGrey),
              ).paddingSymmetric(horizontal: 30.w),
            ),
          ],
        ),
      ],
    );
  }

  Widget showPasswordField() {
    return commonPasswordText(
      focusNode: controller.passwordFocusNode.value,
      controller: controller.passwordController,
      title: AppStrings.resetNewPassword.tr,
      hint: AppStrings.resetNewPassword.tr,
      keyboardType: TextInputType.visiblePassword,
      textInputAction: TextInputAction.next,
      onPress: () {
        if (controller.isHidePassword.value == false) {
          controller.isHidePassword.value = true;
        } else {
          controller.isHidePassword.value = false;
        }
      },
      passwordVisible: controller.isHidePassword.value,
    ).paddingOnly(bottom: 11.h, top: 50.h);
  }

  Widget showConfirmPasswordField() {
    return commonPasswordText(
      focusNode: controller.confirmPasswordFocusNode.value,
      controller: controller.confirmPasswordController,
      title: AppStrings.confirmpassword.tr,
      hint: AppStrings.confirmpassword.tr,
      keyboardType: TextInputType.visiblePassword,
      textInputAction: TextInputAction.next,
      onPress: () {
        if (controller.isHideConfirmPassword.value == false) {
          controller.isHideConfirmPassword.value = true;
        } else {
          controller.isHideConfirmPassword.value = false;
        }
      },
      passwordVisible: controller.isHideConfirmPassword.value,
    );
  }
}
