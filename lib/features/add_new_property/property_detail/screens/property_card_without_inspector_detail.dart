import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/asset_widget/common_image_widget.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/text/app_text_widget.dart';
import 'package:inspection_doctor_homeowner/core/date_formatter/date_formatter.dart';
import 'package:inspection_doctor_homeowner/core/theme/app_color_palette.dart';
import 'package:inspection_doctor_homeowner/core/utils/image_resources.dart';
import 'package:inspection_doctor_homeowner/features/add_new_property/property_detail/model/network_model/schedule_inspection_list_response_model.dart';
import 'package:inspection_doctor_homeowner/features/add_new_property/property_detail/screens/property_detail_screen.dart';

extension PropertyCard on PropertyDetailScreen {
  getPropertyDetailCard({required int index}) {
    ScheduleInspectionResponseData listData =
        controller.scheduleInspectionList[index];

    var inspectionStatusModel = controller.getInspectionStatus(
        inspectionId: listData.inspectionStatusId ?? "");

    return GestureDetector(
      onTap: () {
        controller.onInspectionListItem(index: index);
      },
      child: Container(
        margin: EdgeInsets.only(top: 15.h, right: 21.w, left: 20.w),
        // height: 194.h,
        width: 334.w,
        padding: EdgeInsets.only(top: 15.h, bottom: 15.h),
        decoration: decorationHome(),
        child: Column(
          children: [
            //category
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppTextWidget(
                  style:
                      CustomTextTheme.heading3(color: lightColorPalette.black),
                  text: listData.category?.name ?? "",
                ),
                AssetWidget(
                  color: lightColorPalette.black,
                  asset: Asset(
                    type: AssetType.svg,
                    path: ImageResource.forwordArrow,
                  ),
                ),
              ],
            ).paddingOnly(left: 18.w, right: 18.w),

            //subcategory
            Row(
              children: [
                Flexible(
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.r),
                        border: Border.all(
                            color: lightColorPalette.grey, width: 0.3)),
                    padding:
                        EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
                    child: AppTextWidget(
                      textAlign: TextAlign.start,
                      text: listData.subcategory?.first.name ?? "",
                      style: CustomTextTheme.categoryText(
                        color: lightColorPalette.black,
                      ),
                    ),
                  ),
                ),
              ],
            ).paddingOnly(left: 18.w, right: 18.w, top: 13.h),
            getDivider().paddingSymmetric(vertical: 15.h, horizontal: 18.w),
//Date
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
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
                      style: CustomTextTheme.normalText(
                          color: lightColorPalette.grey),
                      text: getDateFormattedFromString(
                          dateString: listData
                                  .propertyInspectionSchedulesHistory
                                  ?.first
                                  .date ??
                              ""),
                    ),
                  ],
                ).paddingOnly(right: 18.w),
                getInspectionTimeList(listData),
              ],
            ).paddingOnly(bottom: 5.h, left: 18.w, right: 18.w),

            getDivider().paddingSymmetric(vertical: 15.h),
            Row(
              children: [
                AppTextWidget(
                  textAlign: TextAlign.end,
                  style: CustomTextTheme.normalText(
                      color: inspectionStatusModel.color),
                  text: "\u2022",
                ).paddingOnly(right: 5.w),
                AppTextWidget(
                  style: CustomTextTheme.heading2(
                      color: inspectionStatusModel.color),
                  text: inspectionStatusModel.message,
                )
              ],
            ).paddingOnly(left: 18.w)
          ],
        ),
      ),
    );
  }
}
