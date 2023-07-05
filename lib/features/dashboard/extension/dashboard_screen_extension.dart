
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/asset_widget/common_image_widget.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/common_no_data_found/common_no_data_found.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/text/app_text_widget.dart';
import 'package:inspection_doctor_homeowner/core/constants/app_strings.dart';
import 'package:inspection_doctor_homeowner/core/theme/app_color_palette.dart';
import 'package:inspection_doctor_homeowner/core/utils/enum.dart';
import 'package:inspection_doctor_homeowner/core/utils/image_resources.dart';
import 'package:inspection_doctor_homeowner/features/add_new_property/home/controller/home_controller.dart';
import 'package:inspection_doctor_homeowner/features/add_new_property/home/screens/home_screen.dart';
import 'package:inspection_doctor_homeowner/features/dashboard/screen/dashboard_screen.dart';

extension DashboardScreenExtension on DashBoardScreen {

  bottomWidget(){
    return Container(
      // height: 84.h,
      width: 1.sw,
      padding: EdgeInsets.only(bottom: 8.h),
      decoration: BoxDecoration(
          color: lightColorPalette.whiteColorPrimary.shade900,
          border: Border(
              top: BorderSide(
                  color: lightColorPalette.stroke,
                  width: 0.3))),
      child: Row(
        children: [
          bottomRow(
            title: AppStrings.homeTab.tr,
            icon: ImageResource.unSelectedHomeIcon,
            iconDark: ImageResource.selectedHomeIcon,
            check: BottomNavigationEnum.Home,
          ),
          bottomRow(
              title: AppStrings.inspectionsTab.tr,
              icon: ImageResource.unSelectedInspectionsIcon,
              iconDark: ImageResource.selectedInspectionsIcon,
              check: BottomNavigationEnum.Inspections),
          bottomRow(
              title: AppStrings.notificationTab.tr,
              icon: ImageResource.unSelectedNotificationsIcon,
              iconDark: ImageResource.selectedNotificationsIcon,
              check: BottomNavigationEnum.Notification),
          bottomRow(
              title: AppStrings.myProfileTab.tr,
              icon: ImageResource.unSelectedProfileIcon,
              iconDark: ImageResource.selectedProfileIcon,
              check: BottomNavigationEnum.MyProfile),
        ],
      ),
    );
  }

  bottomRow(
      {required String title,
        required String icon,
        required String iconDark,
        required BottomNavigationEnum check}) {
    return Expanded(
      child: InkWell(
        onTap: () {
          controller.onTapTabBar(check: check);
        },
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Opacity(
                opacity: check == controller.bottomNavigationEnum.value ? 1 : 0,
                child: Container(
                  height: 4.h,
                  width: 51.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(5.r)),
                    color: lightColorPalette.primaryBlue,
                  ),
                ).paddingOnly(bottom: 8.h),
              ),
              Obx(() => Stack(
                clipBehavior: Clip.none,
                children: [
                  AssetWidget(
                    asset: Asset(
                        type: AssetType.svg,
                        path: check == controller.bottomNavigationEnum.value
                            ? iconDark
                            : icon),
                    width: 20.w,height: 20.h,
                  ).paddingOnly(bottom: 3.53.h),
                ],
              )),
              AppTextWidget(
                  text: title,
                  style: CustomTextTheme.bottomTabs(
                      color: check == controller.bottomNavigationEnum.value
                          ? lightColorPalette.primaryBlue
                          : lightColorPalette.primaryGrey))
            ],
          ),
        ),
      ),
    );
  }

  Widget tabScreens() {

    if (controller.bottomNavigationEnum.value == BottomNavigationEnum.Home) {
      Get.put(HomeController());
      return HomeScreen();
    } else if(controller.bottomNavigationEnum.value == BottomNavigationEnum.Inspections){
     /* Get.put(EstimatesController());
      return EstimatesScreen();*/
      return commonNoDataWidget();
    }else if(controller.bottomNavigationEnum.value == BottomNavigationEnum.Notification){
      /*Get.put(DealersListController());
      return DealersListScreen();*/
      return commonNoDataWidget();
    }else if(controller.bottomNavigationEnum.value == BottomNavigationEnum.MyProfile){
      /*Get.put(ProfileScreenController());
      return ProfileScreen();*/
      return commonNoDataWidget();
    }else{
      return commonNoDataWidget();
    }

  }


}