import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:inspection_doctor_homeowner/core/common_functionality/dismiss_keyboard.dart';
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
import 'package:inspection_doctor_homeowner/core/network_utility/model/time_model.dart';
import 'package:inspection_doctor_homeowner/core/theme/app_color_palette.dart';
import 'package:inspection_doctor_homeowner/core/utils/image_resources.dart';
import 'package:inspection_doctor_homeowner/core/utils/ui_utils.dart';
import 'package:inspection_doctor_homeowner/features/add_new_property/property_detail/controller/property_detail_controller.dart';
import 'package:inspection_doctor_homeowner/features/add_new_property/property_detail/model/network_model/schedule_inspection_list_response_model.dart';
import 'package:inspection_doctor_homeowner/features/add_new_property/property_detail/screens/property_card_with_inspector_detail.dart';
import 'package:inspection_doctor_homeowner/features/add_new_property/property_detail/screens/property_card_without_inspector_detail.dart';

class PropertyDetailScreen extends GetView<PropertyDetailController> {
  const PropertyDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          bottomNavigationBar: showScheduleInspection()
              .paddingOnly(bottom: 20.h, left: 20.w, right: 20.w),
          backgroundColor: lightColorPalette.whiteColorPrimary.shade900,
          appBar: commonAppBarWithElevation(
              title: AppStrings.propertyDetail.tr,
              onPressBackButton: () {
                Get.back();
              }),
          body: SafeArea(
            child: GestureDetector(
              onTap: () {
                dismissKeyboard();
              },
              child: Stack(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(child: showPropertyDetail()),
                    ],
                  ),
                  CommonLoader(
                      isLoading: controller.isShowLoader.value ||
                          controller.isShowSearchLoader.value)
                ],
              ),
            ),
          ),
        ));
  }

  showPropertyDetail() {
    return Column(
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
                  style:
                      CustomTextTheme.heading3(color: lightColorPalette.black),
                  text: controller.propertyDetail.value.propertyName ?? "",
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                      child: Text.rich(
                    style: CustomTextTheme.normalText(
                        color: lightColorPalette.grey),
                    textAlign: TextAlign.center,
                    TextSpan(
                      style: CustomTextTheme.normalText(
                          color: lightColorPalette.grey),
                      children: [
                        WidgetSpan(
                          child: AssetWidget(
                            color: lightColorPalette.black,
                            asset: Asset(
                              type: AssetType.svg,
                              path: ImageResource.pinLocation,
                            ),
                          ).paddingOnly(right: 5.w, bottom: 1.h),
                        ),
                        TextSpan(
                            text: getAddressFormat(
                                controller.propertyDetail.value)),
                      ],
                    ),
                  ))
                ],
              ).paddingOnly(top: 6.h, bottom: 5.h, left: 20.w, right: 20.w),
              /*  Row(
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
              ),*/
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          child: Row(
                            children: [
                              AssetWidget(
                                color: lightColorPalette.black,
                                asset: Asset(
                                  type: AssetType.svg,
                                  path: ImageResource.hashLogo,
                                ),
                              ).paddingOnly(right: 5.w),
                              Flexible(
                                child: AppTextWidget(
                                  style: CustomTextTheme.normalText(
                                      color: lightColorPalette.grey),
                                  text:
                                      "Lot#${controller.propertyDetail.value.lotNumber ?? ""}",
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Flexible(
                            child: Row(
                          children: [
                            AssetWidget(
                              color: lightColorPalette.black,
                              asset: Asset(
                                type: AssetType.svg,
                                path: ImageResource.hashLogo,
                              ),
                            ).paddingOnly(right: 5.w, left: 20.w),
                            Flexible(
                              child: AppTextWidget(
                                style: CustomTextTheme.normalText(
                                    color: lightColorPalette.grey),
                                text: controller
                                        .propertyDetail.value.blockNumber ??
                                    "",
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ))
                      ],
                    ),
                  ),
                ],
              ).paddingOnly(top: 5.h, bottom: 20.h, left: 20.w, right: 20.w),
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
        Expanded(child: getInspectionList())
      ],
    );
  }

  getInspectionList() {
    return Obx(() => Column(
          children: [
            showSearchBar()
                .paddingOnly(top: 10.h, left: 20.w, right: 20.w, bottom: 02.h),
            controller.isShowLoader.value || controller.isShowSearchLoader.value
                ? const SizedBox()
                : Expanded(
                    child: CommonRefreshIndicator(
                      onRefresh: () => Future.sync(() {
                        controller.onRefresh();
                      }),
                      controller: controller.refreshController,
                      child: controller.scheduleInspectionList.isNotEmpty
                          ? ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              padding: EdgeInsets.only(bottom: 20.h),
                              shrinkWrap: true,
                              itemCount:
                                  controller.scheduleInspectionList.length,
                              itemBuilder: (BuildContext context, int index) {
                                log("message ${controller.scheduleInspectionList[index].inspectorDetails}");
                                return controller.scheduleInspectionList[index]
                                            .inspectorDetails?.isEmpty ==
                                        true
                                    ? getPropertyDetailCard(index: index)
                                    : getPropertyDetailCardWithInspectionDetail(
                                        index: index);
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
        ));
  }

  getInspectionTimeList(ScheduleInspectionResponseData listData) {
    // List<TimeModel> timeList =
    //     listData.propertyInspectionSchedulesHistory?.first.time ?? [];

    var timeList = [];

    if (listData.propertyInspectionSchedulesHistory?.first
                .acceptedInspectionTime?.isNotEmpty ==
            true &&
        listData.propertyInspectionSchedulesHistory?.first
                .acceptedInspectionTime !=
            null) {
      timeList = listData.propertyInspectionSchedulesHistory?.first
              .acceptedInspectionTime ??
          [];
    } else {
      timeList = listData.propertyInspectionSchedulesHistory?.first.time ?? [];
    }

    return Expanded(
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: timeList.length,
        itemBuilder: (BuildContext context, int index) {
          TimeModel timeData = timeList[index];
          return Row(
            mainAxisAlignment: MainAxisAlignment.start,
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
              Row(
                children: [
                  AppTextWidget(
                      style: CustomTextTheme.normalText(
                          color: lightColorPalette.grey),
                      text: getLocalTimeFromUtc(
                          dateTimeString: timeData.starttime ?? "")),
                  AppTextWidget(
                      style: CustomTextTheme.normalText(
                          color: lightColorPalette.grey),
                      text: "-"),
                  AppTextWidget(
                      style: CustomTextTheme.normalText(
                          color: lightColorPalette.grey),
                      text: getLocalTimeFromUtc(
                          dateTimeString: timeData.endtime ?? "")),
                ],
              ),
            ],
          );
        },
      ),
    );
  }

  CommonButton showScheduleInspection() {
    return CommonButton(
        commonButtonBottonText: AppStrings.scheduleInspection.tr,
        onPress: () {
          controller.onPressScheduleInspectionButton();
        });
  }

  Widget showSearchBar() {
    return commonSearchFieldWidget(
        controller: controller.searchController,
        onChanged: (value) {
          controller.onChangedSearch();
        },
        focusNode: controller.searchFocusNode.value,
        searchHint: AppStrings.searchCategoryAndInspection.tr);
  }

  Divider getDivider() {
    return Divider(
      height: 0,
      color: lightColorPalette.black,
      thickness: 0.3,
      indent: 0,
      endIndent: 0,
    );
  }
}
