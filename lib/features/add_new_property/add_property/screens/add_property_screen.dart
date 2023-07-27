import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:get/get.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/app_bar/common_appbar.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/asset_widget/common_image_widget.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/common_button/common_button.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/common_button/custom_icon_button.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/common_loader/common_loader.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/document_picker/common_document_picker.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/text/app_text_widget.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/textfields/app_common_text_form_field.dart';
import 'package:inspection_doctor_homeowner/core/constants/app_strings.dart';
import 'package:inspection_doctor_homeowner/core/theme/app_color_palette.dart';
import 'package:inspection_doctor_homeowner/core/utils/image_resources.dart';
import 'package:inspection_doctor_homeowner/features/add_new_property/add_property/controller/add_property_controller.dart';
import 'package:keyboard_actions/keyboard_actions.dart';

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
          child: Obx(
        () => Stack(
          children: [
            KeyboardActions(
                config: controller.buildConfig(context),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        getChooseMapButton().paddingOnly(top: 20.h),
                        showPropertyNameField()
                            .paddingOnly(bottom: 11.h, top: 20.h),
                        showStreetNameField().paddingOnly(bottom: 11.h),
                        showCityField().paddingOnly(bottom: 11.h),
                        showStateField().paddingOnly(bottom: 11.h),
                        showZipCodeField().paddingOnly(bottom: 11.h),
                        showPermitNumberield().paddingOnly(bottom: 11.h),
                        showLotNumberField().paddingOnly(bottom: 11.h),
                        showBlockNumberField().paddingOnly(bottom: 11.h),
                        showCountyDropDown().paddingOnly(bottom: 11.h),
                        showAddDocmentBox(),
                        showAddPropertyButton()
                            .paddingSymmetric(vertical: 20.h),
                      ],
                    ).paddingSymmetric(horizontal: 20.w),
                  ],
                )),
            CommonLoader(isLoading: controller.isShowLoader.value)
          ],
        ),
      )),
    );
  }

  Widget showAddDocmentBox() {
    return Obx(() => GestureDetector(
          onTap: () async {
            if (controller.pdfFile.value.path.isEmpty) {
              await controller.onTapUploadPDF();
            }
          },
          child: commonDocumentPicker(
              isError: controller.documentError.value,
              errorMsg: controller.documentErrorMessage.value,
              title: AppStrings.uploadArchitecturalDrawing.tr,
              text: AppStrings.uploadAPdf.tr,
              isFilePick: controller.pdfFile.value.path.isNotEmpty,
              widget: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: AssetWidget(
                      asset:
                          Asset(type: AssetType.svg, path: ImageResource.pdf),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                        onTap: () {
                          controller.pdfFile.value = File("");
                        },
                        child: const Icon(
                          FontAwesome5.trash_alt,
                          color: Colors.black,
                          size: 20,
                        )

                        //  AssetWidget(
                        //   asset: Asset(
                        //       type: AssetType.svg,
                        //       path: ImageResource.deleteButton),
                        // ),
                        ),
                  ),
                ],
              )),
        ));
  }

  Widget getChooseMapButton() {
    return CustomInkwell(
      padding: EdgeInsets.zero,
      onTap: () {
        controller.onTapChooseButton();
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 7.h),
        decoration: BoxDecoration(
            // color: lightColorPalette.backgroundColor,
            borderRadius: BorderRadius.circular(4.r),
            border: Border.all(color: lightColorPalette.black, width: 0.3)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
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

  CommonButton showAddPropertyButton() {
    return CommonButton(
        commonButtonBottonText: controller.isPropertyDetailEdit.value
            ? AppStrings.updateProperty.tr
            : AppStrings.addPropertyButton.tr,
        onPress: controller.isAppPropertyButtonEnable
            ? () {
                controller.onPressAddPropertyButton();
              }
            : null);
  }

  Widget showCountyDropDown() {
    return dropdownField(
        isError: controller.countyError.value,
        errorMsg: controller.countyErrorMessage.value,
        hint: AppStrings.county.tr,
        title: AppStrings.county.tr,
        selectedValue: controller.selectedBaseMaterialDropDown.value,
        onClick: (DropdownModel value) {
          controller.onSelectBaseMaterialDropdown(value: value);
          controller.countyError.value = false;
        },
        list: controller.countiesList,
        isExpanded: true);
  }

  Row showMailingAddress() {
    return Row(
      children: [
        AppTextWidget(
          style: CustomTextTheme.normalText(color: lightColorPalette.grey),
          text: AppStrings.mailingAddress.tr,
        ).paddingOnly(top: 30.h, bottom: 15.h),
      ],
    );
  }

  Widget showPropertyNameField() {
    return commonTextFieldWidget(
      maxLength: 30,
      textCapitalization: TextCapitalization.sentences,
      isError: controller.propertyNameError.value,
      errorMsg: controller.propertyNameErrorMessage.value,
      focusNode: controller.propertyFocusNode.value,
      controller: controller.propertyController.value,
      title: AppStrings.propertyNameNickName.tr,
      hint: AppStrings.propertyNameNickName.tr,
      keyboardType: TextInputType.name,
      textInputAction: TextInputAction.next,
      onChanged: (value) {
        controller.onChangedPropertyNameTextField(value: value);
      },
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter(RegExp("[a-zA-Z " "]"), allow: true),
      ],
    );
  }

  Widget showStreetNameField() {
    return commonTextFieldWidget(
      readOnly: controller.place.value.address.isNotEmpty,
      textCapitalization: TextCapitalization.sentences,
      maxLength: 30,
      isError: controller.streetError.value,
      errorMsg: controller.streetErrorMessage.value,
      focusNode: controller.place.value.address.isNotEmpty
          ? FocusNode()
          : controller.streetFocusNode.value,
      controller: controller.streetController.value,
      title: AppStrings.street.tr,
      hint: AppStrings.street.tr,
      keyboardType: TextInputType.name,
      textInputAction: TextInputAction.next,
      onChanged: (value) {
        controller.onChangedStreetTextField(value: value);
      },
    );
  }

  Widget showCityField() {
    return commonTextFieldWidget(
      readOnly: controller.place.value.city.isNotEmpty,
      maxLength: 20,
      textCapitalization: TextCapitalization.sentences,
      isError: controller.cityError.value,
      errorMsg: controller.cityErrorMessage.value,
      focusNode: controller.place.value.city.isNotEmpty
          ? FocusNode()
          : controller.cityFocusNode.value,
      controller: controller.cityController.value,
      title: AppStrings.city.tr,
      hint: AppStrings.city.tr,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      onChanged: (value) {
        controller.onChangedCityTextField(value: value);
      },
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter(RegExp("[a-zA-Z " "]"), allow: true),
      ],
    );
  }

  Widget showStateField() {
    return commonTextFieldWidget(
      focusNode: controller.place.value.state.isNotEmpty
          ? FocusNode()
          : controller.stateFocusNode.value,
      readOnly: controller.place.value.state.isNotEmpty,
      maxLength: 20,
      textCapitalization: TextCapitalization.sentences,
      isError: controller.stateError.value,
      errorMsg: controller.stateErrorMessage.value,
      controller: controller.stateController.value,
      title: AppStrings.state.tr,
      hint: AppStrings.state.tr,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      onChanged: (value) {
        controller.onChangedStateTextField(value: value);
      },
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter(RegExp("[a-zA-Z " "]"), allow: true),
      ],
    );
  }

  Widget showZipCodeField() {
    return commonTextFieldWidget(
      focusNode: controller.place.value.zipCode.isNotEmpty
          ? FocusNode()
          : controller.zipCodeFocusNode.value,
      readOnly: controller.place.value.zipCode.isNotEmpty,
      maxLength: 5,
      isError: controller.zipCodeError.value,
      errorMsg: controller.zipCodeErrorMessage.value,
      controller: controller.zipCodeController.value,
      title: AppStrings.zipCode.tr,
      hint: AppStrings.zipCode.tr,
      keyboardType: TextInputType.number,
      textInputAction: TextInputAction.next,
      onChanged: (value) {
        controller.onChangedZipCodeTextField(value: value);
      },
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.digitsOnly,
      ],
    );
  }

  Widget showPermitNumberield() {
    return commonTextFieldWidget(
      textCapitalization: TextCapitalization.words,
      isError: controller.permitNumberError.value,
      errorMsg: controller.permitNumberErrorMessage.value,
      focusNode: controller.permitNumberFocusNode.value,
      controller: controller.permitNumberController.value,
      title: AppStrings.permitNumber.tr,
      hint: AppStrings.permitNumber.tr,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      onChanged: (value) {
        controller.onChangedPermitNumberTextField(value: value);
      },
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9]')),
      ],
    );
  }

  Widget showLotNumberField() {
    return commonTextFieldWidget(
      maxLength: 15,
      isError: controller.lotNumberError.value,
      errorMsg: controller.lotNumberErrorMessage.value,
      focusNode: controller.lotNumberFocusNode.value,
      controller: controller.lotNumberController.value,
      title: AppStrings.lotNumber.tr,
      hint: AppStrings.lotNumber.tr,
      keyboardType: TextInputType.number,
      textInputAction: TextInputAction.next,
      onChanged: (value) {
        controller.onChangedLotNumberTextField(value: value);
      },
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.digitsOnly,
      ],
    );
  }

  Widget showBlockNumberField() {
    return commonTextFieldWidget(
      maxLength: 15,
      isError: controller.blockNumberError.value,
      errorMsg: controller.blockNumberErrorMessage.value,
      focusNode: controller.blockNumberFocusNode.value,
      controller: controller.blockNumberController.value,
      title: AppStrings.blockNumber.tr,
      hint: AppStrings.blockNumber.tr,
      keyboardType: TextInputType.number,
      textInputAction: TextInputAction.next,
      onChanged: (value) {
        controller.onChangedBlocTextField(value: value);
      },
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.digitsOnly,
      ],
    );
  }
}
