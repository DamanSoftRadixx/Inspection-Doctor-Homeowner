import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/common_button/custom_icon_button.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/text/app_text_widget.dart';
import 'package:inspection_doctor_homeowner/core/theme/app_color_palette.dart';

Future<void> showCommonAlertWithTwoActionsDialog(
    {required String title,
    required String subHeader,
    String? leftButtonTitle,
    String? rightButtonTitle,
    required Function() noPressed,
    required Function() yesPressed}) async {
  // Get.back(closeOverlays: true);
  showDialog(
      context: Get.context!,
      builder: (BuildContext context) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Dialog(
                shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(10.0.r)), //this right here
                child: SizedBox(
                  width: 1.sw,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            AppTextWidget(
                              style: CustomTextTheme.heading2(
                                  color: lightColorPalette.primaryDarkblue),
                              text: title,
                            ).paddingOnly(bottom: 12.h, top: 10.h),
                            AppTextWidget(
                              style: CustomTextTheme.normalText(
                                  color: lightColorPalette.primaryGrey),
                              text: subHeader,
                            ).paddingOnly(bottom: 12.h),
                          ],
                        ).paddingOnly(left: 12.w, right: 12.w),
                      ),
                      Container(
                        width: 1.sw,
                        height: 0.6.h,
                        color: lightColorPalette.stroke,
                      ),
                      Row(
                        children: [
                          Expanded(
                              child: CustomInkwell(
                            onTap: noPressed,
                            child: Container(
                              child: Center(
                                child: AppTextWidget(
                                  style: CustomTextTheme.heading2(
                                      color: lightColorPalette.redDark),
                                  text: leftButtonTitle ?? "No",
                                ),
                              ),
                            ),
                          )),
                          Container(
                            width: 0.6.w,
                            height: 50.h,
                            color: lightColorPalette.stroke,
                          ),
                          Expanded(
                              child: CustomInkwell(
                            onTap: yesPressed,
                            child: Container(
                              child: Center(
                                child: AppTextWidget(
                                  style: CustomTextTheme.heading2(
                                      color: lightColorPalette.primaryBlue),
                                  text: rightButtonTitle ?? "Yes",
                                ),
                              ),
                            ),
                          ))
                        ],
                      )
                    ],
                  ).paddingOnly(top: 12.h),
                ),
              ),
            ],
          ),
        );
      });
}
