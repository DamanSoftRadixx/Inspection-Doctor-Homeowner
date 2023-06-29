import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:inspection_doctor_homeowner/core/common_functionality/dismiss_keyboard.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/app_common_text_form_field.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/app_text_widget.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/asset.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/common_button.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/common_image_widget.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/custom_icon_button.dart';
import 'package:inspection_doctor_homeowner/core/constants/app_strings.dart';
import 'package:inspection_doctor_homeowner/core/routes/routes.dart';
import 'package:inspection_doctor_homeowner/core/theme/app_color_palette.dart';
import 'package:inspection_doctor_homeowner/core/utils/image_resources.dart';
import 'package:inspection_doctor_homeowner/features/login_signup_process/login/controller/login_controller.dart';

class LoginScreen extends GetView<LoginController> {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightColorPalette.whiteColorPrimary.shade900,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Container(height: 30.h),
            Stack(
              children: [
                Obx(() => Container(
                    color: lightColorPalette.backgroundColor,
                    margin: EdgeInsets.only(top: 21.h),
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    height: 0.870.sh,
                    width: 1.sw,
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        getWelcomeLoginView(),
                        //Email
                        Column(
                          children: [
                            showEmailField().paddingOnly(bottom: 11.h),
                            showPasswordField(),
                            showForgotPassword().paddingOnly(top: 10.h),
                            showLoginButton().paddingOnly(top: 50.h),
                            showSignupButton().paddingOnly(
                                left: 20.w,
                                right: 20.w,
                                top: 20.h,
                                bottom: 29.h),
                            shwoDriver(),
                            showOtherLoginOption(),
                          ],
                        )
                      ],
                    ))),
                getTopLogo(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Column showOtherLoginOption() {
    return Column(
      children: [
        AppTextWidget(
          style:
              CustomTextTheme.normalText(color: lightColorPalette.primaryGrey),
          text: AppStrings.orContinueWith.tr,
        ).paddingOnly(top: 29.h, bottom: 20.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 44.h,
              width: 70.w,
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 0,
                      color: lightColorPalette.primaryBlue,
                      offset: const Offset(0, -1),
                      spreadRadius: 0,
                    ),
                  ],
                  color: lightColorPalette.whiteColorPrimary.shade900,
                  borderRadius: BorderRadius.circular(6.r),
                  border: Border.all(
                      width: 0.3.w, color: lightColorPalette.stroke)),
              child: Center(
                child: AssetWidget(
                  asset: Asset(type: AssetType.svg, path: ImageResource.google),
                  boxFit: BoxFit.fitWidth,
                ),
              ),
            ),
            Container(
              height: 44.h,
              width: 70.w,
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 0,
                      color: lightColorPalette.primaryBlue,
                      offset: const Offset(0, -1),
                      spreadRadius: 0,
                    ),
                  ],
                  color: lightColorPalette.whiteColorPrimary.shade900,
                  borderRadius: BorderRadius.circular(6.r),
                  border: Border.all(
                      width: 0.3.w, color: lightColorPalette.stroke)),
              child: Center(
                child: AssetWidget(
                  asset:
                      Asset(type: AssetType.svg, path: ImageResource.facebook),
                  boxFit: BoxFit.fitWidth,
                ),
              ),
            ).paddingSymmetric(horizontal: 10),
            Container(
              height: 44.h,
              width: 70.w,
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 0,
                      color: lightColorPalette.primaryBlue,
                      offset: const Offset(0, -1),
                      spreadRadius: 0,
                    ),
                  ],
                  color: lightColorPalette.whiteColorPrimary.shade900,
                  borderRadius: BorderRadius.circular(6.r),
                  border: Border.all(
                      width: 0.3.w, color: lightColorPalette.stroke)),
              child: Center(
                child: AssetWidget(
                  asset: Asset(type: AssetType.svg, path: ImageResource.apple),
                  boxFit: BoxFit.fitWidth,
                ),
              ),
            ),
          ],
        )
      ],
    );
  }

  Stack shwoDriver() {
    return Stack(
      alignment: Alignment.center,
      children: [
        Divider(color: lightColorPalette.stroke),
        Container(
          height: 2.h,
          width: 70.w,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(2.r),
              color: lightColorPalette.primaryBlue),
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
    );
  }

  showPasswordField() {
    return commonPasswordText(
      focusNode: controller.passwordFocusNode.value,
      controller: controller.passwordController,
      title: AppStrings.loginScreenPassword.tr,
      hint: AppStrings.loginScreenPassword.tr,
      keyboardType: TextInputType.visiblePassword,
      textInputAction: TextInputAction.next,
      onPress: () {
        if (controller.isVisiblePassword.value == false) {
          controller.isVisiblePassword.value = true;
        } else {
          controller.isVisiblePassword.value = false;
        }
      },
      passwordVisible: controller.isVisiblePassword.value,
    );
  }

  Align showForgotPassword() {
    return Align(
      alignment: Alignment.topLeft,
      child: CustomInkwell(
        padding: EdgeInsets.zero,
        onTap: () {
          // dismissKeyboard();
          // Get.toNamed(Routes.forgotScreen);
        },
        child: AppTextWidget(
          style:
              CustomTextTheme.normalText(color: lightColorPalette.primaryBlue),
          text: AppStrings.forgotPassword.tr,
        ),
      ),
    );
  }

  CommonButton showLoginButton() {
    return CommonButton(
        commonButtonBottonText: AppStrings.login.tr, onPress: () {});
  }

  Row showSignupButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        AppTextWidget(
          style:
              CustomTextTheme.normalText(color: lightColorPalette.primaryGrey),
          text: AppStrings.dontHaveAccount.tr,
        ),
        CustomInkwell(
          padding: EdgeInsets.zero,
          onTap: () {
            dismissKeyboard();
            Get.toNamed(Routes.signupScreen);
          },
          child: AppTextWidget(
            style: CustomTextTheme.normalText(
                color: lightColorPalette.primaryBlue),
            text: AppStrings.signup.tr,
          ),
        )
      ],
    );
  }

  getWelcomeLoginView() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AssetWidget(
          asset: Asset(type: AssetType.svg, path: ImageResource.welcome),
          boxFit: BoxFit.fitWidth,
        ),
      ],
    ).paddingOnly(top: 57.h, bottom: 50.h);
  }

  Center getTopLogo() {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          color: lightColorPalette.whiteColorPrimary.shade900,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              blurRadius: 0,
              spreadRadius: 0,
              offset: const Offset(0, 1),
              color: lightColorPalette.primaryBlue,
            )
          ],
        ),
        child: AssetWidget(
          asset: Asset(type: AssetType.svg, path: ImageResource.loginLogo),
          boxFit: BoxFit.fitWidth,
        ),
      ),
    );
  }
}
