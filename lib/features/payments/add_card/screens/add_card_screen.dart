import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/app_bar/common_appbar.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/common_button/common_button.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/common_loader/common_loader.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/textfields/app_common_text_form_field.dart';
import 'package:inspection_doctor_homeowner/core/constants/app_strings.dart';
import 'package:inspection_doctor_homeowner/core/theme/app_color_palette.dart';
import 'package:inspection_doctor_homeowner/features/payments/add_card/controller/add_card_controller.dart';

class AddPaymentCardScreen extends GetView<AddCardController> {
  const AddPaymentCardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightColorPalette.whiteColorPrimary.shade900,
      appBar: commonAppBarWithElevation(
          title: AppStrings.addCard.tr,
          onPressBackButton: () {
            controller.isShowLoader.value ? () {} : Get.back();
          }),
      body: SafeArea(
          child: Obx(() => Stack(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // showCardNumberField(),
                      // Row(
                      //   children: [
                      //     Expanded(flex: 3, child: showExpriyNumberField()),
                      //     SizedBox(width: 14.w),
                      //     Expanded(flex: 2, child: showCVVNumberField())
                      //   ],
                      // ),

                      CardFormField(
                        controller: controller.cardFormEditController,
                        enablePostalCode: true,
                        countryCode: 'US',
                        style: CardFormStyle(
                          borderColor: lightColorPalette.grey,
                          borderWidth: 1,
                          borderRadius: 10,
                          textColor: lightColorPalette.black,
                          fontSize: 20,
                          backgroundColor:
                              lightColorPalette.whiteColorPrimary.shade900,
                          cursorColor: lightColorPalette.black,
                          placeholderColor: lightColorPalette.grey,
                          textErrorColor: lightColorPalette.red,
                        ),
                        autofocus: true,
                        onCardChanged: (card) {
                          log("adfsdssdf $card");
                          controller.card.value = card ??
                              const CardFieldInputDetails(complete: false);
                        },
                      ).paddingOnly(top: 30.h, bottom: 20.h),
                      showAddCardButton()
                    ],
                  ).paddingSymmetric(horizontal: 20.w),
                  CommonLoader(isLoading: controller.isShowLoader.value)
                ],
              ))),
    );
  }

  Widget showCardNumberField() {
    return commonTextFieldWidget(
      focusNode: controller.cardNode.value,
      controller: controller.debitCardController.value,
      isError: controller.isCardValid.value,
      errorMsg: controller.cardErrorMessage.value,
      title: AppStrings.cardNumber.tr,
      hint: placeHolder.enterCardNumber.tr,
      maxLength: 19,
      keyboardType: TextInputType.number,
      textInputAction: TextInputAction.next,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
      ],
      onChanged: (value) {
        controller.onChangeCardTextField(value: value);
      },
    ).paddingOnly(bottom: 11.h);
  }

  Widget showCVVNumberField() {
    return commonTextFieldWidget(
      focusNode: controller.cvvNode.value,
      controller: controller.cvvController.value,
      isError: controller.isCVVValid.value,
      errorMsg: controller.cvvErrorMessage.value,
      title: AppStrings.cvv.tr,
      hint: placeHolder.enterCVV.tr,
      maxLength: 3,
      keyboardType: TextInputType.number,
      textInputAction: TextInputAction.next,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
      ],
      onChanged: (value) {
        controller.onChangeCVV(value: value);
      },
    ).paddingOnly(bottom: 11.h);
  }

  Widget showExpriyNumberField() {
    return commonTextFieldWidget(
      focusNode: controller.expiryNode.value,
      controller: controller.expiryController.value,
      isError: controller.isCardValid.value,
      errorMsg: controller.cardErrorMessage.value,
      title: AppStrings.expiryDate.tr,
      hint: placeHolder.mmyy.tr,
      maxLength: 5,
      keyboardType: TextInputType.number,
      textInputAction: TextInputAction.next,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
      ],
      onChanged: (value) {
        controller.onChangeExpDate(value: value);
      },
    ).paddingOnly(bottom: 11.h);
  }

  CommonButton showAddCardButton() {
    return CommonButton(
      commonButtonBottonText: AppStrings.addCard.tr,
      onPress: controller.card.value.complete == false
          ? null
          : () {
              controller.handleCreateTokenPress();
            },
    );
  }
}
