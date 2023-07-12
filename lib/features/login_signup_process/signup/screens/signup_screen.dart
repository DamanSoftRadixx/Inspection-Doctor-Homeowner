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
import 'package:inspection_doctor_homeowner/core/theme/app_color_palette.dart';
import 'package:inspection_doctor_homeowner/core/utils/image_resources.dart';
import 'package:inspection_doctor_homeowner/core/utils/ui_utils.dart';
import 'package:inspection_doctor_homeowner/features/login_signup_process/signup/controller/signup_controller.dart';
import 'package:keyboard_actions/keyboard_actions.dart';

class SignupScreen extends GetView<SignupController> {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: lightColorPalette.backgroundColor,
        appBar: commonAppBarWithElevation(
          onPressBackButton: () {
            Get.back();
          },
          title: AppStrings.signup.tr,
        ),
        body: Obx(
          () => Stack(
            children: [
              KeyboardActions(
                config: controller.buildConfig(context),
                child: SafeArea(
                    child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      showHeadingText(),
                      Column(
                        children: [
                          uploadPhotoWidget()
                              .paddingOnly(top: 30.h, bottom: 30.h),
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
                  ),
                )),
              ),
              disableScreen(isDisable: controller.isShowLoader.value),
              CommonLoader(isLoading: controller.isShowLoader.value)
            ],
          ),
        ));
  }

  Widget uploadPhotoWidget() {
    return Obx(() => controller.selectedProfile.isEmpty
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 60.h,
                width: 60.w,
                decoration: BoxDecoration(
                    color: lightColorPalette.primaryBlue,
                    borderRadius: BorderRadius.circular(4.r)),
                child: Center(
                  child: AssetWidget(
                    asset: Asset(
                        type: AssetType.svg, path: ImageResource.uploadPhoto),
                  ),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              GestureDetector(
                onTap: () {
                  // controller.onTapUploadOrRemovePhoto();
                },
                child: AppTextWidget(
                  textAlign: TextAlign.start,
                  text: AppStrings.uploadPhoto.tr,
                  style: CustomTextTheme.normalText(
                    color: lightColorPalette.primaryDarkblue,
                  ),
                ),
              )
            ],
          )
        : Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 60.h,
                width: 60.w,
                decoration: BoxDecoration(
                  border: Border.all(color: lightColorPalette.primaryBlue),
                  borderRadius: BorderRadius.all(Radius.circular(4.r)),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(4.r)),
                  child: AssetWidget(
                    asset: Asset(
                        type: AssetType.network,
                        path: "https://picsum.photos/id/237/200/300"),
                    height: 56.h,
                    boxFit: BoxFit.fill,
                    width: 56.w,
                  ),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              GestureDetector(
                onTap: () {
                  // controller.onTapUploadOrRemovePhoto();
                },
                child: AppTextWidget(
                  textAlign: TextAlign.start,
                  text: AppStrings.removePhoto.tr,
                  style: CustomTextTheme.normalText(
                    color: lightColorPalette.redDark,
                  ),
                ),
              )
            ],
          ));
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
        ).paddingOnly(left: 20.w, right: 20.w, bottom: 30.h),
      ],
    );
  }

  Widget showFirstNameField() {
    return commonTextFieldWidget(
      textCapitalization: TextCapitalization.sentences,
      isError: controller.firstNameError.value,
      errorMsg: controller.firstNameErrorMessage.value,
      focusNode: controller.firstNameFocusNode.value,
      controller: controller.firstNameController,
      title: AppStrings.firstName.tr,
      hint: AppStrings.firstName.tr,
      keyboardType: TextInputType.name,
      textInputAction: TextInputAction.next,
      onChanged: (value) {
        if (value.isNotEmpty) {
          controller.firstNameError.value = false;
        }
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
      textInputAction: TextInputAction.next,
      onChanged: (value) {
        if (value.isNotEmpty) {
          controller.lastNameError.value = false;
        }
      },
    );
  }

  Widget showEmailField() {
    return commonTextFieldWidget(
      isError: controller.emailError.value,
      errorMsg: controller.emailErrorMessage.value,
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
    );
  }

  Widget showPhoneNumberField() {
    return commonPhoneText(
      onChanged: (value) {
        if (controller.phoneNumberController.text.length > 8) {
          controller.phoneError.value = false;
        }
      },
      isError: controller.phoneError.value,
      errorMsg: controller.phoneErrorMessage.value,
      focusNode: controller.phoneNumberFocusNode.value,
      controller: controller.phoneNumberController,
      title: AppStrings.phoneNumber.tr,
      hint: AppStrings.phoneNumber.tr,
      keyboardType: TextInputType.number,
      textInputAction: TextInputAction.next,
      countryCode: controller.selectedCountryCode.value,
      onSelect: (Country country) {
        controller.selectedCountryCode.value = country.phoneCode;
      },
    );
  }

  Widget showPasswordField() {
    return commonPasswordText(
      isError: controller.passwordError.value,
      errorMsg: controller.passwordErrorMessage.value,
      focusNode: controller.passwordFocusNode.value,
      controller: controller.passwordController,
      title: AppStrings.loginScreenPassword.tr,
      hint: AppStrings.loginScreenPassword.tr,
      keyboardType: TextInputType.visiblePassword,
      textInputAction: TextInputAction.next,
      onChanged: (value) {
        if (value.isNotEmpty) {
          if (!(controller.passwordController.text.length < 8 ||
              controller.passwordController.text.contains(RegExp(r'[A-Z]')) ==
                  false ||
              controller.passwordController.text.contains(RegExp(r'[a-z]')) ==
                  false)) {
            controller.passwordError.value = false;
          }
        }
      },
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
      isError: controller.confirmPasswordError.value,
      errorMsg: controller.confirmPasswordErrorMessage.value,
      focusNode: controller.confirmPasswordFocusNode.value,
      controller: controller.confirmPasswordController,
      title: AppStrings.confirmpassword.tr,
      hint: AppStrings.confirmpassword.tr,
      keyboardType: TextInputType.visiblePassword,
      textInputAction: TextInputAction.next,
      onChanged: (value) {
        if (value.isNotEmpty &&
            (controller.passwordController.text ==
                controller.confirmPasswordController.text)) {
          controller.confirmPasswordError.value = false;
        }
      },
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
      textCapitalization: TextCapitalization.sentences,
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
      textCapitalization: TextCapitalization.sentences,
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
      textCapitalization: TextCapitalization.sentences,
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
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      focusNode: controller.zipCodeFocusNode.value,
      controller: controller.zipCodeController,
      title: AppStrings.zipCode.tr,
      hint: AppStrings.zipCode.tr,
      keyboardType: TextInputType.number,
      textInputAction: TextInputAction.next,
      onChanged: (value) {},
    );
  }
}
