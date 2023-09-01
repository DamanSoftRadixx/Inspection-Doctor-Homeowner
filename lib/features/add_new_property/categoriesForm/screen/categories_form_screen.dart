import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:inspection_doctor_homeowner/core/common_functionality/dismiss_keyboard.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/app_bar/common_appbar.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/common_button/common_button.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/common_loader/common_loader.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/text/app_text_widget.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/textfields/app_common_text_form_field.dart';
import 'package:inspection_doctor_homeowner/core/constants/app_strings.dart';
import 'package:inspection_doctor_homeowner/core/date_formatter/date_formatter.dart';
import 'package:inspection_doctor_homeowner/core/theme/app_color_palette.dart';
import 'package:inspection_doctor_homeowner/features/add_new_property/categoriesForm/controller/categories_form_controller.dart';

class CategoryFormScreen extends GetView<CategoryFormController> {
  const CategoryFormScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightColorPalette.whiteColorPrimary.shade900,
      appBar: commonAppBarWithElevation(
          title: AppStrings.schedule.tr,
          onPressBackButton: () {
            Get.back();
          }),
      body: Obx(() => InkWell(
            focusColor: Colors.transparent,
            hoverColor: Colors.transparent,
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: () {
              dismissKeyboard();
            },
            child: SafeArea(
              child: Stack(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              getCategoryView(),
                              Divider(
                                  thickness: 10.h,
                                  color: lightColorPalette.greyBg),
                              getFormFillDetail().paddingAll(20.r),
                              getDateTimeView(),
                              getDescriptionView(),
                              getContactInformation(),
                            ],
                          ),
                        ),
                      ),
                      showContinueButton()
                    ],
                  ),
                  CommonLoader(isLoading: controller.isShowLoader.value)
                ],
              ),
            ),
          )),
    );
  }

  Widget getDescriptionView() {
    return commonTextFieldWidget(
      height: 88.h,
      maxLines: 5,
      textCapitalization: TextCapitalization.sentences,
      focusNode: controller.descriptionFocusNode.value,
      controller: controller.descriptionController.value,
      title: AppStrings.description.tr,
      hint: AppStrings.description.tr,
      maxLength: 500,
      keyboardType: TextInputType.name,
      textInputAction: TextInputAction.next,
      // inputFormatters: <TextInputFormatter>[
      //   FilteringTextInputFormatter(RegExp("[a-zA-Z0-9 " "]"), allow: true),
      // ],
      onChanged: (value) {
        controller.onChangedDescriptionField(value: value);
      },
    ).paddingSymmetric(horizontal: 20.w);
  }

  getDateTimeView() {
    return Column(
      children: [
        commonDatePicker(
                title: AppStrings.date.tr,
                isShowStar: true,
                onPicked: (DateTime value) {
                  if (value != "") {
                    controller.selectedDate.value =
                        getDDMMYYYFormet(date: value);
                    controller.selectedDate.refresh();
                  }
                },
                selectedDate: controller.selectedDate.value.toString())
            .paddingOnly(bottom: 11.h),
        multiDropdownField(
                hint: AppStrings.time.tr,
                title: AppStrings.time.tr,
                isShowStar: true,
                selectedValue: controller.selectTime.value,
                onClick: (DropdownModel value) {
                  controller.onSelectTimeDropdown(value: value);
                },
                list: controller.timeList,
                isExpanded: true,
                selectedItems: controller.selectedTime)
            .paddingOnly(bottom: 5.h),
        showSelectedTime(),
      ],
    ).paddingSymmetric(horizontal: 20.w);
  }

  getContactInformation() {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: AppTextWidget(
            textAlign: TextAlign.start,
            text: AppStrings.contactPersonInformation.tr,
            style: CustomTextTheme.normalText(color: lightColorPalette.grey),
          ),
        ),
        showFirstNameField().paddingOnly(top: 15.h, bottom: 11.h),
        showLastNameField().paddingOnly(bottom: 11.h),
        showEmailField().paddingOnly(bottom: 11.h),
        showPhoneNumberField().paddingOnly(bottom: 11.h),
      ],
    ).paddingSymmetric(horizontal: 20.w, vertical: 20.h);
  }

  Align showSelectedTime() {
    return Align(
      alignment: Alignment.topLeft,
      child: Wrap(
        spacing: 5.w,
        children: List.generate(
            controller.selectedTime.length,
            (index) => controller.selectedTime[index].id == "0"
                ? const SizedBox()
                : Chip(
                    deleteIconColor: lightColorPalette.redDark,
                    onDeleted: () {
                      controller.removeTime(index);
                    },
                    label: AppTextWidget(
                      textAlign: TextAlign.start,
                      text: controller.selectedTime[index].name,
                      style: CustomTextTheme.bottomTabsithFontWeight600(
                          color: lightColorPalette.grey),
                    ),
                  )),
      ),
    );
  }

  AppTextWidget getFormFillDetail() {
    return AppTextWidget(
      textAlign: TextAlign.start,
      text: AppStrings.fillCategoryForm.tr,
      style: CustomTextTheme.normalText(
        color: lightColorPalette.grey,
      ),
    );
  }

  getCategoryView() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppTextWidget(
            textAlign: TextAlign.start,
            text: controller.argData.value.categoriesName ?? "",
            style: CustomTextTheme.heading3(
              color: lightColorPalette.black,
            ),
          ).paddingOnly(bottom: 10.h),
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.r),
                border: Border.all(color: lightColorPalette.grey, width: 0.3)),
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 13.h),
            child: AppTextWidget(
              textAlign: TextAlign.center,
              text: controller.argData.value.subCategoriesName ?? "",
              style: CustomTextTheme.categoryText(
                color: lightColorPalette.black,
              ),
            ),
          ),
        ],
      ).paddingSymmetric(horizontal: 20.w, vertical: 20.h),
    );
  }

  Widget showContinueButton() {
    return CommonButton(
            commonButtonBottonText: AppStrings.schedule.tr,
            onPress: controller.isScheduleButtonEnable()
                ? () {
                    controller.onPressContinueButton();
                  }
                : null)
        .paddingOnly(left: 20.w, right: 20.w, bottom: 17.h);
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
      isShowStar: true,
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
      isShowStar: true,
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
      isShowStar: true,
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
      isShowStar: true,
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
}
