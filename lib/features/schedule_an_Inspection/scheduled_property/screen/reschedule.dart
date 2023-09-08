import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/asset_widget/common_image_widget.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/common_button/common_button.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/common_button/custom_icon_button.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/text/app_text_widget.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/textfields/app_common_text_form_field.dart';
import 'package:inspection_doctor_homeowner/core/constants/app_strings.dart';
import 'package:inspection_doctor_homeowner/core/date_formatter/date_formatter.dart';
import 'package:inspection_doctor_homeowner/core/theme/app_color_palette.dart';
import 'package:inspection_doctor_homeowner/core/utils/image_resources.dart';
import 'package:inspection_doctor_homeowner/features/schedule_an_Inspection/scheduled_property/screen/Inspection_detail_screen.dart';

extension RescheduleFormExtension on InspectionDetailScreen {
  Future<dynamic> showRescheduleForm() {
    return Get.bottomSheet(
        isDismissible: true,
        isScrollControlled: true,
        Wrap(children: [
          Obx(() => Container(
              height: 0.87.sh,
              decoration: BoxDecoration(
                color: lightColorPalette.whiteColorPrimary.shade900,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.r),
                    topRight: Radius.circular(20.r)),
              ),
              child: Column(
                children: [
                  SizedBox(height: 22.h),
                  Stack(
                    children: [
                      CustomInkwell(
                          padding: EdgeInsets.only(left: 20.w),
                          onTap: () {
                            Get.back();
                          },
                          child: AssetWidget(
                            color: lightColorPalette.black,
                            asset: Asset(
                                type: AssetType.svg,
                                path: ImageResource.backArrow),
                            boxFit: BoxFit.fitWidth,
                          )),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AppTextWidget(
                            text: AppStrings.reschedule.tr,
                            style: CustomTextTheme.heading2(
                              color: lightColorPalette.black,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  SizedBox(height: 22.h),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(children: [
                        getDateTimeView(),
                        getDescriptionView(),
                        getContactInformation(),
                        submitRescheduleInspectionButtonWidget(),
                        SizedBox(
                          height: 50.h,
                        )
                      ]).paddingSymmetric(horizontal: 0.w),
                    ),
                  ),
                ],
              )))
        ]));
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

  Widget getDescriptionView() {
    return commonTextFieldWidget(
      height: 88.h,
      maxLines: 5,
      textCapitalization: TextCapitalization.sentences,
      focusNode: controller.descriptionFocusNode.value,
      controller: controller.descriptionController.value,
      title: AppStrings.description.tr,
      hint: AppStrings.description.tr,
      maxLength: 300,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter(RegExp("[a-zA-Z " "]"), allow: true),
      ],
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

  Align showSelectedTime() {
    return Align(
      alignment: Alignment.topLeft,
      child: Obx(() => Wrap(
            spacing: 5.w,
            children: List.generate(
                controller.selectedTime.length,
                (index) => Chip(
                      deleteIconColor: lightColorPalette.redDark,
                      onDeleted: () {
                        controller.selectedTime.removeAt(index);
                      },
                      label: AppTextWidget(
                        textAlign: TextAlign.start,
                        text: controller.selectedTime[index].name,
                        style: CustomTextTheme.bottomTabsithFontWeight600(
                            color: lightColorPalette.grey),
                      ),
                    )),
          )),
    );
  }

  Widget submitRescheduleInspectionButtonWidget() {
    return CommonButton(
            style: CustomTextTheme.buttonText(
              color: lightColorPalette.whiteColorPrimary.shade900,
            ),
            bgColor: lightColorPalette.black,
            commonButtonBottonText: AppStrings.submitAndNotify.tr,
            onPress: controller.isEnable
                ? () {
                    controller.onPressRescheduleSubmitButton();
                  }
                : null)
        .paddingSymmetric(horizontal: 20.w);
  }
}
