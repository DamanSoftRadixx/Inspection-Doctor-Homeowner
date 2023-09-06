import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:inspection_doctor_homeowner/core/common_functionality/logout/logout_functionality.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/asset_widget/common_image_widget.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/common_button/common_button.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/common_dialogs.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/common_loader/common_loader.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/common_no_data_found/common_no_data_found.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/text/app_text_widget.dart';
import 'package:inspection_doctor_homeowner/core/constants/app_strings.dart';
import 'package:inspection_doctor_homeowner/core/theme/app_color_palette.dart';
import 'package:inspection_doctor_homeowner/core/utils/enum.dart';
import 'package:inspection_doctor_homeowner/core/utils/foundation.dart';
import 'package:inspection_doctor_homeowner/core/utils/image_resources.dart';
import 'package:inspection_doctor_homeowner/features/add_new_property/home/controller/home_controller.dart';
import 'package:inspection_doctor_homeowner/features/add_new_property/home/screens/home_screen.dart';
import 'package:inspection_doctor_homeowner/features/dashboard/screen/dashboard_screen.dart';
import 'package:inspection_doctor_homeowner/features/notification/controller/notification_controller.dart';
import 'package:inspection_doctor_homeowner/features/notification/screens/notification_screen.dart';

extension DashboardScreenExtension on DashBoardScreen {
  bottomWidget() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          height: isIos ? 84.h : 70.h,
          width: 1.sw,
          padding: EdgeInsets.only(bottom: 8.h),
          decoration: BoxDecoration(
              color: lightColorPalette.whiteColorPrimary.shade900,
              border: Border(
                  top: BorderSide(color: lightColorPalette.grey, width: 0.3))),
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
        ),
      ],
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
                    color: lightColorPalette.black,
                  ),
                ).paddingOnly(bottom: 8.h),
              ),
              Obx(() => Stack(
                    clipBehavior: Clip.none,
                    children: [
                      AssetWidget(
                        // color: check == controller.bottomNavigationEnum.value
                        //     ? lightColorPalette.black
                        //     : lightColorPalette.grey,
                        asset: Asset(
                          type: AssetType.svg,
                          path: check == controller.bottomNavigationEnum.value
                              ? iconDark
                              : icon,
                        ),
                        width: 25.w,
                        height: 25.h,
                      ).paddingOnly(bottom: 3.53.h),
                    ],
                  )),
              AppTextWidget(
                  text: title,
                  style: CustomTextTheme.bottomTabs(
                      color: check == controller.bottomNavigationEnum.value
                          ? lightColorPalette.black
                          : lightColorPalette.grey))
            ],
          ),
        ),
      ),
    );
  }

  Widget tabScreens() {
    if (controller.bottomNavigationEnum.value == BottomNavigationEnum.Home) {
      Get.put(HomeController());
      return const HomeScreen();
    } else if (controller.bottomNavigationEnum.value ==
        BottomNavigationEnum.Inspections) {
      Get.delete<HomeController>();
      /* Get.put(EstimatesController());
      return EstimatesScreen();*/
      return commonNoDataWidget();
    } else if (controller.bottomNavigationEnum.value ==
        BottomNavigationEnum.Notification) {
      if (Get.isRegistered<HomeController>()) {
        Get.delete<HomeController>();
      }

      Get.put(NotificationController());

      return const NotificationScreen();
    } else if (controller.bottomNavigationEnum.value ==
        BottomNavigationEnum.MyProfile) {
      Get.delete<HomeController>();
      /*Get.put(ProfileScreenController());
      return ProfileScreen();*/
      return WillPopScope(
        onWillPop: () async => false,
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CommonButton(
                    commonButtonBottonText: AppStrings.logout.tr,
                    onPress: () {
                      showCommonAlertWithTwoActionsDialog(
                          title: AppStrings.alert.tr,
                          leftButtonTitle: AppStrings.no.tr,
                          rightButtonTitle: AppStrings.yes.tr,
                          subHeader: AppStrings.areYouWantLogout.tr,
                          noPressed: () {
                            Get.back();
                          },
                          yesPressed: () async {
                            try {
                              controller.isLoading.value = true;
                              controller.isLoading.refresh();
                              Get.back();
                              await logoutFunctionality();
                            } catch (e) {
                              controller.isLoading.value = false;
                              controller.isLoading.refresh();
                            }
                          });
                    }).paddingOnly(bottom: 50.h, left: 20.w, right: 20.w),
              ],
            ),
            CommonLoader(isLoading: controller.isLoading.value)
          ],
        ),
      );
    } else {
      return commonNoDataWidget();
    }
  }
}
