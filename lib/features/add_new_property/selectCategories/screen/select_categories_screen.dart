import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/app_bar/common_appbar.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/asset_widget/common_image_widget.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/common_button/common_button.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/common_loader/common_loader.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/text/app_text_widget.dart';
import 'package:inspection_doctor_homeowner/core/constants/app_strings.dart';
import 'package:inspection_doctor_homeowner/core/theme/app_color_palette.dart';
import 'package:inspection_doctor_homeowner/core/utils/image_resources.dart';
import 'package:inspection_doctor_homeowner/features/add_new_property/selectCategories/controller/select_categories_controller.dart';

class SelectCategoriesScreen extends GetView<SelectedCategoriesController> {
  const SelectCategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightColorPalette.whiteColorPrimary.shade900,
      appBar: commonAppBarWithElevation(
          title: AppStrings.categories.tr,
          onPressBackButton: () {
            Get.back();
          }),
      body: Obx(() => SafeArea(
            child: Stack(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    getTopHeadingView(),
                    categoryGridviewList(),
                    showContinueButton(),
                  ],
                ).paddingOnly(left: 20.w, right: 20.w),
                CommonLoader(isLoading: controller.isShowLoader.value)
              ],
            ),
          )),
    );
  }

  categoryGridviewList() {
    return Expanded(
      child: AlignedGridView.count(
        crossAxisCount: 2,
        itemCount: controller.categoriesList.length,
        mainAxisSpacing: 8.5.h,
        crossAxisSpacing: 15.w,
        itemBuilder: (context, index) {
          return categoryGridViewListItem(index: index);
        },
      ),
    );
  }

  getTopHeadingView() {
    return AppTextWidget(
      textAlign: TextAlign.start,
      text: AppStrings.pleaseSelectCategory.tr,
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
        .paddingOnly(bottom: 17.h);
  }

  categoryGridViewListItem({required int index}) {
    var listData = controller.categoriesList[index];

    return InkWell(
      focusColor: lightColorPalette.transparentColor,
      splashColor: lightColorPalette.transparentColor,
      hoverColor: lightColorPalette.transparentColor,
      onTap: () {
        controller.onPressCategoryItem(index: index);
      },
      child: Container(
        height: 57.h,
        width: 163.w,
        decoration: categioryDecoration(
            isSelected: listData.id == controller.selectedCategory.value.id),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            listData.id != controller.selectedCategory.value.id
                ? SizedBox(
                    height: 18.h,
                    width: 18.w,
                  ).paddingOnly(right: 4.w, bottom: 1.h)
                : Padding(
                    padding: EdgeInsets.only(right: 4.w, bottom: 1.h),
                    child: AssetWidget(
                      color: Colors.green,
                      height: 18.h,
                      width: 18.w,
                      asset: Asset(
                          type: AssetType.svg, path: ImageResource.checked),
                    ),
                  ),
            Flexible(
              child: AppTextWidget(
                textAlign: TextAlign.center,
                text: listData.name ?? "",
                style: CustomTextTheme.categoryText(
                  color: lightColorPalette.black,
                ),
              ).paddingOnly(right: 18.w),
            ),
          ],
        ),
      ),
    );
  }
}
