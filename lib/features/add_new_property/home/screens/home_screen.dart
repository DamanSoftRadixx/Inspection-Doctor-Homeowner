import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:inspection_doctor_homeowner/core/common_functionality/dismiss_keyboard.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/asset_widget/common_image_widget.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/common_button/common_button.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/common_loader/common_loader.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/text/app_text_widget.dart';
import 'package:inspection_doctor_homeowner/core/constants/app_strings.dart';
import 'package:inspection_doctor_homeowner/core/theme/app_color_palette.dart';
import 'package:inspection_doctor_homeowner/core/utils/image_resources.dart';
import 'package:inspection_doctor_homeowner/features/add_new_property/home/controller/home_controller.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightColorPalette.backgroundColor,
      body: SafeArea(
        child: GestureDetector(
          onTap: () {
            dismissKeyboard();
          },
          child: Stack(
            children: [
              Container(
                width: 1.sw,
                child: AssetWidget(
                  asset:
                  Asset(type: AssetType.svg,
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
                          addPropertyWidget()
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Obx(() => controller.isLoading.value == true
                  ? const CommonLoader()
                  : Container())
            ],
          ),
        ),
      ),
    );
  }

  addPropertyWidget(){
    return Container(
      width: 1.sw,
      padding: EdgeInsets.symmetric(horizontal: 30.w,vertical: 40.h),
      decoration: decorationWithElevationOnly(),
      child: Column(
        children: [
          AssetWidget(
            asset:
            Asset(type: AssetType.svg,
              path: ImageResource.addPropertyImage,
            ),
          ),
          SizedBox(height: 20.h,),
          AppTextWidget(
            textAlign: TextAlign.center,
            text: AppStrings.addPropertiesForInspection.tr,
            style: CustomTextTheme.heading1WithLetterSpacing(
                color: lightColorPalette.primaryDarkblue),
          ),
          SizedBox(height: 10.h,),
          AppTextWidget(
            textAlign: TextAlign.center,
            text: AppStrings.youHaveNotAddedPropertyYet.tr,
            style: CustomTextTheme.normalText(
                color: lightColorPalette.primaryGrey),
          ),
          SizedBox(height: 14.h,),
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
