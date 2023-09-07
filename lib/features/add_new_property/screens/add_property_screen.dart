import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:get/get.dart';
import 'package:inspection_doctor_homeowner/core/common_functionality/dismiss_keyboard.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/app_bar/common_appbar.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/asset_widget/common_image_widget.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/common_button/common_button.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/common_loader/common_loader.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/document_picker/common_document_picker.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/text/app_text_widget.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/textfields/app_common_text_form_field.dart';
import 'package:inspection_doctor_homeowner/core/constants/app_strings.dart';
import 'package:inspection_doctor_homeowner/core/theme/app_color_palette.dart';
import 'package:inspection_doctor_homeowner/core/utils/image_resources.dart';
import 'package:inspection_doctor_homeowner/features/add_new_property/add_property/controller/add_property_controller.dart';

class AddPropertyScreen extends GetView<AddPropertyController> {
  const AddPropertyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => WillPopScope(
        onWillPop: () async => controller.isShowLoader.value ? false : true,
        child: Scaffold(
            backgroundColor: lightColorPalette.whiteColorPrimary.shade900,
            appBar: commonAppBarWithElevation(
                title: AppStrings.addProperty.tr,
                onPressBackButton: () {
                  controller.isShowLoader.value ? () {} : Get.back();
                }),
            body: InkWell(
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
                    SingleChildScrollView(
                      controller: controller.scrollController.value,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Column(
                            children: [
                              /*controller.isAddressNotAssigned.value
                                  ? const SizedBox()
                                  : getChooseMapButton().paddingOnly(top: 20.h),*/
                              showPropertyNameField()
                                  .paddingOnly(bottom: 11.h, top: 20.h),
                              isShowAddressNotAssign(
                                  text: AppStrings.addressNotAssigned.tr,
                                  isSelected:
                                      controller.isAddressNotAssigned.value,
                                  onTap: () {
                                    controller.onTapAddressNotAssign();
                                  }).paddingOnly(bottom: 11.h),
                              controller.isAddressNotAssigned.value
                                  ? const SizedBox()
                                  : Column(
                                      children: [
                                        showAddress1Field()
                                            .paddingOnly(bottom: 11.h),
                                        showGoogleAddressBar(),
                                        showAddress2Field()
                                            .paddingOnly(bottom: 11.h),
                                      ],
                                    ),
                              showCityField().paddingOnly(bottom: 11.h),
                              showStateSelection().paddingOnly(bottom: 11.h),
                              showZipCodeField().paddingOnly(bottom: 11.h),
                              // showPermitNumberield().paddingOnly(bottom: 11.h),
                              showLotNumberField().paddingOnly(bottom: 11.h),
                              showBlockNumberField().paddingOnly(bottom: 11.h),
                              showCountyDropDown().paddingOnly(bottom: 11.h),
                              showAddDocmentBox(),
                              showAddPropertyButton()
                                  .paddingSymmetric(vertical: 20.h),
                            ],
                          ).paddingSymmetric(horizontal: 20.w),
                        ],
                      ),
                    ),
                    CommonLoader(isLoading: controller.isShowLoader.value)
                  ],
                ),
              ),
            )),
      ),
    );
  }

  Widget isShowAddressNotAssign(
      {required String text,
      required bool isSelected,
      required Function() onTap}) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Align(
        alignment: Alignment.centerLeft,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 2.h),
              child: isSelected
                  ? AssetWidget(
                      color: Colors.green,
                      asset: Asset(
                          type: AssetType.svg,
                          path: ImageResource.selectedCheckbox),
                    )
                  : AssetWidget(
                      asset: Asset(
                          type: AssetType.svg,
                          path: ImageResource.unSelectedCheckbox),
                    ),
            ),
            SizedBox(
              width: 10.w,
            ),
            Flexible(
                child: AppTextWidget(
              textAlign: TextAlign.start,
              text: text,
              style: CustomTextTheme.normalTextWithLineHeight20(
                color: lightColorPalette.grey,
              ),
            )),
          ],
        ),
      ),
    );
  }

  Widget showAddress2Field() {
    return commonTextFieldWidget(
      // readOnly: controller.streetAddress2Controller.value.text.isNotEmpty,
      focusNode: controller.street2FocusNode.value,

      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter(RegExp("[a-zA-Z " "]"), allow: true),
      ],
      textCapitalization: TextCapitalization.sentences,
      // focusNode: controller.streetFocusNode.value,
      controller: controller.streetAddress2Controller.value,
      title: AppStrings.address_line_2.tr,
      maxLength: 30,
      hint: AppStrings.address_line_2.tr,
      keyboardType: TextInputType.streetAddress,
      textInputAction: TextInputAction.next,
      onChanged: (value) {
        if (value.length == 1 && value.contains(" ")) {
          controller.streetAddress2Controller.value.text =
              controller.streetAddress2Controller.value.text.trim();
        }
      },
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
              isShowStar: true,
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
                        child: Icon(
                          FontAwesome5.trash_alt,
                          color: lightColorPalette.black,
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

  // Widget getChooseMapButton() {
  //   return CustomInkwell(
  //     padding: EdgeInsets.zero,
  //     onTap: () async {
  //       if (await checkForLocationPermissions()) {
  //         controller.onTapChooseButton();
  //       }
  //     },
  //     child: Container(
  //       padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 7.h),
  //       decoration: BoxDecoration(
  //           // color: lightColorPalette.backgroundColor,
  //           borderRadius: BorderRadius.circular(4.r),
  //           border: Border.all(color: lightColorPalette.black, width: 0.3)),
  //       child: Row(
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         children: [
  //           AssetWidget(
  //             color: lightColorPalette.black,
  //             asset: Asset(
  //               type: AssetType.svg,
  //               path: ImageResource.map,
  //             ),
  //           ).paddingOnly(right: 4.w),
  //           AppTextWidget(
  //             style: CustomTextTheme.bottomTabsithFontWeight600(
  //                 color: lightColorPalette.black),
  //             text: AppStrings.chooseOnMap.tr,
  //           )
  //         ],
  //       ),
  //     ),
  //   );
  // }

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
    return InkWell(
      focusColor: Colors.transparent,
      hoverColor: Colors.transparent,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () {
        controller.getCounties();
      },
      child: IgnorePointer(
        ignoring: controller.countiesList.isEmpty,
        child: dropdownField(
            isShowStar: true,
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
            isExpanded: true),
      ),
    );
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
      isShowStar: true,
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
        FilteringTextInputFormatter(RegExp("[a-zA-Z0-9 " "]"), allow: true),
      ],
    );
  }

  Widget showAddress1Field() {
    return commonTextFieldWidget(
      isShowStar: true,
      textCapitalization: TextCapitalization.sentences,
      maxLength: 30,
      isError: controller.streetError.value,
      errorMsg: controller.streetErrorMessage.value,
      focusNode: controller.streetFocusNode.value,
      controller: controller.streetAddress1Controller.value,
      title: AppStrings.address_line_1.tr,
      hint: AppStrings.address_line_1.tr,
      keyboardType: TextInputType.name,
      textInputAction: TextInputAction.next,
      onChanged: (value) {
        controller.onChangedAddress1TextField(value: value);
        controller.showAddressList(value: value);
      },
    );
  }

  Widget showPlotNumberField() {
    return commonTextFieldWidget(
      isShowStar: true,
      // readOnly: controller.streetAddress1Controller.value.text.isNotEmpty,
      textCapitalization: TextCapitalization.sentences,
      maxLength: 30,
      isError: controller.plotError.value,
      errorMsg: controller.plotErrorMessage.value,
      focusNode: controller.plotNoFocusNode.value,
      controller: controller.plotNumberController.value,
      title: AppStrings.plotNumber.tr,
      hint: AppStrings.plotNumber.tr,
      keyboardType: TextInputType.number,
      textInputAction: TextInputAction.next,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter(RegExp("[0-9]"), allow: true),
      ],
      onChanged: (value) {
        controller.onChangedPlotNoTextField(value: value);
      },
    );
  }

  Widget showCityField() {
    return commonTextFieldWidget(
      isShowStar: true,
      // readOnly: controller.cityController.value.text.isNotEmpty,
      maxLength: 20,
      textCapitalization: TextCapitalization.sentences,
      isError: controller.cityError.value,
      errorMsg: controller.cityErrorMessage.value,
      focusNode: controller.cityFocusNode.value,
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
      isShowStar: true,
      focusNode: controller.zipCodeFocusNode.value,
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

  // Widget showPermitNumberield() {
  //   return commonTextFieldWidget(
  //     isShowStar: true,
  //     textCapitalization: TextCapitalization.words,
  //     isError: controller.permitNumberError.value,
  //     errorMsg: controller.permitNumberErrorMessage.value,
  //     focusNode: controller.permitNumberFocusNode.value,
  //     controller: controller.permitNumberController.value,
  //     title: AppStrings.permitNumber.tr,
  //     hint: AppStrings.permitNumber.tr,
  //     keyboardType: TextInputType.text,
  //     textInputAction: TextInputAction.next,
  //     onChanged: (value) {
  //       controller.onChangedPermitNumberTextField(value: value);
  //     },
  //     inputFormatters: <TextInputFormatter>[
  //       FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9]')),
  //     ],
  //   );
  // }

  Widget showLotNumberField() {
    return commonTextFieldWidget(
      isShowStar: true,
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
      isShowStar: true,
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

  Widget showStateSelection() {
    return InkWell(
      focusColor: Colors.transparent,
      hoverColor: Colors.transparent,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () {
        controller.getStateListApi();
      },
      child: IgnorePointer(
        ignoring: controller.stateList.isEmpty,
        child: dropdownField(
            isShowStar: true,
            isDisable: true,
            // isError: controller.languageError.value,
            // errorMsg: controller.languageErrorMessage.value,
            hint: AppStrings.selectState.tr,
            title: AppStrings.selectState.tr,
            selectedValue: controller.selectedStateDropDown.value,
            onClick: (DropdownModel value) {
              // controller.onSelectBaseMaterialDropdown(value: value);
              // controller.languageError.value = false;
            },
            list: controller.stateList,
            isExpanded: true),
      ),
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
}
