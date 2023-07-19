import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:inspection_doctor_homeowner/core/common_functionality/dismiss_keyboard.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/app_bar/common_appbar.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/asset_widget/common_image_widget.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/common_button/common_button.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/common_button/custom_icon_button.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/common_loader/common_loader.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/text/app_text_widget.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/textfields/app_common_text_form_field.dart';
import 'package:inspection_doctor_homeowner/core/constants/app_strings.dart';
import 'package:inspection_doctor_homeowner/core/routes/routes.dart';
import 'package:inspection_doctor_homeowner/core/theme/app_color_palette.dart';
import 'package:inspection_doctor_homeowner/core/utils/image_resources.dart';
import 'package:inspection_doctor_homeowner/features/login_signup_process/signup/controller/signup_controller.dart';
import 'package:keyboard_actions/keyboard_actions.dart';

class SignupScreen extends GetView<SignupController> {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightColorPalette.backgroundColor,
      appBar: commonAppBarWithElevation(
        title: AppStrings.signup.tr,
        onPressBackButton: () {
          Get.back();
        },
      ),
      body: SafeArea(
        child: Obx(() => Stack(
              children: [
                KeyboardActions(
                    config: controller.buildConfig(context),
                    child: SingleChildScrollView(
                      child: Column(
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
                              showConfirmPasswordField()
                                  .paddingOnly(bottom: 11.h),
                              showMailingAddress(),
                              showStreetField().paddingOnly(bottom: 11.h),
                              showCityField().paddingOnly(bottom: 11.h),
                              showStateField().paddingOnly(bottom: 11.h),
                              showZipCodeField(),
                              showSignUpButton().paddingOnly(top: 40.h),
                              showLoginOption()
                                  .paddingOnly(top: 30.h, bottom: 40.h),
                            ],
                          ).paddingSymmetric(horizontal: 20.w),
                        ],
                      ),
                    )),
                CommonLoader(isLoading: controller.isShowLoader.value)
              ],
            )),
      ),
    );
  }

  showMailingAddress() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        AppTextWidget(
          style:
              CustomTextTheme.normalText(color: lightColorPalette.primaryGrey),
          text: AppStrings.mailingAddress.tr,
        ),

        // choose map button
        getChooseMapButton()
      ],
    ).paddingOnly(top: 30.h, bottom: 15.h);
  }

  getChooseMapButton() {
    return CustomInkwell(
      onTap: () {
        Get.toNamed(Routes.chooseMap);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 7.h),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4.r),
            border:
                Border.all(color: lightColorPalette.primaryBlue, width: 0.3)),
        child: Row(
          children: [
            AssetWidget(
              asset: Asset(
                type: AssetType.svg,
                path: ImageResource.map,
              ),
            ).paddingOnly(right: 4.w),
            AppTextWidget(
              style: CustomTextTheme.bottomTabsithFontWeight600(
                  color: lightColorPalette.primaryBlue),
              text: AppStrings.chooseOnMap.tr,
            )
          ],
        ),
      ),
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
            style: CustomTextTheme.normalTextWithWeight600(
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
          controller.onTapSignButton();
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
        ).paddingOnly(
          top: 22.h,
          bottom: 10.h,
          left: 20.w,
          right: 20.w,
        ),
        Center(
          child: AppTextWidget(
            textAlign: TextAlign.center,
            text: AppStrings.fillDetail,
            style: CustomTextTheme.normalText(
              color: lightColorPalette.primaryGrey,
            ),
          ),
        ).paddingOnly(left: 20.w, right: 20.w, bottom: 0.h),
      ],
    );
  }

  Widget showFirstNameField() {
    return commonTextFieldWidget(
      textCapitalization: TextCapitalization.sentences,
      focusNode: controller.firstNameFocusNode.value,
      isError: controller.firstNameError.value,
      errorMsg: controller.firstNameErrorMessage.value,
      controller: controller.firstNameController,
      title: AppStrings.firstName.tr,
      hint: AppStrings.firstName.tr,
      maxLength: 30,
      keyboardType: TextInputType.name,
      textInputAction: TextInputAction.next,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter(RegExp("[a-zA-Z " "]"), allow: true),
      ],
      onChanged: (value) {
        controller.onChangedFirstNameTextField(value: value);
      },
    );
  }

  Widget showLastNameField() {
    return commonTextFieldWidget(
      textCapitalization: TextCapitalization.sentences,
      focusNode: controller.lastNameFocusNode.value,
      controller: controller.lastNameController,
      isError: controller.lastNameError.value,
      errorMsg: controller.lastNameErrorMessage.value,
      title: AppStrings.lastName.tr,
      hint: AppStrings.lastName.tr,
      keyboardType: TextInputType.name,
      maxLength: 30,
      textInputAction: TextInputAction.next,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter(RegExp("[a-zA-Z " "]"), allow: true),
      ],
      onChanged: (value) {
        controller.onChangedLastNameTextField(value: value);
      },
    );
  }

  Widget showEmailField() {
    return commonTextFieldWidget(
      focusNode: controller.emailFocusNode.value,
      controller: controller.emailController,
      isError: controller.emailError.value,
      errorMsg: controller.emailErrorMessage.value,
      maxLength: 50,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.deny(RegExp(r'[ ]')),
      ],
      onChanged: (value) {
        controller.onChangedEmailTextField(value: value);
      },
      title: AppStrings.email.tr,
      hint: AppStrings.email.tr,
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
    );
  }

  Widget showPhoneNumberField() {
    return commonPhoneText(
      focusNode: controller.phoneNumberFocusNode.value,
      controller: controller.phoneNumberController,
      title: AppStrings.phoneNumber.tr,
      hint: AppStrings.phoneNumber.tr,
      isError: controller.phoneError.value,
      errorMsg: controller.phoneErrorMessage.value,
      keyboardType: TextInputType.number,
      textInputAction: TextInputAction.next,
      onChanged: (value) {
        controller.onChangedPhoneTextField(value: value);
      },
      countryCode: controller.selectedCountryCode.value,
      onSelect: (Country country) {
        controller.onSelectCountryCode(country: country);
      },
    );
  }

  Widget showPasswordField() {
    return commonPasswordText(
      focusNode: controller.passwordFocusNode.value,
      controller: controller.passwordController,
      title: AppStrings.loginScreenPassword.tr,
      hint: AppStrings.loginScreenPassword.tr,
      isError: controller.passwordError.value,
      errorMsg: controller.passwordErrorMessage.value,
      keyboardType: TextInputType.visiblePassword,
      textInputAction: TextInputAction.next,
      onChanged: (value) {
        controller.onChangedPasswordTextField(value: value);
      },
      onPress: () {
        controller.onPressPasswordEyeIcon();
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
      isError: controller.confirmPasswordError.value,
      errorMsg: controller.confirmPasswordErrorMessage.value,
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

  Widget showStreetField() {
    return commonTextFieldWidget(
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter(RegExp("[a-zA-Z " "]"), allow: true),
      ],
      textCapitalization: TextCapitalization.sentences,
      focusNode: controller.streetFocusNode.value,
      controller: controller.streetController,
      title: AppStrings.street.tr,
      maxLength: 30,
      hint: AppStrings.street.tr,
      keyboardType: TextInputType.streetAddress,
      textInputAction: TextInputAction.next,
      onChanged: (value) {
        if (value.length == 1 && value.contains(" ")) {
          controller.streetController.text =
              controller.streetController.text.trim();
        }
      },
    );
  }

  Widget showCityField() {
    return commonTextFieldWidget(
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter(RegExp("[a-zA-Z " "]"), allow: true),
      ],
      textCapitalization: TextCapitalization.sentences,
      focusNode: controller.cityFocusNode.value,
      controller: controller.cityController,
      title: AppStrings.city.tr,
      maxLength: 30,
      hint: AppStrings.city.tr,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      onChanged: (value) {
        if (value.length == 1 && value.contains(" ")) {
          controller.cityController.text =
              controller.cityController.text.trim();
        }
      },
    );
  }

  Widget showStateField() {
    return commonTextFieldWidget(
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter(RegExp("[a-zA-Z " "]"), allow: true),
      ],
      textCapitalization: TextCapitalization.sentences,
      focusNode: controller.stateFocusNode.value,
      controller: controller.stateController,
      title: AppStrings.state.tr,
      hint: AppStrings.state.tr,
      maxLength: 30,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      onChanged: (value) {
        if (value.length == 1 && value.contains(" ")) {
          controller.stateController.text =
              controller.stateController.text.trim();
        }
      },
    );
  }

  Widget showZipCodeField() {
    return commonTextFieldWidget(
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      focusNode: controller.zipCodeFocusNode.value,
      controller: controller.zipCodeController,
      title: AppStrings.zipCode.tr,
      hint: AppStrings.zipCode.tr,
      maxLength: 5,
      keyboardType: TextInputType.number,
      textInputAction: TextInputAction.next,
      onChanged: (value) {},
    );
  }
}
