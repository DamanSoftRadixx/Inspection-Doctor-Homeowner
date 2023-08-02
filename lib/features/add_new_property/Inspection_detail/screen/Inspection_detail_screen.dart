import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/app_bar/common_appbar.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/asset_widget/common_image_widget.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/common_loader/common_loader.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/text/app_text_widget.dart';
import 'package:inspection_doctor_homeowner/core/constants/app_strings.dart';
import 'package:inspection_doctor_homeowner/core/date_formatter/date_formatter.dart';
import 'package:inspection_doctor_homeowner/core/theme/app_color_palette.dart';
import 'package:inspection_doctor_homeowner/core/utils/image_resources.dart';
import 'package:inspection_doctor_homeowner/features/add_new_property/Inspection_detail/controller/Inspection_detail_controller.dart';
import 'package:inspection_doctor_homeowner/features/add_new_property/property_detail/model/network_model/schedule_inspection_list_response_model.dart';

class InspectionDetailScreen extends GetView<InspectionDetailController> {
  const InspectionDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          backgroundColor: lightColorPalette.whiteColorPrimary.shade900,
          appBar: commonAppBarWithElevation(
              title: AppStrings.inspectionDetail.tr,
              onPressBackButton: () {
                Get.back();
              }),
          body: SafeArea(
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
                            Divider(color: lightColorPalette.grey)
                                .paddingSymmetric(horizontal: 20.w),
//Date
                            showDate().paddingOnly(
                                bottom: 5.h, left: 20.w, right: 20.w),
                            getInspectionTimeList(
                                controller.inspectionDetail.value),

                            Divider(color: lightColorPalette.grey)
                                .paddingSymmetric(horizontal: 20.w),
                            getContactPersonDetail(),

                            getDescription(),

                            showInspectionStatus()
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                CommonLoader(isLoading: controller.isShowLoader.value)
              ],
            ),
          ),
        ));
  }

  Container showInspectionStatus() {
    return Container(
      height: 388.h,
      padding: EdgeInsets.all(20.r),
      width: 1.sw,
      color: lightColorPalette.greyBg,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppTextWidget(
            style: CustomTextTheme.subtext(color: lightColorPalette.grey),
            text: AppStrings.trackYourInspection,
          ),
          AppTextWidget(
            style: CustomTextTheme.subtext(color: lightColorPalette.grey),
            text: "Inspector is not assigned yet.",
          ).paddingOnly(top: 20.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppTextWidget(
                style:
                    CustomTextTheme.buttonText(color: lightColorPalette.grey),
                text: "28 June 2023  8:53 am",
              ),
              AppTextWidget(
                style:
                    CustomTextTheme.buttonText(color: lightColorPalette.grey),
                text: "28 June 2023  8:53 am",
              ),
            ],
          ).paddingOnly(bottom: 7.5.h, top: 23.5.h),
          AppTextWidget(
            style: CustomTextTheme.buttonText(color: lightColorPalette.grey),
            text:
                "You have requested Category 2 - Kitchen inspection, Bedroom inspection(s) by 30 June 2023  10:20 am.",
          ),
        ],
      ),
    );
  }

  getDescription() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppTextWidget(
            style: CustomTextTheme.subtext(color: lightColorPalette.grey),
            text: AppStrings.description,
          ).paddingOnly(bottom: 5.h),
          AppTextWidget(
            style: CustomTextTheme.subtext(color: lightColorPalette.grey),
            text: controller.inspectionDetail.value.description ?? "",
          ),
        ],
      ).paddingOnly(left: 20.w, right: 20.w, top: 12.5.h, bottom: 30.h),
    );
  }

  getContactPersonDetail() {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: AppTextWidget(
            style: CustomTextTheme.normalText(color: lightColorPalette.grey),
            text: AppStrings.AMOUNT,
          ),
        ).paddingOnly(bottom: 10.h),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 36.h,
              width: 36.w,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.r),
                  border:
                      Border.all(color: lightColorPalette.grey, width: 0.3)),
              child: Center(
                child: AssetWidget(
                  color: lightColorPalette.black,
                  asset: Asset(
                    type: AssetType.svg,
                    path: ImageResource.user,
                  ),
                ),
              ),
            ),
            SizedBox(width: 10.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppTextWidget(
                  style: CustomTextTheme.bottomTabs(
                      color: lightColorPalette.black),
                  text:
                      "${controller.inspectionDetail.value.firstName ?? ""} ${controller.inspectionDetail.value.lastName ?? ""}",
                ),
                Row(
                  children: [
                    AssetWidget(
                      color: lightColorPalette.black,
                      asset: Asset(
                        type: AssetType.svg,
                        path: ImageResource.email,
                      ),
                    ).paddingOnly(right: 6.w),
                    AppTextWidget(
                      style: CustomTextTheme.bottomTabs(
                          color: lightColorPalette.grey),
                      text:
                          "${controller.inspectionDetail.value.countryCode ?? ""} ${controller.inspectionDetail.value.phone ?? ""}",
                    ),
                  ],
                ).paddingOnly(bottom: 2.h, top: 7.h),
                Row(
                  children: [
                    AssetWidget(
                      color: lightColorPalette.black,
                      asset: Asset(
                        type: AssetType.svg,
                        path: ImageResource.call,
                      ),
                    ).paddingOnly(right: 6.w),
                    AppTextWidget(
                      style: CustomTextTheme.normalText(
                          color: lightColorPalette.grey),
                      text: controller.inspectionDetail.value.email ?? "",
                    ),
                  ],
                ),
              ],
            )
          ],
        )
      ],
    ).paddingOnly(left: 20.w, right: 20.w);
  }

  Row showDate() {
    return Row(
      children: [
        AssetWidget(
          height: 14.h,
          width: 14.w,
          color: lightColorPalette.black,
          asset: Asset(
            type: AssetType.svg,
            path: ImageResource.calendar,
          ),
        ).paddingOnly(right: 5.w),
        AppTextWidget(
          style: CustomTextTheme.normalText(color: lightColorPalette.grey),
          text: getDateFormatedFromString(
              date: controller.inspectionDetail.value.date ?? ""),
        ),
      ],
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
            text: controller.inspectionDetail.value.category?.name ?? "",
            style: CustomTextTheme.heading3(
              color: lightColorPalette.black,
            ),
          ).paddingOnly(bottom: 10.h),
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.r),
                border: Border.all(color: lightColorPalette.grey, width: 0.3)),
            padding: EdgeInsets.symmetric(vertical: 19.h, horizontal: 19.w),
            child: AppTextWidget(
              textAlign: TextAlign.start,
              text: controller.inspectionDetail.value.subcategory?.first.name ??
                  "",
              style: CustomTextTheme.categoryText(
                color: lightColorPalette.black,
              ),
            ),
          ),
        ],
      ).paddingSymmetric(horizontal: 20.w, vertical: 20.h),
    );
  }

  ListView getInspectionTimeList(ScheduleInspectionResponseData listData) {
    return ListView.builder(
      padding: EdgeInsets.only(left: 20.w, right: 20.w),
      shrinkWrap: true,
      itemCount: listData.time?.length,
      itemBuilder: (BuildContext context, int index) {
        Time timeData = listData.time![index];
        return Row(
          children: [
            SizedBox(
              width: 90.w,
              child: Row(
                children: [
                  AssetWidget(
                    height: 14.h,
                    width: 14.w,
                    color: lightColorPalette.black,
                    asset: Asset(
                      type: AssetType.svg,
                      path: ImageResource.clock,
                    ),
                  ).paddingOnly(right: 5.w),
                  AppTextWidget(
                      style: CustomTextTheme.normalText(
                          color: lightColorPalette.grey),
                      text: getLocalTimeFromUtc(
                          dateTimeString: timeData.starttime ?? "")),
                ],
              ),
            ),
            AppTextWidget(
                style:
                    CustomTextTheme.normalText(color: lightColorPalette.grey),
                text: " -  "),
            SizedBox(
              width: 90.w,
              child: Row(
                children: [
                  AssetWidget(
                    height: 14.h,
                    width: 14.w,
                    color: lightColorPalette.black,
                    asset: Asset(
                      type: AssetType.svg,
                      path: ImageResource.clock,
                    ),
                  ).paddingOnly(right: 5.w),
                  AppTextWidget(
                      style: CustomTextTheme.normalText(
                          color: lightColorPalette.grey),
                      text: getLocalTimeFromUtc(
                          dateTimeString: timeData.endtime ?? "")),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
