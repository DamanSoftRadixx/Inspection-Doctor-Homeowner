import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:inspection_doctor_homeowner/core/common_functionality/dismiss_keyboard.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/app_bar/common_appbar.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/asset_widget/common_image_widget.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/common_button/common_button.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/common_button/custom_icon_button.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/common_loader/common_loader.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/text/app_text_widget.dart';
import 'package:inspection_doctor_homeowner/core/constants/app_keys.dart';
import 'package:inspection_doctor_homeowner/core/constants/app_strings.dart';
import 'package:inspection_doctor_homeowner/core/routes/routes.dart';
import 'package:inspection_doctor_homeowner/core/theme/app_color_palette.dart';
import 'package:inspection_doctor_homeowner/core/utils/enum.dart';
import 'package:inspection_doctor_homeowner/core/utils/image_resources.dart';
import 'package:inspection_doctor_homeowner/features/payments/payment/controller/payment_controller.dart';
import 'package:inspection_doctor_homeowner/features/payments/payment/extensions/no_card_added_box.dart';
import 'package:inspection_doctor_homeowner/features/payments/payment/model/network_model/card_list_response_model.dart';

class PaymentScreen extends GetView<PaymentController> {
  const PaymentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => WillPopScope(
        onWillPop: () async => controller.isShowLoader.value ? false : true,
        child: Scaffold(
            backgroundColor: lightColorPalette.whiteColorPrimary.shade900,
            appBar: commonAppBarWithElevation(
                title: AppStrings.makePayment.tr,
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
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        showPaymentInfo(),
                        controller.cardList.isEmpty
                            ? noCardAddedYetWidget(
                                isNoCard:
                                    controller.isShowLoader.value == false)
                            : Expanded(
                                child: Column(
                                  children: [
                                    showCardList(),
                                    showCreateInspectionButton()
                                        .paddingSymmetric(
                                            horizontal: 20.w, vertical: 10.h),
                                    showAddCardButton().paddingOnly(
                                        left: 20.w, right: 20.w, bottom: 50.h),
                                  ],
                                ),
                              )
                      ],
                    ),
                    CommonLoader(isLoading: controller.isShowLoader.value)
                  ],
                ),
              ),
            )),
      ),
    );
  }

  Widget showCardList() {
    return Expanded(
      child: ListView.builder(
        padding: EdgeInsets.only(top: 30.h, bottom: 40.h),
        shrinkWrap: true,
        physics: const RangeMaintainingScrollPhysics(),
        itemCount: controller.cardList.length,
        itemBuilder: (BuildContext context, int index) {
          return showCardDetail(index: index, cardList: controller.cardList);
        },
      ),
    );
  }

  Container showPaymentInfo() {
    return Container(
      padding: EdgeInsets.all(20.r),
      color: lightColorPalette.greyBg,
      width: 1.sw,
      child: AppTextWidget(
        text: AppStrings.informAboutPayment,
        style: CustomTextTheme.normalText2(
          color: lightColorPalette.grey,
        ),
      ),
    );
  }

  CommonButton showAddCardButton() {
    return CommonButton(
      border: BorderSide(
        width: 1,
        color: lightColorPalette.black,
      ),
      style: CustomTextTheme.normalTextWithWeight600(
          color: lightColorPalette.black),
      bgColor: lightColorPalette.whiteColorPrimary.shade900,
      commonButtonBottonText: AppStrings.addNewCard.tr,
      onPress: () {
        Get.toNamed(Routes.addCardScreen)?.then((value) {
          if (value != null) {
            bool result = value[0][GetArgumentConstants.isNeedToUpdateList];

            if (result == true) {
              controller.getCardList();
            }
          }
        });
      },
    );
  }

  CommonButton showCreateInspectionButton() {
    return CommonButton(
      commonButtonBottonText: AppStrings.createInspection.tr,
      onPress: controller.selectedCard.value.id == CardListModelData().id
          ? null
          : () {
              controller.createInspection();
            },
    );
  }

  showCardDetail(
      {required int index, required List<CardListModelData> cardList}) {
    CardListModelData data = cardList[index];
    return Obx(() => CommonInkwell(
          onTap: () {
            controller.selectedCard.value = data;
            controller.selectedCard.refresh();
          },
          child: Row(
            children: [
              SizedBox(
                height: 25.h,
                width: 25.w,
                child: AssetWidget(
                        asset: Asset(
                            path: controller.selectedCard.value.id == data.id
                                ? ImageResource.blackCircle
                                : ImageResource.unCheck,
                            type: AssetType.svg),
                        isCircular: false)
                    .paddingOnly(right: 10.w),
              ),
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        width: 1.sw,
                        padding: EdgeInsets.symmetric(
                            vertical: 10.h, horizontal: 11.w),
                        decoration: decorationImage(),
                        child: Row(
                          children: [
                            SizedBox(
                              height: 32.w,
                              width: 44.h,
                              child: AssetWidget(
                                asset: Asset(
                                  type: AssetType.svg,
                                  path: getCardBrand(brand: data.brand ?? ""),
                                ),
                              ),
                            ).paddingOnly(right: 10.w),
                            AppTextWidget(
                              text: "**********${data.last4}",
                              style: CustomTextTheme.normalTextWithWeight600(
                                color: lightColorPalette.black,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ).paddingOnly(left: 20.w, right: 20.w, top: 10.h),
        ));
  }

  String getCardBrand({required String brand}) {
    String result = "";

    log("getCardBrand $brand");

    if (brand == CardTypeEnum.visa.value) {
      result = ImageResource.visa;
    } else if (brand == CardTypeEnum.americanExpress.value) {
      result = ImageResource.americanExpress;
    } else if (brand == CardTypeEnum.mastercard.value) {
      result = ImageResource.master;
    } else if (brand == CardTypeEnum.jcb.value) {
      result = ImageResource.jcb;
    } else if (brand == CardTypeEnum.discover.value) {
      result = ImageResource.discover;
    } else if (brand == CardTypeEnum.dinersClub.value) {
      result = ImageResource.dinnersClub;
    } else if (brand == CardTypeEnum.unionPay.value) {
      result = ImageResource.unionpay;
    }
    return result;
  }
}
