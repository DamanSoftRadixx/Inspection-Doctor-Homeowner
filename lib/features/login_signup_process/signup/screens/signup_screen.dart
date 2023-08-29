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

class SignupScreen extends GetView<SignupController> {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightColorPalette.whiteColorPrimary.shade900,
      appBar: commonAppBarWithElevation(
        title: AppStrings.signup.tr,
        onPressBackButton: () {
          Get.back();
        },
        centerWidget: const SizedBox(),
      ),
      body: SafeArea(
        child: Obx(() => Stack(
              children: [
                SingleChildScrollView(
                  controller: controller.scrollController.value,
                  child: InkWell(
                    focusColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () {
                      dismissKeyboard();
                      controller.predictionsList.value = [];
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        getTopLogo(),
                        showHeadingText(),
                        Column(
                          children: [
                            showLanguageSelection().paddingOnly(bottom: 11.h),
                            showFirstNameField().paddingOnly(bottom: 11.h),
                            showLastNameField().paddingOnly(bottom: 11.h),
                            showEmailField().paddingOnly(bottom: 11.h),
                            showPhoneNumberField().paddingOnly(bottom: 11.h),
                            showPasswordField().paddingOnly(bottom: 11.h),
                            showConfirmPasswordField()
                                .paddingOnly(bottom: 11.h),
                            showMailingAddress(),
                            showStreetAddress1Field().paddingOnly(bottom: 11.h),
                            showGoogleAddressBar(),
                            showStreetAddress2Field().paddingOnly(bottom: 11.h),
                            showCityField().paddingOnly(bottom: 11.h),
                            showStateSelection().paddingOnly(bottom: 11.h),
                            showZipCodeField(),
                            showSignUpButton().paddingOnly(top: 40.h),
                            showLoginOption()
                                .paddingOnly(top: 30.h, bottom: 40.h),
                          ],
                        ).paddingSymmetric(horizontal: 20.w),
                      ],
                    ),
                  ),
                ),
                CommonLoader(isLoading: controller.isShowLoader.value)
              ],
            )),
      ),
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

  showMailingAddress() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        AppTextWidget(
          style: CustomTextTheme.normalText(color: lightColorPalette.grey),
          text: AppStrings.mailingAddress.tr,
        ),

        // choose map button
        // getChooseMapButton(),
      ],
    ).paddingOnly(top: 30.h, bottom: 15.h);
  }

  getChooseMapButton() {
    return CustomInkwell(
      padding: EdgeInsets.zero,
      onTap: () async {
        if (await checkForLocationPermissions()) {
          controller.onTapChooseButton();
        }
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 7.h),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.r),
            border: Border.all(color: lightColorPalette.black, width: 0.3)),
        child: Row(
          children: [
            AssetWidget(
              color: lightColorPalette.black,
              asset: Asset(
                type: AssetType.svg,
                path: ImageResource.map,
              ),
            ).paddingOnly(right: 4.w),
            AppTextWidget(
              style: CustomTextTheme.bottomTabsithFontWeight600(
                  color: lightColorPalette.black),
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
          style: CustomTextTheme.normalText(color: lightColorPalette.grey),
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
                color: lightColorPalette.black),
            text: AppStrings.login.tr,
          ),
        ),
      ],
    );
  }

  CommonButton showSignUpButton() {
    return CommonButton(
        commonButtonBottonText: AppStrings.signup.tr,
        onPress: controller.isSignUpButtonEnable()
            ? () {
                controller.onTapSignButton();
              }
            : null);
  }

  Column showHeadingText() {
    return Column(
      children: [
        Center(
          child: AppTextWidget(
            text: AppStrings.registerStarted.tr,
            style: CustomTextTheme.heading1(
              color: lightColorPalette.black,
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
            text: AppStrings.fillDetail.tr,
            style: CustomTextTheme.normalText(
              color: lightColorPalette.grey,
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
      controller: controller.firstNameController.value,
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
      controller: controller.lastNameController.value,
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
      controller: controller.emailController.value,
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
      controller: controller.phoneNumberController.value,
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
      controller: controller.passwordController.value,
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
      controller: controller.confirmPasswordController.value,
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

  Widget showStreetAddress1Field() {
    return commonTextFieldWidget(
      // readOnly: controller.place.value.address1.isNotEmpty,
      focusNode: controller.address1FocusNode.value,

      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter(RegExp("[a-zA-Z0-9]"), allow: true),
      ],
      textCapitalization: TextCapitalization.sentences,
      // focusNode: controller.streetFocusNode.value,
      controller: controller.streetAddress1Controller.value,
      title: AppStrings.address_line_1.tr,
      maxLength: 30,
      hint: AppStrings.address_line_1.tr,
      keyboardType: TextInputType.streetAddress,
      textInputAction: TextInputAction.next,
      onChanged: (value) {
        if (value.length == 1 && value.contains(" ")) {
          controller.streetAddress1Controller.value.text =
              controller.streetAddress1Controller.value.text.trim();
        }
        controller.showAddressList(value: value);
      },
    );
  }

  showGoogleAddressBar() {
    return Visibility(
      visible: controller.predictionsList.isNotEmpty,
      child: Stack(
        children: [
          Card(
            elevation: 5,
            color: lightColorPalette.whiteColorPrimary.shade900,
            child: Container(
              constraints: const BoxConstraints(maxHeight: 300),
              child: ListView.builder(
                padding: EdgeInsets.only(top: 15.h),
                shrinkWrap: true,
                itemCount: controller.predictionsList.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    horizontalTitleGap: 5,
                    leading: SizedBox(
                      height: 30.h,
                      width: 30.w,
                      child: CircleAvatar(
                        backgroundColor: lightColorPalette.greenDark,
                        child: Icon(
                          Icons.pin_drop,
                          color: lightColorPalette.whiteColorPrimary.shade900,
                          size: 15.r,
                        ),
                      ),
                    ),
                    title: AppTextWidget(
                      text: controller.predictionsList[index].description ?? "",
                      style: CustomTextTheme.normalText(
                        color: lightColorPalette.black,
                      ),
                    ),
                    onTap: () async {
                      await controller.onAddressSelection(index: index);
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget showStreetAddress2Field() {
    return commonTextFieldWidget(
      // readOnly: controller.place.value.address2.isNotEmpty,
      focusNode: controller.address2FocusNode.value,

      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter(RegExp("[a-zA-Z0-9]"), allow: true),
      ],
      textCapitalization: TextCapitalization.sentences,
      // focusNode: controller.streetFocusNode.value,
      controller: controller.streetAddress2Controller.value,
      title: AppStrings.address_line_2.tr,
      maxLength: 30,
      hint: AppStrings.address_line_2.tr,
      keyboardType: TextInputType.streetAddress,
      textInputAction: TextInputAction.done,
      onChanged: (value) {
        if (value.length == 1 && value.contains(" ")) {
          controller.streetAddress2Controller.value.text =
              controller.streetAddress2Controller.value.text.trim();
        }
      },
    );
  }

  Widget showCityField() {
    return commonTextFieldWidget(
      focusNode: controller.place.value.city.isNotEmpty
          ? FocusNode()
          : controller.cityFocusNode.value,
      readOnly: controller.place.value.city.isNotEmpty,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter(RegExp("[a-zA-Z " "]"), allow: true),
      ],
      textCapitalization: TextCapitalization.sentences,
      // focusNode: controller.cityFocusNode.value,
      controller: controller.cityController.value,
      title: AppStrings.city.tr,
      maxLength: 30,
      hint: AppStrings.city.tr,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      onChanged: (value) {
        if (value.length == 1 && value.contains(" ")) {
          controller.cityController.value.text =
              controller.cityController.value.text.trim();
        }
      },
    );
  }

  // Widget showStateField() {
  //   return commonTextFieldWidget(
  //     focusNode: controller.place.value.state.isNotEmpty
  //         ? FocusNode()
  //         : controller.stateFocusNode.value,
  //     readOnly: controller.place.value.state.isNotEmpty,

  //     textCapitalization: TextCapitalization.sentences,
  //     // focusNode: controller.stateFocusNode.value,
  //     controller: controller.stateController.value,
  //     title: AppStrings.state.tr,
  //     hint: AppStrings.state.tr,
  //     maxLength: 30,
  //     inputFormatters: <TextInputFormatter>[
  //       FilteringTextInputFormatter(RegExp("[a-zA-Z " "]"), allow: true),
  //     ],
  //     keyboardType: TextInputType.text,
  //     textInputAction: TextInputAction.next,
  //     onChanged: (value) {
  //       if (value.length == 1 && value.contains(" ")) {
  //         controller.stateController.value.text =
  //             controller.stateController.value.text.trim();
  //       }
  //     },
  //   );
  // }

  Widget showZipCodeField() {
    return commonTextFieldWidget(
      focusNode: controller.place.value.zipCode.isNotEmpty
          ? FocusNode()
          : controller.zipCodeFocusNode.value,
      readOnly: controller.place.value.zipCode.isNotEmpty,

      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      // focusNode: controller.zipCodeFocusNode.value,
      controller: controller.zipCodeController.value,
      title: AppStrings.zipCode.tr,
      hint: AppStrings.zipCode.tr,
      maxLength: 5,
      keyboardType: TextInputType.number,
      textInputAction: TextInputAction.next,
      onChanged: (value) {},
    );
  }

  Widget showStateSelection() {
    return dropdownField(
        isDisable: false,
        isError: controller.stateError.value,
        errorMsg: controller.stateErrorMessage.value,
        hint: AppStrings.selectState.tr,
        title: AppStrings.selectState.tr,
        selectedValue: controller.selectedStateDropDown.value,
        onClick: (DropdownModel value) {
          controller.onSelectStateStateDropdown(value: value);
          controller.stateError.value = false;
        },
        list: controller.stateList,
        isExpanded: true);
  }
}
