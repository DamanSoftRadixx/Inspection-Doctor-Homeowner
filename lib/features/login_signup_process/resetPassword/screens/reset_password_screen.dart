import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:inspection_doctor_homeowner/core/common_functionality/dismiss_keyboard.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/app_bar/common_appbar.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/asset_widget/common_image_widget.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/common_button/common_button.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/common_loader/common_loader.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/text/app_text_widget.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/textfields/app_common_text_form_field.dart';
import 'package:inspection_doctor_homeowner/core/constants/app_strings.dart';
import 'package:inspection_doctor_homeowner/core/theme/app_color_palette.dart';
import 'package:inspection_doctor_homeowner/core/utils/image_resources.dart';
import 'package:inspection_doctor_homeowner/features/login_signup_process/resetPassword/controller/reset_password_controller.dart';

class ResetPasswordScreen extends GetView<ResetPasswordController> {
  const ResetPasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightColorPalette.whiteColorPrimary.shade900,
      appBar: showAppBar(),
      body: InkWell(
        focusColor: Colors.transparent,
        hoverColor: Colors.transparent,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onTap: (){
          dismissKeyboard();
        },
        child: SafeArea(
          child: Obx(() => Stack(
                children: [
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        showHeadingText(),
                        showPasswordField(),
                        showConfirmPasswordField(),
                        showResetButton(),
                      ],
                    ).paddingSymmetric(horizontal: 20.w),
                  ),
                  CommonLoader(isLoading: controller.isShowLoader.value)
                ],
              )),
        ),
      ),
    );
  }

  showResetButton() {
    return CommonButton(
            commonButtonBottonText: AppStrings.reset.tr,
            onPress: controller.passwordController.value.text.isNotEmpty &&
                    controller.confirmPasswordController.value.text.isNotEmpty
                ? () {
                    controller.validate(
                        password: controller.passwordController.value.text,
                        confirmPassword:
                            controller.confirmPasswordController.value.text);
                  }
                : null)
        .paddingOnly(top: 50.h);
  }

  AppBar showAppBar() {
    return commonAppBarWithElevation(
      onPressBackButton: () {
        Get.back();
      },
      title: AppStrings.reset.tr,
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
            text: AppStrings.resetcreatePassword.tr,
            style: CustomTextTheme.heading1(
              color: lightColorPalette.black,
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
                style:
                    CustomTextTheme.normalText(color: lightColorPalette.grey),
              ).paddingSymmetric(horizontal: 30.w),
            ),
          ],
        ),
      ],
    );
  }

  Widget showPasswordField() {
    return commonPasswordText(
      isError: controller.passwordError.value,
      errorMsg: controller.passwordErrorMessage.value,
      focusNode: controller.passwordFocusNode.value,
      controller: controller.passwordController.value,
      title: AppStrings.resetNewPassword.tr,
      hint: AppStrings.resetNewPassword.tr,
      keyboardType: TextInputType.visiblePassword,
      textInputAction: TextInputAction.next,
      onChanged: (value) {
        controller.onChangedPasswordTextField(value: value);
      },
      onPress: () {
        controller.onPressPasswordEyeIcon();
      },
      passwordVisible: controller.isHidePassword.value,
    ).paddingOnly(bottom: 11.h, top: 50.h);
  }

  Widget showConfirmPasswordField() {
    return commonPasswordText(
      isError: controller.confirmPasswordError.value,
      errorMsg: controller.confirmPasswordErrorMessage.value,
      focusNode: controller.confirmPasswordFocusNode.value,
      controller: controller.confirmPasswordController.value,
      title: AppStrings.confirmPassword.tr,
      hint: AppStrings.confirmPassword.tr,
      keyboardType: TextInputType.visiblePassword,
      textInputAction: TextInputAction.next,
      onChanged: (value) {
        controller.onChangedConfirmPasswordTextField(value: value);
      },
      onPress: () {
        controller.onPressConfirmPasswordEyeIcon();
      },
      passwordVisible: controller.isHideConfirmPassword.value,
    );
  }
}
