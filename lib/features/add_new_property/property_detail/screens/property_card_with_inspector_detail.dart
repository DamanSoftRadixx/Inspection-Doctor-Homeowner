import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/asset_widget/common_image_widget.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/text/app_text_widget.dart';
import 'package:inspection_doctor_homeowner/core/constants/app_strings.dart';
import 'package:inspection_doctor_homeowner/core/date_formatter/date_formatter.dart';
import 'package:inspection_doctor_homeowner/core/theme/app_color_palette.dart';
import 'package:inspection_doctor_homeowner/core/utils/image_resources.dart';
import 'package:inspection_doctor_homeowner/features/add_new_property/property_detail/model/network_model/schedule_inspection_list_response_model.dart';
import 'package:inspection_doctor_homeowner/features/add_new_property/property_detail/screens/property_detail_screen.dart';

extension PropertyCard on PropertyDetailScreen {
  getPropertyDetailCardWithInspectionDetail({required int index}) {
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                      text: getLocalDateFromUtc(
                          dateString: listData
                                  .propertyInspectionSchedulesHistory
                                  ?.first
                                  .acceptedInspectionDate ??
                              ""),
                    ),
                  ],
                ).paddingOnly(right: 18.w),
                getInspectionTimeList(listData),
              ],
            ).paddingOnly(bottom: 5.h, left: 18.w, right: 18.w),

            getDivider().paddingSymmetric(vertical: 15.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                    flex: 2,
                    child: getInspectorDetailPersonDetail(listData: listData)),
              ],
            ).paddingOnly(right: 18.w),

            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                AppTextWidget(
                  textAlign: TextAlign.end,
                  style: CustomTextTheme.normalText(
                      color: inspectionStatusModel.color),
                  text: "\u2022",
                ),
                Flexible(
                  child: AppTextWidget(
                    textAlign: TextAlign.end,
                    style: CustomTextTheme.heading2(
                        color: inspectionStatusModel.color),
                    text: inspectionStatusModel.message,
                  ),
                ),
              ],
            ).paddingOnly(left: 18.w),
          ],
        ),
      ),
    );
  }

  getInspectorDetailPersonDetail(
      {required ScheduleInspectionResponseData listData}) {
    List<InspectorDetails> inspectorDetailsList =
        listData.inspectorDetails ?? [];

    var inspectorDetails =
        inspectorDetailsList.isNotEmpty ? inspectorDetailsList[0] : null;

    List<InspectorImage> inspectorProfileImageList =
        listData.inspectorImage ?? [];

    String? inspectorProfileImage = inspectorProfileImageList.isNotEmpty
        ? inspectorProfileImageList[0].url
        : null;

    return inspectorDetails == null
        ? SizedBox(
            height: 15.h,
          )
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: AppTextWidget(
                  textAlign: TextAlign.left,
                  style:
                      CustomTextTheme.normalText(color: lightColorPalette.grey),
                  text: AppStrings.inspector.tr,
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
                        border: Border.all(
                            color: lightColorPalette.grey, width: 0.3)),
                    child: Center(
                      child: AssetWidget(
                        boxFit: BoxFit.cover,
                        color: lightColorPalette.black,
                        asset: inspectorProfileImage != null &&
                                inspectorProfileImage != ""
                            ? Asset(
                                type: AssetType.network,
                                path: inspectorProfileImage ?? "",
                              )
                            : Asset(
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
                            "${inspectorDetails.firstName ?? ""} ${inspectorDetails.lastName ?? ""}",
                      ),
                      SizedBox(height: 4.h),
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 4.w, vertical: 2.h),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(2.r),
                          border: Border.all(
                              color: lightColorPalette.grey, width: 0.3),
                        ),
                        child: Row(
                          children: [
                            AssetWidget(
                              asset: Asset(
                                type: AssetType.svg,
                                path: ImageResource.star,
                              ),
                            ),
                            SizedBox(width: 4.w),
                            AppTextWidget(
                              style: CustomTextTheme.normalText(
                                  color: lightColorPalette.grey),
                              text: "4.50 Rating",
                            ),
                          ],
                        ),
                      )
                    ],
                  )
                ],
              )
            ],
          ).paddingOnly(left: 20.w, right: 20.w, bottom: 15.h);
  }
}
