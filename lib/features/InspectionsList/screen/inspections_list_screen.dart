import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/app_bar/common_appbar.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/common_button/common_button.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/common_loader/common_loader.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/text/app_text_widget.dart';
import 'package:inspection_doctor_homeowner/core/constants/app_strings.dart';
import 'package:inspection_doctor_homeowner/core/theme/app_color_palette.dart';
import 'package:inspection_doctor_homeowner/features/InspectionsList/controller/inspections_list_controller.dart';
import 'package:inspection_doctor_homeowner/features/schedule_an_Inspection/select_categories/model/network/category_list_response_model.dart';

class InspectionsListScreen extends GetView<InspectionsListController> {
  const InspectionsListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          backgroundColor: lightColorPalette.whiteColorPrimary.shade900,
          appBar: commonAppBarWithElevation(
              title: controller.argData.value.categoriesName ?? "",
              onPressBackButton: () {
                Get.back();
              }),
          body: SafeArea(
            child: Stack(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    getTopHeadingView(),
                    getSubCategories(),
                    showContinueButton()
                  ],
                ),
                CommonLoader(isLoading: controller.isShowLoader.value)
              ],
            ),
          ),
        ));
  }

  Expanded getSubCategories() {
    return Expanded(
      child: ListView.builder(
        shrinkWrap: true,
        padding: EdgeInsets.only(bottom: 50.h),
        itemCount: controller.categoriesList.length,
        itemBuilder: (BuildContext context, int index) {
          CategoryListResponseDataModel listData =
              controller.categoriesList[index];
          return listRowView(listData);
        },
      ),
    );
  }

  listRowView(CategoryListResponseDataModel listData) {
    return InkWell(
      focusColor: Colors.transparent,
      hoverColor: Colors.transparent,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () {
        controller.selectedCategory.value = listData;
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        height: 57.h,
        width: 1.sw,
        decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(
            color: lightColorPalette.grey,
            width: 0.3.w,
          )),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: AppTextWidget(
                textAlign: TextAlign.start,
                text: listData.name ?? "",
                style: CustomTextTheme.categoryText(
                  color: lightColorPalette.black,
                ),
              ),
            ),
            commonRadioButton(
                text: "",
                isSelected: listData.id == controller.selectedCategory.value.id,
                onTap: () {
                  controller.selectedCategory.value = listData;
                })
          ],
        ),
      ),
    );
  }

  getTopHeadingView() {
    return AppTextWidget(
      textAlign: TextAlign.start,
      text: AppStrings.pleaseSelectInspections.tr,
      style: CustomTextTheme.normalText(
        color: lightColorPalette.grey,
      ),
    ).paddingOnly(top: 20.h, bottom: 20.h);
  }

  Widget showContinueButton() {
    return CommonButton(
            commonButtonBottonText: AppStrings.continueBtn.tr,
            onPress: controller.selectedCategory.value.id != "" &&
                    controller.selectedCategory.value.id != null
                ? () {
                    controller.onPressContinueButton();
                  }
                : null)
        .paddingOnly(left: 20.w, right: 20.w, bottom: 17.h);
  }

  // categoryGridViewListItem({required int index}) {
  //   var listData = controller.categoriesList[index];

  //   return InkWell(
  //     focusColor: lightColorPalette.transparentColor,
  //     splashColor: lightColorPalette.transparentColor,
  //     hoverColor: lightColorPalette.transparentColor,
  //     onTap: () {
  //       controller.onPressCategoryItem(index: index);
  //     },
  //     child: Container(
  //       height: 57.h,
  //       width: 163.w,
  //       decoration: categioryDecoration(
  //           isSelected: controller.selectedCategory.value.id == listData.id),
  //       child: Row(
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         children: [
  //           controller.selectedCategory.value.id != listData.id
  //               ? SizedBox(
  //                   height: 18.h,
  //                   width: 18.w,
  //                 ).paddingOnly(right: 4.w, bottom: 1.h)
  //               : Padding(
  //                   padding: EdgeInsets.only(right: 4.w, bottom: 1.h),
  //                   child: AssetWidget(
  //                     color: Colors.green,
  //                     height: 18.h,
  //                     width: 18.w,
  //                     asset: Asset(
  //                         type: AssetType.svg, path: ImageResource.checked),
  //                   ),
  //                 ),
  //           AppTextWidget(
  //             textAlign: TextAlign.center,
  //             text: listData.name ?? "",
  //             style: CustomTextTheme.categoryText(
  //               color: lightColorPalette.black,
  //             ),
  //           ).paddingOnly(right: 18.w),
  //         ],
  //       ),
  //     ),
  //   );
  // }
}
