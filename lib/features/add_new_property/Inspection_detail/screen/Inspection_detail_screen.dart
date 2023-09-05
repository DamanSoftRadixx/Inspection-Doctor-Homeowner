import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/app_bar/common_appbar.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/asset_widget/common_image_widget.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/common_button/common_button.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/common_dialogs.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/common_loader/common_loader.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/text/app_text_widget.dart';
import 'package:inspection_doctor_homeowner/core/constants/app_strings.dart';
import 'package:inspection_doctor_homeowner/core/constants/common_strings.dart';
import 'package:inspection_doctor_homeowner/core/date_formatter/date_formatter.dart';
import 'package:inspection_doctor_homeowner/core/theme/app_color_palette.dart';
import 'package:inspection_doctor_homeowner/core/utils/image_resources.dart';
import 'package:inspection_doctor_homeowner/features/add_new_property/Inspection_detail/controller/Inspection_detail_controller.dart';
import 'package:inspection_doctor_homeowner/features/add_new_property/Inspection_detail/model/local/widget_size.dart';
import 'package:inspection_doctor_homeowner/features/add_new_property/Inspection_detail/screen/reschedule.dart';
import 'package:inspection_doctor_homeowner/features/add_new_property/property_detail/model/network_model/Inspector_details.dart';
import 'package:inspection_doctor_homeowner/features/add_new_property/property_detail/model/network_model/property_inspection_schedules_history_model.dart';
import 'package:inspection_doctor_homeowner/features/add_new_property/property_detail/model/network_model/schedule_inspection_list_response_model.dart';
import 'package:measure_size/measure_size.dart';

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
                controller.isShowInitialLoader.value
                    ? const SizedBox()
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  getCategoryView(),
                                  Divider(color: lightColorPalette.grey)
                                      .paddingSymmetric(horizontal: 20.w),
//Date
                                  showDate().paddingOnly(
                                      bottom: 5.h, left: 20.w, right: 20.w),
                                  // getInspectionTimeList(
                                  //     controller.inspectionDetail.value),

                                  Divider(color: lightColorPalette.grey)
                                      .paddingSymmetric(horizontal: 20.w),
                                  getContactPersonDetail(),
                                  getDescription(),
                                  getInspectorDetailPersonDetail(),

                                  showInspectionStatusHistoryList()
                                ]),
                          ),
                        ],
                      ),
                CommonLoader(
                    isLoading: controller.isShowLoader.value ||
                        controller.isShowInitialLoader.value)
              ],
            ),
          ),
        ));
  }

  showInspectionStatusHistoryList() {
    return Expanded(
      child: Container(
        color: lightColorPalette.greyBg,
        width: 1.sw,
        margin: EdgeInsets.only(top: 15.h),
        padding: EdgeInsets.only(top: 15.h, left: 20.w, right: 20.w),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: AppTextWidget(
                  style: CustomTextTheme.subtext(color: lightColorPalette.grey),
                  text: AppStrings.trackYourInspection.tr,
                ),
              ).paddingOnly(bottom: 20.h),
              controller.inspectionHistoryList.value.isNotEmpty == true
                  ? ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.only(bottom: 10.h),
                      shrinkWrap: true,
                      itemCount: controller.inspectionHistoryList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(width: 2.w),
                            showProgressBar(index: index),
                            Expanded(
                                child: showStatusDetail(
                              index: index,
                            )),
                          ],
                        );
                      },
                    )
                  : const SizedBox()
            ],
          ),
        ),
      ),
    );
  }

  Widget showProgressBar({required int index}) {
    var history = controller.inspectionHistoryList[index];

    return Column(
      children: [
        //Icon
        AssetWidget(
          height: 18.h,
          asset: Asset(type: AssetType.svg, path: history.iconPath),
        ),

        //vertical pipe line

        Visibility(
          visible: history.isShowLine,
          child: Row(
            children: [
              Container(
                height: history.widgetSize?.height,
                width: 0.5.w,
                color: lightColorPalette.grey,
              ).paddingOnly(right: 4.w),
              Container(
                height: history.widgetSize?.height,
                width: 0.5.w,
                color: lightColorPalette.grey,
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget showStatusDetail({required int index}) {
    var history = controller.inspectionHistoryList[index];

    return MeasureSize(
      key: history.globalKey,
      onChange: (Size size) {
        controller.inspectionHistoryList[index].widgetSize =
            WidgetSize(height: size.height);
        controller.inspectionHistoryList.refresh();
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppTextWidget(
                textAlign: TextAlign.left,
                style: CustomTextTheme.normalTextWithWeight600(
                    color: lightColorPalette.black),
                text: history.title,
              ),
            ],
          ),
          Html(shrinkWrap: true, data: history.message, style: {
            // tables will have the below background color
            "div": Style(
                fontFamily: CommonStrings.generalSans,
                fontSize: FontSize(14.sp),
                fontWeight: FontWeight.w500,
                color: lightColorPalette.black,
                letterSpacing: 0.56),
            "b": Style(
                fontFamily: CommonStrings.generalSans,
                fontSize: FontSize(14.sp),
                fontWeight: FontWeight.w600,
                color: lightColorPalette.black,
                letterSpacing: 0.56)
          }),
          if (index == 0)
            Padding(
              padding:
                  history.isShowCancelButton || history.isShowRescheduleButton
                      ? EdgeInsets.only(top: 10.h, bottom: 0.h)
                      : EdgeInsets.zero,
              child: Row(
                children: [
                  if (history.isShowCancelButton)
                    Expanded(child: cancelButtonWidget()),
                  if (history.isShowRescheduleButton)
                    SizedBox(
                      width: 10.w,
                    ),
                  if (history.isShowRescheduleButton)
                    Expanded(child: rescheduleInspectionButtonWidget()),
                ],
              ),
            ),
          if (index == 0)
            Padding(
              padding: history.isShowGiveFeedBackButton ||
                      history.isShowViewReportButton
                  ? EdgeInsets.only(top: 10.h, bottom: 0.h)
                  : EdgeInsets.zero,
              child: Row(
                children: [
                  if (history.isShowGiveFeedBackButton)
                    Expanded(child: giveFeedbackButtonWidget()),
                  if (history.isShowViewReportButton)
                    SizedBox(
                      width: 10.w,
                    ),
                  if (history.isShowViewReportButton)
                    Expanded(
                        child: viewReportButtonWidget(
                            id: controller.inspectionDetail.value.id ?? "")),
                ],
              ),
            ),
          if (index != 0)
            SizedBox(
              height: 0.h,
            )
        ],
      ).paddingOnly(left: 12.w),
    );
  }

  getDescription() {
    PropertyInspectionSchedulesHistory firstHistoryItemDetail = controller
            .inspectionDetail.value.propertyInspectionSchedulesHistory?[0] ??
        PropertyInspectionSchedulesHistory();

    return firstHistoryItemDetail.description != null &&
            firstHistoryItemDetail.description != ""
        ? Align(
            alignment: Alignment.centerLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppTextWidget(
                  style: CustomTextTheme.subtext(color: lightColorPalette.grey),
                  text: AppStrings.description.tr,
                ).paddingOnly(bottom: 5.h),
                AppTextWidget(
                  style:
                      CustomTextTheme.subtext(color: lightColorPalette.black),
                  text: firstHistoryItemDetail.description ?? "",
                ),
              ],
            ).paddingOnly(left: 20.w, right: 20.w, top: 12.5),
          )
        : SizedBox(height: 15.h);
  }

  getContactPersonDetail() {
    PropertyInspectionSchedulesHistory firstHistoryItemDetail = controller
            .inspectionDetail.value.propertyInspectionSchedulesHistory?[0] ??
        PropertyInspectionSchedulesHistory();

    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: AppTextWidget(
            style: CustomTextTheme.normalText(color: lightColorPalette.grey),
            text: AppStrings.contactPerson.tr,
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
                      "${firstHistoryItemDetail.firstName ?? ""} ${firstHistoryItemDetail.lastName ?? ""}",
                ),
                Row(
                  children: [
                    AssetWidget(
                      color: lightColorPalette.black,
                      asset: Asset(
                        type: AssetType.svg,
                        path: ImageResource.call,
                      ),
                    ).paddingOnly(right: 3.w),
                    AppTextWidget(
                      style: CustomTextTheme.bottomTabs(
                          color: lightColorPalette.grey),
                      text:
                          "+${firstHistoryItemDetail.countryCode ?? ""} ${firstHistoryItemDetail.phone ?? ""}",
                    ),
                  ],
                ).paddingOnly(bottom: 2.h, top: 7.h),
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
                      style: CustomTextTheme.normalText(
                          color: lightColorPalette.grey),
                      text: firstHistoryItemDetail.email ?? "",
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

  getInspectorDetailPersonDetail() {
    List<InspectorDetails> inspectorDetailsList =
        controller.inspectionDetail.value.inspectorDetails ?? [];

    var inspectorDetails =
        inspectorDetailsList.isNotEmpty ? inspectorDetailsList[0] : null;

    List<InspectorImage> inspectorProfileImageList =
        controller.inspectionDetail.value.inspectorImage ?? [];

    String? inspectorProfileImage = inspectorProfileImageList.isNotEmpty
        ? inspectorProfileImageList[0].url
        : null;

    return inspectorDetails == null
        ? SizedBox(
            height: 15.h,
          )
        : Column(
            children: [
              SizedBox(
                height: 15.h,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: AppTextWidget(
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
                            style: CustomTextTheme.normalText(
                                color: lightColorPalette.grey),
                            text: inspectorDetails.email ?? "",
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              )
            ],
          ).paddingOnly(left: 20.w, right: 20.w, bottom: 15.h);
  }

  Row showDate() {
    PropertyInspectionSchedulesHistory firstHistoryItemDetail = controller
            .inspectionDetail.value.propertyInspectionSchedulesHistory?[0] ??
        PropertyInspectionSchedulesHistory();

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
          text: getLocalDateFromUtc(
              dateString: firstHistoryItemDetail.date ?? ""),
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
            padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 19.w),
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

  Widget cancelButtonWidget() {
    return CommonButton(
        style: CustomTextTheme.buttonText(
          color: lightColorPalette.redDark,
        ),
        bgColor: lightColorPalette.redBackground,
        border: BorderSide(color: lightColorPalette.redDark.withOpacity(0.4)),
        commonButtonBottonText: AppStrings.cancel.tr,
        onPress: () {
          showCommonAlertWithTwoActionsDialog(
              title: AppStrings.cancelInspection.tr,
              subHeader: AppStrings.areYouSureYouWantToCanelThisInspection.tr,
              noPressed: () {
                Get.back();
              },
              yesPressed: () {
                controller.onPressCancelInspectionButton();
              });
        });
  }

  Widget rescheduleInspectionButtonWidget() {
    return CommonButton(
        style: CustomTextTheme.buttonText(
          color: lightColorPalette.whiteColorPrimary.shade900,
        ),
        bgColor: lightColorPalette.black,
        commonButtonBottonText: AppStrings.reschedule.tr,
        onPress: () {
          controller.onOpenReScheduledBottomSheet();
          showRescheduleForm();
        });
  }

  Widget viewReportButtonWidget({required String id}) {
    return CommonButton(
        style: CustomTextTheme.buttonText(
          color: lightColorPalette.whiteColorPrimary.shade900,
        ),
        bgColor: lightColorPalette.black,
        commonButtonBottonText: AppStrings.viewReport.tr,
        onPress: () {
          controller.onPressViewReportButton(propertyId: id);
        });
  }

  Widget giveFeedbackButtonWidget() {
    return CommonButton(
        style: CustomTextTheme.buttonText(
          color: lightColorPalette.black,
        ),
        bgColor: Colors.transparent,
        border: BorderSide(color: lightColorPalette.black),
        commonButtonBottonText: AppStrings.feedback.tr,
        onPress: () {
          controller.onTapFeedbackButton();
        });
  }
}
