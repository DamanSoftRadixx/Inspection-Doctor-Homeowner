import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:inspection_doctor_homeowner/core/common_functionality/dismiss_keyboard.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/asset_widget/common_image_widget.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/common_button/common_button.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/common_button/custom_icon_button.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/common_loader/common_loader.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/text/app_text_widget.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/textfields/app_common_text_form_field.dart';
import 'package:inspection_doctor_homeowner/core/constants/app_strings.dart';
import 'package:inspection_doctor_homeowner/core/routes/routes.dart';
import 'package:inspection_doctor_homeowner/core/theme/app_color_palette.dart';
import 'package:inspection_doctor_homeowner/core/utils/image_resources.dart';
import 'package:inspection_doctor_homeowner/features/add_new_property/home/controller/home_controller.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          backgroundColor: lightColorPalette.backgroundColor,
          floatingActionButton: controller.homeList.isNotEmpty
              ? showFloatingButton()
              : const SizedBox(),
          body: SafeArea(
            child: GestureDetector(
              onTap: () {
                dismissKeyboard();
              },
              child: controller.homeList.isEmpty
                  ? showAddProperty()
                  : showPropertyUi(),
            ),
          ),
        ));
  }

  SizedBox showFloatingButton() {
    return SizedBox(
      height: 56.h,
      width: 56.w,
      child: FittedBox(
        child: FloatingActionButton(
          onPressed: () {
            controller.onPressAddPropertyButton();
          },
          backgroundColor: lightColorPalette.primaryBlue,
          child: const Icon(
            Icons.add,
            size: 35,
          ),
        ),
      ),
    );
  }

  showPropertyUi() {
    return Column(
      children: [
        showSearchBar()
            .paddingOnly(top: 10.h, left: 20.w, right: 20.w, bottom: 02.h),
        showPropertyList(),
      ],
    );
  }

  Widget showSearchBar() {
    return commonSearchFieldWidget(
        controller: controller.searchController,
        onChanged: (value) {},
        focusNode: controller.seacrhFocusNode.value,
        searchHint: AppStrings.searchNameAddress);
  }

  Expanded showPropertyList() {
    return Expanded(
      child: ListView.builder(
        padding: EdgeInsets.only(top: 18.h),
        shrinkWrap: true,
        physics: const RangeMaintainingScrollPhysics(),
        itemCount: 10,
        itemBuilder: (BuildContext context, int index) {
          return CustomInkwell(
            padding: EdgeInsets.zero,
            onTap: () {
              Get.toNamed(Routes.propertyDetailScreen);
            },
            child: Container(
              margin: EdgeInsets.only(bottom: 20.h, left: 20.w, right: 20.w),
              padding: EdgeInsets.only(
                  left: 20.w, top: 15.h, right: 20.w, bottom: 14.h),
              decoration: decorationHome(),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: AppTextWidget(
                          style: CustomTextTheme.heading3(
                              color: lightColorPalette.primaryDarkblue),
                          text: "ABC Property name",
                        ),
                      ),
                      Row(
                        children: [
                          index == 0
                              ? AssetWidget(
                                  asset: Asset(
                                    type: AssetType.svg,
                                    path: ImageResource.updateIcon,
                                  ),
                                ).paddingOnly(right: 10.w)
                              : const SizedBox(),
                          AssetWidget(
                            asset: Asset(
                              type: AssetType.svg,
                              path: ImageResource.forwordArrow,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      AssetWidget(
                        asset: Asset(
                          type: AssetType.svg,
                          path: ImageResource.pinLocation,
                        ),
                      ).paddingOnly(right: 5.w),
                      Expanded(
                        child: AppTextWidget(
                          style: CustomTextTheme.normalText(
                              color: lightColorPalette.primaryGrey),
                          text: "4001 Anderson Road, Nashville TN 37217",
                        ),
                      ),
                    ],
                  ).paddingOnly(top: 12.h, bottom: 12.h),
                  Divider(
                    color: lightColorPalette.stroke,
                    height: 0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                      ),
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AppTextWidget(
                            style: CustomTextTheme.normalText(
                                color: lightColorPalette.primaryDarkblue),
                            text: '\u2022 ',
                          ),
                          AppTextWidget(
                            style: CustomTextTheme.normalText(
                                color: lightColorPalette.primaryDarkblue),
                            text: "Scheduled",
                          ),
                        ],
                      ),
                    ],
                  ).paddingOnly(top: 12.h)
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Stack showAddProperty() {
    return Stack(
      children: [
        SizedBox(
          width: 1.sw,
          child: AssetWidget(
            asset: Asset(
              type: AssetType.svg,
              path: ImageResource.addPropertyBackgroundImage,
            ),
            boxFit: BoxFit.fill,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    addPropertyWidget(),
                  ],
                ),
              ),
            ],
          ),
        ),
        Obx(() => CommonLoader(isLoading: controller.isLoading.value))
      ],
    );
  }

  addPropertyWidget() {
    return Container(
      width: 1.sw,
      padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 40.h),
      decoration: decorationWithElevationOnly(),
      child: Column(
        children: [
          AssetWidget(
            asset: Asset(
              type: AssetType.svg,
              path: ImageResource.addPropertyImage,
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
          AppTextWidget(
            textAlign: TextAlign.center,
            text: AppStrings.addPropertiesForInspection.tr,
            style: CustomTextTheme.heading1WithLetterSpacing(
                color: lightColorPalette.primaryDarkblue),
          ),
          SizedBox(
            height: 10.h,
          ),
          AppTextWidget(
            textAlign: TextAlign.center,
            text: AppStrings.youHaveNotAddedPropertyYet.tr,
            style: CustomTextTheme.normalText(
                color: lightColorPalette.primaryGrey),
          ),
          SizedBox(
            height: 14.h,
          ),
          CommonButton(
              commonButtonBottonText: AppStrings.addPropertyButton.tr,
              onPress: () {
                controller.onPressAddPropertyButton();
              })
        ],
      ),
    );
  }
}
