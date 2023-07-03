import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:inspection_doctor_homeowner/core/common_functionality/dismiss_keyboard.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/textfields/app_common_text_form_field.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/text/app_text_widget.dart';

import 'package:inspection_doctor_homeowner/core/common_ui/app_bar/common_appbar.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/common_button/common_button.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/asset_widget/common_image_widget.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/common_button/custom_icon_button.dart';
import 'package:inspection_doctor_homeowner/core/constants/app_strings.dart';
import 'package:inspection_doctor_homeowner/core/routes/routes.dart';
import 'package:inspection_doctor_homeowner/core/theme/app_color_palette.dart';
import 'package:inspection_doctor_homeowner/core/utils/image_resources.dart';
import 'package:inspection_doctor_homeowner/features/login_signup_process/signup/controller/signup_controller.dart';

class SignupScreen extends GetView<SignupController> {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightColorPalette.backgroundColor,
      appBar: commonAppBar(
          title: AppStrings.signup.tr,
          leading: CustomInkwell(
              onTap: () {
                Get.back();
              },
              child: AssetWidget(
                asset:
                    Asset(type: AssetType.svg, path: ImageResource.backArrow),
                boxFit: BoxFit.fitWidth,
              ))),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Obx(() => Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  showHeadingText(),
                  Column(
                    children: [
                      showFirstNameField().paddingOnly(bottom: 11.h),
                      showLastNameField().paddingOnly(bottom: 11.h),
                      showEmailField().paddingOnly(bottom: 11.h),
                      showPhoneNumberField().paddingOnly(bottom: 11.h),
                      showPasswordField().paddingOnly(bottom: 11.h),
                      showConfirmPasswordField().paddingOnly(bottom: 11.h),
                      showMailingAddress(),
                      showStreetField().paddingOnly(bottom: 11.h),
                      showCityField().paddingOnly(bottom: 11.h),
                      showStateField().paddingOnly(bottom: 11.h),
                      showZipCodeField(),
                      showSignUpButton().paddingOnly(top: 40.h),
                      showLoginOption().paddingOnly(top: 30.h, bottom: 39.h)
                    ],
                  ).paddingSymmetric(horizontal: 20.w),
                ],
              )),
        ),
      ),
    );
  }

  Row showMailingAddress() {
    return Row(
      children: [
        AppTextWidget(
          style:
              CustomTextTheme.normalText(color: lightColorPalette.primaryGrey),
          text: AppStrings.mailingAddress.tr,
        ).paddingOnly(top: 30.h, bottom: 15.h),
      ],
    );
  }

  Row showLoginOption() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        AppTextWidget(
          style:
              CustomTextTheme.normalText(color: lightColorPalette.primaryGrey),
          text: AppStrings.alreadyAccount.tr,
        ),
        CustomInkwell(
          padding: EdgeInsets.zero,
          onTap: () {
            dismissKeyboard();
            Get.back();
          },
          child: AppTextWidget(
            style: CustomTextTheme.normalText(
                color: lightColorPalette.primaryBlue),
            text: AppStrings.login.tr,
          ),
        ),
      ],
    );
  }

  CommonButton showSignUpButton() {
    return CommonButton(
        commonButtonBottonText: AppStrings.signup.tr,
        onPress: () {
          dismissKeyboard();
          Get.toNamed(Routes.otpVerifyScreen);
        });
  }

  Column showHeadingText() {
    return Column(
      children: [
        Center(
          child: AppTextWidget(
            text: AppStrings.registerStarted.tr,
            style: CustomTextTheme.heading1(
              color: lightColorPalette.primaryDarkblue,
            ),
          ),
        ).paddingOnly(top: 22.h, bottom: 10.h,left: 20.w, right: 20.w,),
        Center(
          child: AppTextWidget(
            textAlign: TextAlign.center,
            text: AppStrings.fillDetail,
            style: CustomTextTheme.normalText(
              color: lightColorPalette.primaryGrey,
            ),
          ),
        ).paddingOnly(left: 20.w, right: 20.w, bottom: 30.h),
      ],
    );
  }

  Widget showFirstNameField() {
    return commonTextFieldWidget(
      focusNode: controller.firstNameFocusNode.value,
      controller: controller.firstNameController,
      title: AppStrings.firstName.tr,
      hint: AppStrings.firstName.tr,
      keyboardType: TextInputType.name,
      textInputAction: TextInputAction.next,
      onChanged: (value) {},
    );
  }

  Widget showLastNameField() {
    return commonTextFieldWidget(
      focusNode: controller.lastNameFocusNode.value,
      controller: controller.lastNameController,
      title: AppStrings.lastName.tr,
      hint: AppStrings.lastName.tr,
      keyboardType: TextInputType.name,
      textInputAction: TextInputAction.next,
      onChanged: (value) {},
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

  Widget showPhoneNumberField() {
    return commonPhoneText(
      focusNode: controller.phoneNumberFocusNode.value,
      controller: controller.phoneNumberController,
      title: AppStrings.phoneNumber.tr,
      hint: AppStrings.phoneNumber.tr,
      keyboardType: TextInputType.number,
      textInputAction: TextInputAction.next,
      onChanged: (value) {},
      countryCode: controller.selectedCountryCode.value,
      onSelect: (Country country) {
        controller.selectedCountryCode.value = country.phoneCode;
      },
    );
  }

  Widget showPasswordField() {
    return commonPasswordText(
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

  Widget showConfirmPasswordField() {
    return commonPasswordText(
      focusNode: controller.confirmPasswordFocusNode.value,
      controller: controller.confirmPasswordController,
      title: AppStrings.confirmPassword.tr,
      hint: AppStrings.confirmPassword.tr,
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

  Widget showStreetField() {
    return commonTextFieldWidget(
      focusNode: controller.streetFocusNode.value,
      controller: controller.streetController,
      title: AppStrings.street.tr,
      hint: AppStrings.street.tr,
      keyboardType: TextInputType.streetAddress,
      textInputAction: TextInputAction.next,
      onChanged: (value) {},
    );
  }

  Widget showCityField() {
    return commonTextFieldWidget(
      focusNode: controller.cityFocusNode.value,
      controller: controller.cityController,
      title: AppStrings.city.tr,
      hint: AppStrings.city.tr,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      onChanged: (value) {},
    );
  }

  Widget showStateField() {
    return commonTextFieldWidget(
      focusNode: controller.stateFocusNode.value,
      controller: controller.stateController,
      title: AppStrings.state.tr,
      hint: AppStrings.state.tr,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      onChanged: (value) {},
    );
  }

  Widget showZipCodeField() {
    return commonTextFieldWidget(
      focusNode: controller.zipCodeFocusNode.value,
      controller: controller.zipCodeController,
      title: AppStrings.zipCode.tr,
      hint: AppStrings.zipCode.tr,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      onChanged: (value) {},
    );
  }
}
