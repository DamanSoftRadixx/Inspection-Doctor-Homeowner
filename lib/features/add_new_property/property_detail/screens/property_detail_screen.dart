import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/app_bar/common_appbar.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/asset_widget/common_image_widget.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/common_button/common_button.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/common_loader/common_loader.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/document_picker/pdf_viewer.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/no_data/no_data_found.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/refresh_indicator/common_refresh_indicator.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/text/app_text_widget.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/textfields/app_common_text_form_field.dart';
import 'package:inspection_doctor_homeowner/core/constants/app_strings.dart';
import 'package:inspection_doctor_homeowner/core/date_formatter/date_formatter.dart';
import 'package:inspection_doctor_homeowner/core/routes/routes.dart';
import 'package:inspection_doctor_homeowner/core/theme/app_color_palette.dart';
import 'package:inspection_doctor_homeowner/core/utils/image_resources.dart';
import 'package:inspection_doctor_homeowner/core/utils/ui_utils.dart';
import 'package:inspection_doctor_homeowner/features/add_new_property/property_detail/controller/property_detail_controller.dart';
import 'package:inspection_doctor_homeowner/features/add_new_property/property_detail/model/network_model/schedule_inspection_list_response_model.dart';

class PropertyDetailScreen extends GetView<PropertyDetailController> {
  const PropertyDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightColorPalette.whiteColorPrimary.shade900,
      appBar: commonAppBarWithElevation(
          title: AppStrings.propertyDetail.tr,
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
                CommonLoader(
                    isLoading: controller.isShowLoader.value ||
                        controller.isShowSearchLoader.value)
              ],
            ),
          )),
    );
  }

  showPropertyDetail() {
    return Expanded(
      child: Column(
        children: [
          Container(
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
                    style: CustomTextTheme.heading3(
                        color: lightColorPalette.black),
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
                        style: CustomTextTheme.normalText(
                            color: lightColorPalette.grey),
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
                      style: CustomTextTheme.normalText(
                          color: lightColorPalette.grey),
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
                          text:
                              controller.propertyDetail.value.blockNumber ?? "",
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
                          // launchUrlOnBrowser(
                          //     url: controller.propertyDetail.value
                          //             .architecturelDrawing?.url ??
                          //         "");

                          // Get.to(PDFScreen(
                          //   path:
                          // controller
                          //           .propertyDetail.value.architecturelDrawing?.url ??
                          //       "",
                          // ));

                          Navigator.push(
                              Get.context!,
                              MaterialPageRoute(
                                builder: (context) => FlutterFlowPdfViewer(
                                  networkPath: controller.propertyDetail.value
                                          .architecturelDrawing?.url ??
                                      "",
                                ),
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
          ),
          getInspectionList(),
        ],
      ),
    );
  }

  getInspectionList() {
    return Obx(() => Expanded(
          child: Column(
            children: [
              showSearchBar().paddingOnly(
                  top: 10.h, left: 20.w, right: 20.w, bottom: 02.h),
              Expanded(
                child: CommonRefreshIndicator(
                  onRefresh: () => Future.sync(() {
                    controller.onRefresh();
                  }),
                  controller: controller.refreshController,
                  child: controller.scheduleInspectionList.isNotEmpty
                      ? ListView.builder(
                          padding: EdgeInsets.only(bottom: 20.h),
                          shrinkWrap: true,
                          itemCount: controller.scheduleInspectionList.length,
                          itemBuilder: (BuildContext context, int index) {
                            ScheduleInspectionResponseData listData =
                                controller.scheduleInspectionList[index];
                            return getPropertyDetailCard(listData: listData);
                          },
                        )
                      : (controller.isShowSearchLoader.value
                          ? const SizedBox()
                          : showNoDataFound()),
                ),
              ),
              Visibility(
                  visible: controller.loadMore.value == true,
                  child: const CircularProgressIndicator())
            ],
          ),
        ));
  }

  getPropertyDetailCard({required ScheduleInspectionResponseData listData}) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(Routes.inspectionDetailScreen,
            arguments: {GetArgumentConstants.inspectionId: listData.id});
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
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.r),
                        border: Border.all(
                            color: lightColorPalette.grey, width: 0.3)),
                    padding:
                        EdgeInsets.symmetric(vertical: 19.h, horizontal: 19.w),
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
            const Divider(),
//Date
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
                  style:
                      CustomTextTheme.normalText(color: lightColorPalette.grey),
                  text: getDateFormatedFromString(date: listData.date ?? ""),
                ),
              ],
            ).paddingOnly(bottom: 5.h, left: 18.w, right: 18.w),
            getInspectionTimeList(listData),
            const Divider(),
            Align(
              alignment: Alignment.centerLeft,
              child: AppTextWidget(
                style:
                    CustomTextTheme.normalText(color: lightColorPalette.grey),
                text: listData.category?.name ?? "",
              ).paddingOnly(left: 18.w),
            )
          ],
        ),
      ),
    );
  }

  ListView getInspectionTimeList(ScheduleInspectionResponseData listData) {
    return ListView.builder(
      padding: EdgeInsets.only(left: 18.w, right: 18.w),
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

  CommonButton showScheduleInspection() {
    return CommonButton(
        commonButtonBottonText: AppStrings.scheduleInspection.tr,
        onPress: () {
          controller.onPressAddPropertyButton();
        });
  }

  Widget showSearchBar() {
    return commonSearchFieldWidget(
        controller: controller.searchController,
        onChanged: (value) {
          controller.onChangedSearch();
        },
        focusNode: controller.searchFocusNode.value,
        searchHint: AppStrings.searchCategoryAndInspection);
  }
}
