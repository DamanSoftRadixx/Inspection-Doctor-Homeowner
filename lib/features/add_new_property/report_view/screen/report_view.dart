import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/app_bar/common_appbar.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/asset_widget/common_image_widget.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/asset_widget/flutter_flow_expanded_image_view.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/document_picker/pdf_viewer.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/text/app_text_widget.dart';
import 'package:inspection_doctor_homeowner/core/constants/app_strings.dart';
import 'package:inspection_doctor_homeowner/core/theme/app_color_palette.dart';
import 'package:inspection_doctor_homeowner/core/utils/image_resources.dart';
import 'package:inspection_doctor_homeowner/features/add_new_property/report_view/controller/report_view_controller.dart';
import 'package:page_transition/page_transition.dart';

class ReportView extends GetView<ReportViewController> {
  const ReportView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightColorPalette.whiteColorPrimary.shade900,
      appBar: commonAppBarWithElevation(
          title: AppStrings.viewReport.tr,
          onPressBackButton: () {
            Get.back();
          }),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          showDocumentView().paddingOnly(bottom: 20.h),

          (controller.reportData.value.reportImages?.length??0)>0?
          showImageView().paddingOnly(bottom: 20.h) :SizedBox(),
          showDescription()
        ],
      ).paddingSymmetric(horizontal: 20.w, vertical: 20.h),
    );
  }

  showDescription() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppTextWidget(
          style: CustomTextTheme.subtext(color: lightColorPalette.grey),
          text: AppStrings.description,
        ).paddingOnly(bottom: 5.h),
        AppTextWidget(
          style: CustomTextTheme.subtext(color: lightColorPalette.black),
          text: controller.reportData.value.reportDescription ?? "",
        ),
      ],
    );
  }

  Column showDocumentView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppTextWidget(
          style: CustomTextTheme.normalText(
            color: lightColorPalette.black,
          ),
          text: AppStrings.document,
          textAlign: TextAlign.center,
        ),
        GestureDetector(
          onTap: () {
            var reportPath = controller.reportData.value.reportUrl ?? "";
            var list = reportPath.split(".");
            var fileName = AppStrings.inspectionReport.tr;

            if (list.isNotEmpty && list.length >= 2) {
              fileName = "${list[list.length - 2]}.${list[list.length - 1]}";
            }
            Navigator.push(
                Get.context!,
                MaterialPageRoute(
                  builder: (context) => FlutterFlowPdfViewer(
                    networkPath: reportPath,
                    title: fileName,
                  ),
                ));
          },
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: lightColorPalette.grey, width: 0.3),
              borderRadius: BorderRadius.circular(10.r),
              color: lightColorPalette.whiteColorPrimary.shade900,
            ),
            width: 1.sw,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 13.h),
              child: AppTextWidget(
                style: CustomTextTheme.normalText(
                  color: lightColorPalette.black,
                ),
                text: "${controller.reportData.value.reportUrl?.split(".")[(controller.reportData.value.reportUrl?.split(".").length??0)-2]}.${controller.reportData.value.reportUrl?.split(".")[(controller.reportData.value.reportUrl?.split(".").length??0)-1]}",
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Column showImageView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppTextWidget(
          style: CustomTextTheme.normalText(
            color: lightColorPalette.black,
          ),
          text: AppStrings.images,
          textAlign: TextAlign.center,
        ),
        Row(
          children: [
            Expanded(
              child: SizedBox(
                height: 102.h,
                child: ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 5.w),
                  shrinkWrap: true,
                  itemCount: controller.reportData.value.reportImages?.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) {
                    return imageViewer(
                        index: index,
                        imageList:
                            controller.reportData.value.reportImages ?? []);
                  },
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  imageViewer({required int index, required List<String> imageList}) {
    return InkWell(
      splashColor: Colors.transparent,
      focusColor: Colors.transparent,
      hoverColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () async {
        await Navigator.push(
          Get.context!,
          PageTransition(
            type: PageTransitionType.fade,
            child: ExpandedImageView(
              image: Image.network(
                imageList[index],
                fit: BoxFit.contain,
              ),
              allowRotation: false,
              tag: 'tesr',
              useHeroAnimation: true,
            ),
          ),
        );
      },
      child: Hero(
        tag: 'tesr',
        transitionOnUserGestures: true,
        child: Container(
          height: 102.h,
          width: 102.w,
          decoration: decorationImage(),
          child: AssetWidget(
            asset: Asset(type: AssetType.network, path: imageList[index]),
          ),
        ),
      ).paddingOnly(right: 5.w),
    );
  }
}
