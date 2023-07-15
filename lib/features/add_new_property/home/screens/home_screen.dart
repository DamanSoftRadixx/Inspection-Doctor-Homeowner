import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:inspection_doctor_homeowner/core/common_functionality/dismiss_keyboard.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/asset_widget/common_image_widget.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/common_button/common_button.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/common_loader/common_loader.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/refresh_indicator/common_refresh_indicator.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/text/app_text_widget.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/textfields/app_common_text_form_field.dart';
import 'package:inspection_doctor_homeowner/core/constants/app_strings.dart';
import 'package:inspection_doctor_homeowner/core/theme/app_color_palette.dart';
import 'package:inspection_doctor_homeowner/core/utils/image_resources.dart';
import 'package:inspection_doctor_homeowner/core/utils/ui_utils.dart';
import 'package:inspection_doctor_homeowner/features/add_new_property/home/controller/home_controller.dart';
import 'package:inspection_doctor_homeowner/features/add_new_property/home/model/network_model/property_list_response_model.dart';
import 'package:inspection_doctor_homeowner/features/add_new_property/home/widget/property_card.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          backgroundColor: lightColorPalette.backgroundColor,
          floatingActionButton: showFloatingButton(),
          body: SafeArea(
            child: Stack(
              children: [
                GestureDetector(
                  onTap: () {
                    dismissKeyboard();
                  },
                  child: controller.propertyList.isEmpty &&
                          controller.isShowLoader.value == false &&
                          controller.isShowNoDataFound.value == false
                      ? showAddProperty()
                      : showPropertyUi(),
                ),
                CommonLoader(isLoading: controller.isShowLoader.value)
              ],
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
        onChanged: (value) {
          controller.onSeacrh(value);
        },
        focusNode: controller.seacrhFocusNode.value,
        searchHint: AppStrings.searchNameAddress);
  }

  Expanded showPropertyList() {
    return Expanded(
        child: controller.propertyList.isNotEmpty
            ? CommonRefreshIndicator(
                onRefresh: () => Future.sync(() {
                      controller.onRefresh();
                    }),
                controller: controller.refreshController,
                child: ListView.builder(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.only(top: 18.h),
                  shrinkWrap: true,
                  controller: controller.listController,
                  itemCount: controller.propertyList.length,
                  itemBuilder: (BuildContext context, int index) {
                    PropertyListData item = controller.propertyList[index];

                    return PropertyCard(property: item);
                  },
                ))
            : CommonRefreshIndicator(
                onRefresh: () => Future.sync(() {
                  controller.onRefresh();
                }),
                controller: controller.refreshController,
                child: ListView(
                  children: [
                    Align(
                        alignment: Alignment.center,
                        child: somethingWentWrongWidget(
                            text: AppStrings.alert,
                            image: ImageResource.selectedHomeIcon)),
                  ],
                ),
              ));
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
