import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/app_common_dropdown_date_picker.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/app_common_text_form_field.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/app_text_widget.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/common_button.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/common_dropdown_button.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/custom_icon_button.dart';
import 'package:inspection_doctor_homeowner/core/constants/app_strings.dart';
import 'package:inspection_doctor_homeowner/core/constants/common_strings.dart';
import 'package:inspection_doctor_homeowner/core/theme/app_color_palette.dart';
import 'package:inspection_doctor_homeowner/core/utils/enum.dart';
import 'package:inspection_doctor_homeowner/core/utils/image_resources.dart';
import 'package:inspection_doctor_homeowner/features/signup/presentation/screens/signup_screen.dart';

extension SignupScreenExtension on SignupScreen {
  addSignupButton() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CommonButton(
            commonButtonBottonText: AppStrings.back.tr,
            bgColor: lightColorPalette.whiteColorPrimary.shade900,
            minWidth: 100.w,
            style: lightTextTheme.bodyLarge?.copyWith(
                fontSize: 14.sp,
                fontFamily: CommonStrings.vitnamPro,
                fontWeight: FontWeight.w600,
                color: lightColorPalette.additionalSwatch1.shade600),
            isIconEnable: true,
            image: ImageResource.backArrow,
            type: ShowImagePositionAt.left,
            onPress: () {
              Get.back();
            },
          ),
          CommonButton(
            commonButtonBottonText: AppStrings.continueStr.tr,
            bgColor: lightColorPalette.secondarySwatch.shade900,
            minWidth: 100.w,
            style: lightTextTheme.bodyLarge?.copyWith(
                fontSize: 14.sp,
                fontFamily: CommonStrings.vitnamPro,
                fontWeight: FontWeight.w600,
                color: lightColorPalette.whiteColorPrimary.shade900),
            isIconEnable: true,
            image: ImageResource.forwardArrow,
            type: ShowImagePositionAt.right,
            onPress: () {
              controller.createAccount();
            },
          ),
        ],
      ).paddingOnly(left: 5.w, right: 5.w),
    );
  }

  createAnAccountTitleWidget() {
    return Align(
        alignment: Alignment.topLeft,
        child: AppTextWidget(
          text: AppStrings.createAnAccount.tr,
          style: lightTextTheme.bodyLarge?.copyWith(
            fontSize: 24.sp,
            color: lightColorPalette.whiteColorPrimary.shade900,
            fontWeight: FontWeight.w600,
          ),
        ));
  }

  emailTextfieldWidget() {
    return AppTextFormField(
      focusNode: controller.emailFocusNode,
      controller: controller.emailController,
      keyboardType: TextInputType.emailAddress,
      isCheckValidation: controller.emailError.value,
      validationMsg: AppStrings.emailWarning2.tr,
      // labelText: AppStrings.email.tr,
      hintText: AppStrings.hintEmail.tr,
      onChanged: (email) {
        controller.onChangedEmailTextfield(value: email);
      },
      errorBool: controller.emailError.value,
    );
  }

  passwordTextfieldWidget() {
    return AppTextFormField(
      focusNode: controller.createPasswordFocusNode,
      maxLines: 1,
      controller: controller.createPasswordController,
      keyboardType: TextInputType.text,
      obscureText: controller.isVisibleCreatePassword.value,
      isCheckValidation: controller.showPasswordError.value,
      validationMsg: AppStrings.pleaseEnterAValidPassword.tr,
      // labelText: AppStrings.createPassword.tr,
      hintText: AppStrings.createPassword.tr,
      suffixIcon: CustomIconButton(
        onPressed: () {
          controller.onPressCreatePasswordEyeIcon();
        },
        icon: Icon(
          controller.isVisibleCreatePassword.value == true
              ? Icons.visibility_off
              : Icons.remove_red_eye,
          color: lightColorPalette.additionalSwatch1.shade900,
        ),
      ),
      onChanged: (password) {
        controller.onChangedCreatePasswordTextfield(value: password);
      },
      errorBool: controller.showPasswordError.value,
    );
  }

  confirmPasswordTextfieldWidget() {
    return AppTextFormField(
      focusNode: controller.confirmPasswordFocusNode,
      maxLines: 1,
      obscureText: controller.isVisibleConfirmPassword.value,
      controller: controller.confirmPasswordController,
      keyboardType: TextInputType.text,
      isCheckValidation: controller.showConfirmPasswordError.value,
      validationMsg: AppStrings.createPasswordORConfirmPasswordMustBeSame.tr,
      //labelText: AppStrings.confirmPassword.tr,
      hintText: AppStrings.confirmPassword.tr,
      suffixIcon: CustomIconButton(
        onPressed: () {
          controller.onPressConfirmPasswordEyeIcon();
        },
        icon: Icon(
          controller.isVisibleConfirmPassword.value == true
              ? Icons.visibility_off
              : Icons.remove_red_eye,
          color: lightColorPalette.additionalSwatch1.shade900,
        ),
      ),
      onChanged: (confirmPassword) {
        controller.onChangedConfirmPasswordTextfield(value: confirmPassword);
      },
    );
  }

  dateOfBirthDropdownWidget() {
    return AppDateTimeDropdown(
      isCheckYearValidation: controller.isBirthValidations.value,
      isCheckMonthValidation: controller.isBirthValidations.value,
      isCheckDayValidation: controller.isBirthValidations.value,
      keyboardType: TextInputType.text,
      validationMsg: AppStrings.pleaseSelectYourDateOfBirth.tr,
      onSelectDay: (value) {
        print(value);
        controller.setDOBDay(value: value);
      },
      onSelectMonth: (value) {
        print(value);

        controller.setMonthDay(value: value);
      },
      onSelectYear: (value) {
        print(value);

        controller.setYearDay(value: value);
      },
    );
    // dropdownField(
    //     title: AppStrings.age.tr,
    //     hint: AppStrings.selectAge.tr,
    //     isMandatory: true,
    //     isCheckValidation:
    //         controller.isAgeValidations.value,
    //     validationMsg: AppStrings.pleaseSelectYourAge.tr,
    //     onClick: (DropdownModel value) {
    //       controller.onClickAgeDropdown(value: value);
    //     },
    //     selectedValue:
    //         controller.selectedAgeDropDown.value,
    //     list: controller.ageList.value,
    //     isExpanded: true),
  }

  genderDropdownWidget() {
    return dropdownField(
        hint: AppStrings.selectgender.tr,
        isMandatory: true,
        isCheckValidation: controller.isGenderValidations.value,
        validationMsg: AppStrings.pleaseSelectYourGender.tr,
        onClick: (DropdownModel value) {
          controller.onClickGenderDropdown(value: value);
        },
        selectedValue: controller.selectedGenderDropDown.value,
        list: controller.genderList.value,
        isExpanded: true);
  }

  countryDropdownWidget() {
    return dropdownField(
        hint: AppStrings.selectCountry.tr,
        isMandatory: true,
        isCheckValidation: controller.isCountryValidations.value,
        validationMsg: AppStrings.pleaseSelectYourCountry.tr,
        onClick: (DropdownModel value) {
          controller.onClickCountryDropdown(value: value);
        },
        selectedValue: controller.selectedCountryDropDown.value,
        list: controller.countryList.value,
        isExpanded: true);
  }

  stateDropdownWidget() {
    return dropdownField(
        hint: AppStrings.selectStateorProviance.tr,
        isMandatory: true,
        isCheckValidation: controller.isstateValidations.value,
        validationMsg: AppStrings.pleaseSelectYourState.tr,
        onClick: (DropdownModel value) {
          controller.onClickStateDropdown(value: value);
        },
        selectedValue: controller.selectedStateDropDown.value,
        list: controller.stateList.value,
        isExpanded: true);
  }

  cityDropdownWidget() {
    return dropdownField(
        hint: AppStrings.selectCity.tr,
        isMandatory: true,
        isCheckValidation: controller.iscityValidations.value,
        validationMsg: AppStrings.pleaseSelectYourCity.tr,
        onClick: (DropdownModel value) {
          controller.onClickCityDropdown(value: value);
        },
        selectedValue: controller.selectedCityDropDown.value,
        list: controller.cityList.value,
        isExpanded: true);
  }

  termAndConditionWidget() {
    return Row(
      children: [
        // Center(
        //   child: Container(
        //           height: 21.h,
        //           width: 21.w,
        //     color: Colors.white,
        //     child: Center(
        //       child: Checkbox(
        //         value: controller.isAcceptTermAndCond.value,
        //         onChanged: (newValue) async {
        //
        //         },
        //         activeColor:Colors.red,
        //         checkColor: Colors.grey,
        //       ),
        //     ),
        //   ),
        // )
        Center(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(6.r),
            child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6.r),
                    color: Colors.white,
                    border: Border.all(
                        color: lightColorPalette.secondarySwatch.shade900)),
                height: 22.h,
                width: 22.w,
                child: Transform.scale(
                  scale: 1.4,
                  child: Checkbox(
                    // fillColor: MaterialStateProperty.resolveWith((Set<MaterialState> states) {
                    //   if (states.contains(MaterialState.selected)) {
                    //     return Colors.green;
                    //   }
                    //   return Colors.white;
                    // }),
                    checkColor: lightColorPalette.whiteColorPrimary.shade900,
                    activeColor: lightColorPalette.secondarySwatch.shade900,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                    side: BorderSide(width: 1.0.w, color: Colors.transparent),
                    value: controller.isAcceptTermAndCond.value,
                    onChanged: (value) {
                      controller.isAcceptTermAndCond.value = value!;
                    },
                  ),
                )),
          ),
        ),
        SizedBox(
          width: 8.w,
        ),
        Expanded(
          child: Text.rich(
            TextSpan(
              text: AppStrings.readAndAgree.tr,
              style: lightTextTheme.titleSmall?.copyWith(
                  color: lightColorPalette.whiteColorPrimary.shade900,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  fontFamily: CommonStrings.vitnamPro),
              children: [
                TextSpan(
                  text: AppStrings.privacyPolicy.tr,
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      controller.onTapPrivacyPolicy();
                    },
                  style: lightTextTheme.titleSmall?.copyWith(
                      decoration: TextDecoration.underline,
                      color: lightColorPalette.whiteColorPrimary.shade600,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      fontFamily: CommonStrings.vitnamPro),
                ),
                TextSpan(
                  text: AppStrings.and.tr,
                  style: lightTextTheme.titleSmall?.copyWith(
                      color: lightColorPalette.whiteColorPrimary.shade900,
                      fontSize: 14.sp,
                      fontFamily: CommonStrings.vitnamPro),
                ),
                TextSpan(
                    text: AppStrings.termAndConditionDot.tr,
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        controller.onTapTermAndConditions();
                      },
                    style: lightTextTheme.titleSmall?.copyWith(
                        decoration: TextDecoration.underline,
                        color: lightColorPalette.whiteColorPrimary.shade600,
                        fontWeight: FontWeight.w400,
                        fontSize: 14.sp,
                        fontFamily: CommonStrings.vitnamPro))
              ],
            ),
          ).paddingOnly(left: 6.w, right: 2.w),
        )
      ],
    );
  }
}
