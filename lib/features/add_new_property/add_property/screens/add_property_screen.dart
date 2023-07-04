import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/app_bar/common_appbar.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/text/app_text_widget.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/textfields/app_common_text_form_field.dart';
import 'package:inspection_doctor_homeowner/core/constants/app_strings.dart';
import 'package:inspection_doctor_homeowner/core/theme/app_color_palette.dart';
import 'package:inspection_doctor_homeowner/features/add_new_property/add_property/controller/add_property_controller.dart';

class AddPropertyScreen extends GetView<AddPropertyController> {
  const AddPropertyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightColorPalette.whiteColorPrimary.shade900,
      appBar: commonAppBarWithElevation(
          title: AppStrings.addProperty.tr,
          onPressBackButton: () {
            Get.back();
          }),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Obx(() => Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      showPropertyNameField()
                          .paddingOnly(bottom: 11.h, top: 20.h),
                      showStreetNameField().paddingOnly(bottom: 11.h),
                      showCityField().paddingOnly(bottom: 11.h),
                      showStateField().paddingOnly(bottom: 11.h),
                      showZipCodeField().paddingOnly(bottom: 11.h),
                      showPermitNumberield().paddingOnly(bottom: 11.h),
                      showLotNumberField().paddingOnly(bottom: 11.h),
                      showBlockNumberField().paddingOnly(bottom: 11.h),
                      dropdownField(
                          selectedValue: selectedValue,
                          onClick: (DropdownModel value) {},
                          list: list)
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

  Widget showPropertyNameField() {
    return commonTextFieldWidget(
      focusNode: controller.propertyFocusNode.value,
      controller: controller.propertyController,
      title: AppStrings.propertyNameNickName.tr,
      hint: AppStrings.propertyNameNickName.tr,
      keyboardType: TextInputType.name,
      textInputAction: TextInputAction.next,
      onChanged: (value) {},
    );
  }

  Widget showStreetNameField() {
    return commonTextFieldWidget(
      focusNode: controller.streetFocusNode.value,
      controller: controller.streetController,
      title: AppStrings.street.tr,
      hint: AppStrings.street.tr,
      keyboardType: TextInputType.name,
      textInputAction: TextInputAction.next,
      onChanged: (value) {},
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

  Widget showPermitNumberield() {
    return commonTextFieldWidget(
      focusNode: controller.permitNumberFocusNode.value,
      controller: controller.permitNumberController,
      title: AppStrings.permitNumber.tr,
      hint: AppStrings.permitNumber.tr,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      onChanged: (value) {},
    );
  }

  Widget showLotNumberField() {
    return commonTextFieldWidget(
      focusNode: controller.lotNumberFocusNode.value,
      controller: controller.lotNumberController,
      title: AppStrings.lotNumber.tr,
      hint: AppStrings.lotNumber.tr,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      onChanged: (value) {},
    );
  }

  Widget showBlockNumberField() {
    return commonTextFieldWidget(
      focusNode: controller.blockNumberFocusNode.value,
      controller: controller.blockNumberController,
      title: AppStrings.blockNumber.tr,
      hint: AppStrings.blockNumber.tr,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      onChanged: (value) {},
    );
  }
}
