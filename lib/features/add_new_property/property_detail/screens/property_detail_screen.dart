import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/app_bar/common_appbar.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/asset_widget/common_image_widget.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/common_button/common_button.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/text/app_text_widget.dart';
import 'package:inspection_doctor_homeowner/core/constants/app_strings.dart';
import 'package:inspection_doctor_homeowner/core/theme/app_color_palette.dart';
import 'package:inspection_doctor_homeowner/core/utils/image_resources.dart';
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
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            showPropertyDetail(),
            showScheduleInspection()
                .paddingOnly(bottom: 54.h, left: 20.w, right: 20.w)
          ],
        ),
      ),
    );
  }

  Container showPropertyDetail() {
    return Container(
      padding: EdgeInsets.only(top: 20.h, bottom: 19.h),
      decoration: BoxDecoration(
        color: lightColorPalette.backgroundColor,
        border: Border(
          bottom: BorderSide(width: 1.0, color: lightColorPalette.primaryBlue),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Align(
            alignment: Alignment.center,
            child: AppTextWidget(
              style: CustomTextTheme.heading3(
                  color: lightColorPalette.primaryDarkblue),
              text: "ABC Property name",
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AssetWidget(
                asset: Asset(
                  type: AssetType.svg,
                  path: ImageResource.pinLocation,
                ),
              ).paddingOnly(right: 5.w),
              AppTextWidget(
                style: CustomTextTheme.normalText(
                    color: lightColorPalette.primaryGrey),
                text: "4001 Anderson Road, Nashville TN 37217",
              ),
            ],
          ).paddingOnly(top: 5.h, bottom: 5.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AssetWidget(
                asset: Asset(
                  type: AssetType.svg,
                  path: ImageResource.lin,
                ),
              ).paddingOnly(right: 5.w),
              AppTextWidget(
                style: CustomTextTheme.normalText(
                    color: lightColorPalette.primaryGrey),
                text: "LIN0000000310",
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
                    asset: Asset(
                      type: AssetType.svg,
                      path: ImageResource.hashLogo,
                    ),
                  ).paddingOnly(right: 5.w),
                  AppTextWidget(
                    style: CustomTextTheme.normalText(
                        color: lightColorPalette.primaryGrey),
                    text: "Lot#33",
                  ),
                ],
              ).paddingOnly(right: 20.w),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AssetWidget(
                    asset: Asset(
                      type: AssetType.svg,
                      path: ImageResource.hashLogo,
                    ),
                  ).paddingOnly(right: 5.w),
                  AppTextWidget(
                    style: CustomTextTheme.normalText(
                        color: lightColorPalette.primaryGrey),
                    text: "20224-0705",
                  ),
                ],
              ),
            ],
          ).paddingOnly(top: 5.h, bottom: 20.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CommonButton(
                  border: BorderSide(
                    width: 0.3,
                    color: lightColorPalette.stroke,
                  ),
                  style: CustomTextTheme.normalTextWithWeight600(
                      color: lightColorPalette.primaryDarkblue),
                  bgColor: lightColorPalette.whiteColorPrimary.shade900,
                  icon: AssetWidget(
                    asset: Asset(
                      type: AssetType.svg,
                      path: ImageResource.drawing,
                    ),
                  ),
                  minWidth: 112.w,
                  commonButtonBottonText: AppStrings.drawing.tr,
                  onPress: () {}),
              CommonButton(
                      border: BorderSide(
                        width: 0.3,
                        color: lightColorPalette.stroke,
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
                      minWidth: 112.w,
                      commonButtonBottonText: AppStrings.edit.tr,
                      onPress: () {})
                  .paddingSymmetric(horizontal: 10.w),
              CommonButton(
                  border: BorderSide(
                    width: 0.3,
                    color: lightColorPalette.stroke,
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
                  minWidth: 112.w,
                  commonButtonBottonText: AppStrings.delete.tr,
                  onPress: () {})
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
