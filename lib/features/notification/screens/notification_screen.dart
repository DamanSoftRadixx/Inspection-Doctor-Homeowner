import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/common_button/custom_icon_button.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/common_loader/common_loader.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/refresh_indicator/common_refresh_indicator.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/text/app_text_widget.dart';
import 'package:inspection_doctor_homeowner/core/constants/app_strings.dart';
import 'package:inspection_doctor_homeowner/core/date_formatter/date_formatter.dart';
import 'package:inspection_doctor_homeowner/core/theme/app_color_palette.dart';
import 'package:inspection_doctor_homeowner/features/notification/controller/notification_controller.dart';
import 'package:inspection_doctor_homeowner/features/notification/extensions/no_notification.dart';
import 'package:inspection_doctor_homeowner/features/notification/model/network/notification_response_model.dart';

class NotificationScreen extends GetView<NotificationController> {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightColorPalette.whiteColorPrimary.shade900,
      body: Obx(() => Stack(
            children: [
              CommonRefreshIndicator(
                onRefresh: () => Future.sync(() {
                  controller.onRefreshnotifications();
                }),
                controller: controller.notificationRefreshController,
                child: controller.notificationList.isEmpty
                    ? (controller.isShowScheduledLoader.value ||
                            controller.isShowOnInitLoader.value
                        ? Container()
                        : noCardAddedYetWidget())
                    : ListView.builder(
                        itemCount: controller.notificationList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return showNotificationCard(
                              index: index,
                              notificationList: controller.notificationList);
                        },
                      ),
              ),
              Visibility(
                  visible: controller.notificationLoadMore.value == true,
                  child: const CircularProgressIndicator()),
              CommonLoader(
                isLoading: controller.isShowScheduledLoader.value ||
                    controller.isShownotificationLoader.value ||
                    controller.isShowOnInitLoader.value,
              )
            ],
          )),
    );
  }

  Widget showNotificationCard(
      {required int index,
      required List<NotificationResponseModelData> notificationList}) {
    NotificationResponseModelData data = notificationList[index];
    return CustomInkwell(
      padding: EdgeInsets.zero,
      onTap: () {
        controller.onTapCard(
            inspectionId: data.inspectionId ?? "", id: data.id ?? "");
      },
      child: Container(
        margin: EdgeInsets.only(top: 10.h, left: 20.w, right: 20.w),
        padding:
            EdgeInsets.only(left: 20.w, right: 20.w, top: 14.h, bottom: 12.h),
        decoration: decorationHome(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                AppTextWidget(
                  style: CustomTextTheme.normalTextWithWeight600(
                      color: lightColorPalette.black),
                  text: data.title ?? "",
                ),

                //status
                Visibility(
                  visible: data.readStatus == 0,
                  child: Container(
                    margin: EdgeInsets.only(left: 3.w),
                    height: 7.h,
                    width: 7.w,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: lightColorPalette.red1),
                  ),
                )
              ],
            ),
            AppTextWidget(
              style: CustomTextTheme.normalText(
                  color: lightColorPalette.black.withOpacity(0.9)),
              text: data.message ?? "",
            ),
            SizedBox(height: 6.h),
            AppTextWidget(
              style: CustomTextTheme.normalText(color: lightColorPalette.grey),
              text: controller.compairDate(data)
                  ? AppStrings.today
                  : getLocalDateFromUtc(dateString: data.createdAt ?? ""),
            )
          ],
        ),
      ),
    );
  }
}
