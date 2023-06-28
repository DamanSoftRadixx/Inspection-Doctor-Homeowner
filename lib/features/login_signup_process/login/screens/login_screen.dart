import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/app_common_text_form_field.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/app_text_widget.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/authentication_module_common_widgets.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/common_button.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/common_loader.dart';
import 'package:inspection_doctor_homeowner/core/routes/routes.dart';
import 'package:inspection_doctor_homeowner/core/theme/app_color_palette.dart';

import '../../../../../../core/common_ui/custom_icon_button.dart';
import '../../../../../../core/constants/app_strings.dart';
import '../../../../../../core/constants/common_strings.dart';
import '../../../../../../core/utils/enum.dart';
import '../../../../../../core/utils/image_resources.dart';
import '../controller/login_screen_controller.dart';

class LoginScreen extends GetView<LoginScreenController> {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          backgroundColor: lightColorPalette.primarySwatch.shade900,
          body: InkWell(
            onTap: () {
              FocusScope.of(context).requestFocus(FocusNode());
            },
            child: Stack(
              children: [
                Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(children: [
                          appBarWidget(isShowCancel: true),
                          Column(
                            children: [
                              loginHeadingWidget(),
                              emailTextfieldWidget(),
                              SizedBox(height: 5.h),
                              passwordTextfieldWidget(),
                              SizedBox(height: 20.h),
                              resetButtonWidget(),
                              SizedBox(height: 20.h),
                              loginButtonWidget(),
                            ],
                          ).paddingOnly(left: 15.w, right: 15.w),
                        ]),
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    createNewAccountWidget(),
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
          ),
        ));
  }

  loginHeadingWidget() {
    return Align(
      alignment: Alignment.topLeft,
      child: AppTextWidget(
        text: AppStrings.login.tr,
        style: lightTextTheme.bodyLarge?.copyWith(
          fontSize: 24.sp,
          color: lightColorPalette.whiteColorPrimary.shade900,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  passwordTextfieldWidget() {
    return AppTextFormField(
      focusNode: controller.passwordFocusNode,
      controller: controller.passwordController,
      obscureText: controller.isVisiblePassword.value,
      keyboardType: TextInputType.emailAddress,
      showCursor: true,
      // labelText: AppStrings.loginScreenPassword.tr,
      filled: true,
      hintText: AppStrings.loginPassword.tr,
      suffixIcon: CustomIconButton(
        onPressed: () {
          if (controller.isVisiblePassword.value == false) {
            controller.isVisiblePassword.value = true;
          } else {
            controller.isVisiblePassword.value = false;
          }
        },
        icon: Icon(
          controller.isVisiblePassword.value == true
              ? Icons.visibility_off
              : Icons.remove_red_eye,
          color: lightColorPalette.additionalSwatch1.shade900,
        ),
      ),
      isCheckValidation: controller.passwordError.value,
      validationMsg: controller.passwordErrorMessage.value,
      onChanged: (value) {
        if (controller.passwordController.text.length >= 8) {
          controller.passwordError.value = false;
        }
      },
    );
  }

  emailTextfieldWidget() {
    return AppTextFormField(
      filled: true,
      focusNode: controller.emailFocusNode,
      fillColor: lightColorPalette.whiteColorPrimary.shade900,
      controller: controller.emailController,
      isCheckValidation: controller.emailError.value,
      validationMsg: controller.emailErrorMessage.value,
      keyboardType: TextInputType.emailAddress,
      showCursor: true,
      //  labelText: AppStrings.email.tr,
      hintText: AppStrings.hintEmail.tr,
      onChanged: (value) {
        if (GetUtils.isEmail(value)) {
          controller.emailError.value = false;
        }
      },
    );
  }

  resetButtonWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        GestureDetector(
            child: AppTextWidget(
                    text: AppStrings.loginResetButton.tr,
                    style: lightTextTheme.headlineMedium?.copyWith(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w400,
                        fontFamily: CommonStrings.vitnamPro,
                        color: lightColorPalette.whiteColorPrimary.shade600))
                .paddingZero,
            onTap: () {
              Get.toNamed(Routes.forgetScreen);
            })
      ],
    );
  }

  loginButtonWidget() {
    return CommonButton(
      minWidth: 1.sw,
      commonButtonBottonText: AppStrings.login.tr,
      bgColor: lightColorPalette.secondarySwatch.shade900,
      style: lightTextTheme.displaySmall?.copyWith(
          fontSize: 16.sp,
          fontFamily: CommonStrings.vitnamPro,
          fontWeight: FontWeight.w500,
          color: lightColorPalette.whiteColorPrimary.shade900),
      spaceBetween: 12.w,
      isIconEnable: true,
      image: ImageResource.forwardArrow,
      type: ShowImagePositionAt.right,
      onPress: () {
        controller.isValidLogin();
        /*controller.isCheckLogin();*/
      },
    );
  }

  createNewAccountWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(AppStrings.loginText.tr,
            style: lightTextTheme.titleMedium?.copyWith(
              color: lightColorPalette.whiteColorPrimary.shade900,
              fontFamily: CommonStrings.vitnamPro,
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
            )),
        SizedBox(height: 16.h),
        CustomIconButton(
          padding: EdgeInsets.zero,
          icon: Text(AppStrings.loginText2.tr,
              style: lightTextTheme.titleMedium?.copyWith(
                  decoration: TextDecoration.underline,
                  color: lightColorPalette.whiteColorPrimary.shade600,
                  fontFamily: CommonStrings.vitnamPro,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400)),
          onPressed: () {
            Get.toNamed(Routes.signupScreen);
          },
        ),
      ],
    );
  }
}
