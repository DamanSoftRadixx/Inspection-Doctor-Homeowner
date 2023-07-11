import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:inspection_doctor_homeowner/core/common_functionality/dismiss_keyboard.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/asset_widget/common_image_widget.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/common_button/common_button.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/common_button/custom_icon_button.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/text/app_text_widget.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/textfields/app_common_text_form_field.dart';
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
      backgroundColor: lightColorPalette.backgroundColor,
      body: SafeArea(
        child: ListView(
          children: [
            Container(
                height: 35.h,
                color: lightColorPalette.whiteColorPrimary.shade900),
            Stack(
              children: [
                Obx(() => SizedBox(
                    // height: 0.9.sh,
                    width: 1.sw,
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Container(
                            width: 1.sw,
                            height: 23.h,
                            color:
                                lightColorPalette.whiteColorPrimary.shade900),
                        getWelcomeLoginView(),
                        //Email
                        Column(
                          children: [
                            showEmailField(),
                            showPasswordField(),
                            showForgotPassword().paddingOnly(top: 10.h),
                            showLoginButton().paddingOnly(top: 50.h),
                            showSignupButton(),
                            showDivider(),
                            showOtherLoginOption(),
                          ],
                        ).paddingOnly(left: 20.w, right: 20.w)
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

  Stack showDivider() {
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
      errorMsg: controller.emailErrorMessage.value,
      isError: controller.emailError.value,
      focusNode: controller.emailFocusNode.value,
      controller: controller.emailController,
      title: AppStrings.email.tr,
      hint: AppStrings.email.tr,
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      onChanged: (value) {
        if (value.isNotEmpty && controller.emailController.text.isEmail) {
          controller.emailError.value = false;
        }
      },
    ).paddingOnly(bottom: 11.h);
  }

  showPasswordField() {
    return commonPasswordText(
      isError: controller.passwordError.value,
      errorMsg: controller.passwordErrorMessage.value,
      onChanged: (value) {
        if (value.isNotEmpty) {
          if (controller.passwordController.text.length >= 8) {
            controller.passwordError.value = false;
          }
        }
      },
      focusNode: controller.passwordFocusNode.value,
      controller: controller.passwordController,
      title: AppStrings.loginScreenPassword.tr,
      hint: AppStrings.loginScreenPassword.tr,
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
    );
  }

  Align showForgotPassword() {
    return Align(
      alignment: Alignment.topLeft,
      child: CustomInkwell(
        padding: EdgeInsets.zero,
        onTap: () {
          controller.onPressForgotPasswordButton();
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
        commonButtonBottonText: AppStrings.login.tr,
        onPress: () {
          controller.onPressLoginButton();
        });
  }

  showSignupButton() {
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
            style: CustomTextTheme.normalTextWithWeight600(
                color: lightColorPalette.primaryBlue),
            text: AppStrings.signup.tr,
          ),
        )
      ],
    ).paddingOnly(
      left: 20.w,
      right: 20.w,
      top: 20.h,
      bottom: 29.h,
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
