import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/app_bar/common_appbar.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/asset_widget/common_image_widget.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/common_button/common_button.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/common_loader/common_loader.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/document_picker/pdf_viewer.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/text/app_text_widget.dart';
import 'package:inspection_doctor_homeowner/core/constants/app_strings.dart';
import 'package:inspection_doctor_homeowner/core/theme/app_color_palette.dart';
import 'package:inspection_doctor_homeowner/core/utils/image_resources.dart';
import 'package:inspection_doctor_homeowner/core/utils/ui_utils.dart';
import 'package:inspection_doctor_homeowner/features/add_new_property/property_detail/controller/property_detail_controller.dart';

class PropertyDetailScreen extends GetView<PropertyDetailController> {
  const PropertyDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightColorPalette.whiteColorPrimary.shade900,
      appBar: commonAppBarWithElevation(
          title: AppStrings.detail.tr,
          onPressBackButton: () {
            Get.back();
          }),
      body: Obx(() => SafeArea(
            child: Stack(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    showPropertyDetail(),
                    showScheduleInspection()
                        .paddingOnly(bottom: 20.h, left: 20.w, right: 20.w)
                  ],
                ),
                CommonLoader(isLoading: controller.isShowLoader.value)
              ],
            ),
          )),
    );
  }

  Container showPropertyDetail() {
    return Container(
      padding: EdgeInsets.only(top: 20.h, bottom: 19.h),
      decoration: BoxDecoration(
        color: lightColorPalette.greyBg,
        border: Border(
          bottom: BorderSide(width: 1.0, color: lightColorPalette.black),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Align(
            alignment: Alignment.center,
            child: AppTextWidget(
              style: CustomTextTheme.heading3(color: lightColorPalette.black),
              text: controller.propertyDetail.value.propertyName ?? "",
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AssetWidget(
                color: lightColorPalette.black,
                asset: Asset(
                  type: AssetType.svg,
                  path: ImageResource.pinLocation,
                ),
              ).paddingOnly(top: 3.h),
              Flexible(
                child: AppTextWidget(
                  textAlign: TextAlign.center,
                  style:
                      CustomTextTheme.normalText(color: lightColorPalette.grey),
                  text: getAddressFormat(controller.propertyDetail.value),
                ),
              ),
            ],
          ).paddingOnly(top: 5.h, bottom: 5.h, left: 20.w, right: 20.w),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AssetWidget(
                color: lightColorPalette.black,
                asset: Asset(
                  type: AssetType.svg,
                  path: ImageResource.lin,
                ),
              ).paddingOnly(right: 5.w),
              AppTextWidget(
                style:
                    CustomTextTheme.normalText(color: lightColorPalette.grey),
                text: controller.propertyDetail.value.permitNumber ?? "",
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AssetWidget(
                    color: lightColorPalette.black,
                    asset: Asset(
                      type: AssetType.svg,
                      path: ImageResource.hashLogo,
                    ),
                  ).paddingOnly(right: 5.w),
                  AppTextWidget(
                    style: CustomTextTheme.normalText(
                        color: lightColorPalette.grey),
                    text: controller.propertyDetail.value.lotNumber ?? "",
                  ),
                ],
              ).paddingOnly(right: 20.w),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AssetWidget(
                    color: lightColorPalette.black,
                    asset: Asset(
                      type: AssetType.svg,
                      path: ImageResource.hashLogo,
                    ),
                  ).paddingOnly(right: 5.w),
                  AppTextWidget(
                    style: CustomTextTheme.normalText(
                        color: lightColorPalette.grey),
                    text: controller.propertyDetail.value.blockNumber ?? "",
                  ),
                ],
              ),
            ],
          ).paddingOnly(top: 5.h, bottom: 20.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //
              CommonButton(
                  border: BorderSide(
                    width: 0.3,
                    color: lightColorPalette.grey,
                  ),
                  style: CustomTextTheme.normalTextWithWeight600(
                      color: lightColorPalette.black),
                  bgColor: lightColorPalette.whiteColorPrimary.shade900,
                  icon: AssetWidget(
                    asset: Asset(
                      type: AssetType.svg,
                      path: ImageResource.drawing,
                    ),
                  ),
                  minWidth: 112.w,
                  commonButtonBottonText: AppStrings.drawing.tr,
                  onPress: () {
                    log("message ${controller.propertyDetail.value.architecturelDrawing?.url}");
                    // launchUrlOnBrowser(
                    //     url: controller.propertyDetail.value
                    //             .architecturelDrawing?.url ??
                    //         "");

                    Get.to(PDFScreen(
                      path: controller
                              .propertyDetail.value.architecturelDrawing?.url ??
                          "",
                    ));
                  }),

              //Edit
              CommonButton(
                  border: BorderSide(
                    width: 0.3,
                    color: lightColorPalette.grey,
                  ),
                  style: CustomTextTheme.normalTextWithWeight600(
                      color: lightColorPalette.greenDark),
                  bgColor: lightColorPalette.greenBackground,
                  icon: AssetWidget(
                    asset: Asset(
                      type: AssetType.svg,
                      path: ImageResource.edit,
                    ),
                  ),
                  minWidth: 99.5.w,
                  commonButtonBottonText: AppStrings.edit.tr,
                  onPress: () {
                    controller.onTapEditButton();
                  }).paddingSymmetric(horizontal: 10.w),
//Delete
              CommonButton(
                  border: BorderSide(
                    width: 0.3,
                    color: lightColorPalette.grey,
                  ),
                  style: CustomTextTheme.normalTextWithWeight600(
                      color: lightColorPalette.redDark),
                  bgColor: lightColorPalette.redBackground,
                  icon: AssetWidget(
                    asset: Asset(
                      type: AssetType.svg,
                      path: ImageResource.delete,
                    ),
                  ),
                  minWidth: 100.w,
                  commonButtonBottonText: AppStrings.delete.tr,
                  onPress: () {
                    controller.onTapDeleteButton();
                  })
            ],
          ),
        ],
      ),
    );
  }

  CommonButton showScheduleInspection() {
    return CommonButton(
        commonButtonBottonText: AppStrings.scheduleInspection.tr,
        onPress: () {
          controller.onPressAddPropertyButton();
        });
  }
}
