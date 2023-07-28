import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/asset_widget/common_image_widget.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/common_button/common_button.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/common_button/custom_icon_button.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/common_loader/common_loader.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/text/app_text_widget.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/textfields/app_common_text_form_field.dart';
import 'package:inspection_doctor_homeowner/core/constants/app_strings.dart';
import 'package:inspection_doctor_homeowner/core/theme/app_color_palette.dart';
import 'package:inspection_doctor_homeowner/core/utils/foundation.dart';
import 'package:inspection_doctor_homeowner/core/utils/image_resources.dart';
import 'package:inspection_doctor_homeowner/features/login_signup_process/login/controller/login_controller.dart';

class LoginScreen extends GetView<LoginController> {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightColorPalette.whiteColorPrimary.shade900,
      appBar: PreferredSize(
          preferredSize: Size(0, 0.h),
          child: Container(
            color: lightColorPalette.whiteColorPrimary.shade900,
            height: 40.h,
          )),
      body: WillPopScope(
        onWillPop: () async => false,
        child: SafeArea(
          child: Obx(() => Stack(
                children: [
                  ListView(
                    physics: const RangeMaintainingScrollPhysics(),
                    children: [
                      Container(
                          height: 35.h,
                          color: lightColorPalette.whiteColorPrimary.shade900),
                      Stack(
                        children: [
                          SizedBox(
                              // height: 0.9.sh,
                              width: 1.sw,
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Container(
                                      width: 1.sw,
                                      height: 23.h,
                                      color: lightColorPalette
                                          .whiteColorPrimary.shade900),
                                  getWelcomeLoginView(),
                                  //Email
                                  Column(
                                    children: [
                                      showLanguageSelection()
                                          .paddingOnly(bottom: 10.h),
                                      showEmailField(),
                                      showPasswordField(),
                                      showForgotPassword()
                                          .paddingOnly(top: 10.h),
                                      showLoginButton().paddingOnly(top: 50.h),
                                      showSignupButton(),
                                      showDivider(),
                                      showOtherLoginOption(),
                                    ],
                                  ).paddingOnly(left: 20.w, right: 20.w)
                                ],
                              )),
                          getTopLogo(),
                        ],
                      ),
                    ],
                  ),
                  CommonLoader(isLoading: controller.isShowLoader.value)
                ],
              )),
        ),
      ),
    );
  }

  Column showOtherLoginOption() {
    return Column(
      children: [
        AppTextWidget(
          style: CustomTextTheme.normalText(color: lightColorPalette.grey),
          text: AppStrings.orContinueWith.tr,
        ).paddingOnly(top: 29.h, bottom: 20.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomInkwell(
              onTap: () {
                controller.signInWithGoogle();
              },
              child: Container(
                height: 44.h,
                width: 70.w,
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 0,
                        color: lightColorPalette.black,
                        offset: const Offset(0, -1),
                        spreadRadius: 0,
                      ),
                    ],
                    color: lightColorPalette.whiteColorPrimary.shade900,
                    borderRadius: BorderRadius.circular(10.r),
                    border: Border.all(
                        width: 0.3.w, color: lightColorPalette.grey)),
                child: Center(
                  child: AssetWidget(
                    asset:
                        Asset(type: AssetType.svg, path: ImageResource.google),
                    boxFit: BoxFit.fitWidth,
                  ),
                ),
              ),
            ),
            CustomInkwell(
              onTap: () {
                controller.signInWithFb();
              },
              child: Container(
                height: 44.h,
                width: 70.w,
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 0,
                        color: lightColorPalette.black,
                        offset: const Offset(0, -1),
                        spreadRadius: 0,
                      ),
                    ],
                    color: lightColorPalette.whiteColorPrimary.shade900,
                    borderRadius: BorderRadius.circular(6.r),
                    border: Border.all(
                        width: 0.3.w, color: lightColorPalette.grey)),
                child: Center(
                  child: AssetWidget(
                    asset: Asset(
                        type: AssetType.svg, path: ImageResource.facebook),
                    boxFit: BoxFit.fitWidth,
                  ),
                ),
              ).paddingSymmetric(horizontal: 10),
            ),
            isIos
                ? CustomInkwell(
                    onTap: () {
                      controller.signInWithApple();
                    },
                    child: Container(
                      height: 44.h,
                      width: 70.w,
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 0,
                              color: lightColorPalette.black,
                              offset: const Offset(0, -1),
                              spreadRadius: 0,
                            ),
                          ],
                          color: lightColorPalette.whiteColorPrimary.shade900,
                          borderRadius: BorderRadius.circular(6.r),
                          border: Border.all(
                              width: 0.3.w, color: lightColorPalette.grey)),
                      child: Center(
                        child: AssetWidget(
                          asset: Asset(
                              type: AssetType.svg, path: ImageResource.apple),
                          boxFit: BoxFit.fitWidth,
                        ),
                      ),
                    ),
                  )
                : const SizedBox(),
          ],
        )
      ],
    );
  }

  Stack showDivider() {
    return Stack(
      alignment: Alignment.center,
      children: [
        Divider(color: lightColorPalette.grey),
        Container(
          height: 2.h,
          width: 70.w,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(2.r),
              color: lightColorPalette.black),
        ),
      ],
    );
  }

  Widget showEmailField() {
    return commonTextFieldWidget(
      focusNode: controller.emailFocusNode.value,
      controller: controller.emailController.value,
      isError: controller.emailError.value,
      errorMsg: controller.emailErrorMessage.value,
      title: AppStrings.email.tr,
      hint: AppStrings.email.tr,
      maxLength: 50,
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.deny(RegExp(r'[ ]')),
      ],
      onChanged: (value) {
        controller.onChangedEmailTextField(value: value);
      },
    ).paddingOnly(bottom: 11.h);
  }

  showPasswordField() {
    return commonPasswordText(
      onChanged: (value) {
        controller.onChangedPasswordTextField(value: value);
      },
      focusNode: controller.passwordFocusNode.value,
      controller: controller.passwordController.value,
      isError: controller.passwordError.value,
      errorMsg: controller.passwordErrorMessage.value,
      title: AppStrings.loginScreenPassword.tr,
      hint: AppStrings.loginScreenPassword.tr,
      keyboardType: TextInputType.visiblePassword,
      textInputAction: TextInputAction.next,
      onPress: () {
        controller.onPressPasswordEyeIcon();
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
          style: CustomTextTheme.normalTextWithWeight600(
              color: lightColorPalette.black),
          text: AppStrings.forgotPassword.tr,
        ),
      ),
    );
  }

  CommonButton showLoginButton() {
    return CommonButton(
        commonButtonBottonText: AppStrings.login.tr,
        onPress: controller.emailController.value.text.isNotEmpty &&
                controller.passwordController.value.text.isNotEmpty
            ? () {
                controller.onPressLoginButton();
              }
            : null);
  }

  showSignupButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        AppTextWidget(
          style: CustomTextTheme.normalText(color: lightColorPalette.grey),
          text: AppStrings.dontHaveAccount.tr,
        ),
        CustomInkwell(
          padding: EdgeInsets.zero,
          onTap: () {
            controller.onTapSignupButton();
          },
          child: AppTextWidget(
            style: CustomTextTheme.normalTextWithWeight600(
                color: lightColorPalette.black),
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

  // getWelcomeLoginView() {
  //   return Row(
  //     mainAxisAlignment: MainAxisAlignment.center,
  //     children: [
  //       AssetWidget(
  //         asset: Asset(type: AssetType.svg, path: ImageResource.welcome),
  //         boxFit: BoxFit.fitWidth,
  //       ),
  //     ],
  //   ).paddingOnly(top: 57.h, bottom: 50.h);
  // }

  getWelcomeLoginView() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AssetWidget(
              asset:
                  Asset(type: AssetType.svg, path: ImageResource.loginHandLogo),
              boxFit: BoxFit.fitWidth,
            ).paddingOnly(right: 10.w),
            AppTextWidget(
              text: AppStrings.welcomeToLogin.tr,
              style: CustomTextTheme.heading1(
                color: lightColorPalette.black,
              ),
            ),
          ],
        ).paddingOnly(top: 22.h, bottom: 10.h),
        Center(
          child: AppTextWidget(
            textAlign: TextAlign.center,
            text: AppStrings.fillLoginDetail,
            style: CustomTextTheme.normalText(
              color: lightColorPalette.grey,
            ),
          ),
        ),
      ],
    ).paddingOnly(top: 57.h, bottom: 50.h, left: 50.w, right: 50.w);
  }

  getTopLogo() {
    return Column(
      children: [
        // Stack(
        //   alignment: Alignment.center,
        //   children: [
        //     Center(
        //       child: Container(
        //         height: 70.h,
        //         width: 70.w,
        //         decoration: BoxDecoration(
        //           color: lightColorPalette.whiteColorPrimary.shade900,
        //           shape: BoxShape.circle,
        //           boxShadow: [
        //             BoxShadow(
        //               blurRadius: 0,
        //               spreadRadius: 0,
        //               offset: const Offset(0, 1),
        //               color: lightColorPalette.black,
        //             )
        //           ],
        //         ),
        //       ),
        //     ),
        //     Center(
        //       child: Container(
        //         height: 50.h,
        //         width: 50.w,
        //         decoration: BoxDecoration(
        //           color: lightColorPalette.black,
        //           shape: BoxShape.circle,
        //         ),
        //         child: Center(
        //           child: AssetWidget(
        //             color: lightColorPalette.whiteColorPrimary.shade900,
        //             asset: Asset(type: AssetType.svg, path: ImageResource.cid),
        //             boxFit: BoxFit.fitWidth,
        //           ),
        //         ),
        //       ),
        //     )
        //   ],
        // ),

        Center(
          child: AssetWidget(
            color: lightColorPalette.whiteColorPrimary.shade900,
            asset: Asset(
                type: AssetType.svg, path: ImageResource.inspectionsDoctor),
            boxFit: BoxFit.fitWidth,
          ),
        ),
      ],
    );
  }

  Widget showLanguageSelection() {
    return dropdownField(
        isError: controller.languageError.value,
        errorMsg: controller.languageErrorMessage.value,
        hint: AppStrings.selectLanguage.tr,
        title: AppStrings.selectLanguage.tr,
        selectedValue: controller.selectedBaseMaterialDropDown.value,
        onClick: (DropdownModel value) {
          controller.onSelectBaseMaterialDropdown(value: value);
          controller.languageError.value = false;
        },
        list: controller.languageList,
        isExpanded: true);
  }
}
