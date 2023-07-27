import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/common_button/custom_icon_button.dart';

import '../theme/app_color_palette.dart';
import 'text/app_text_widget.dart';

Future<void> showCommonAlertSingleButtonDialog(
    {required String title,
    required String subHeader,
    required String buttonTitle,
    bool? barrierDismissible,
    void Function()? okPressed}) async {
  if (Get.isDialogOpen == null || Get.isDialogOpen == false) {
    showDialog(
        barrierDismissible: barrierDismissible ?? false,
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
                                    color: lightColorPalette.black),
                                text: title,
                              ).paddingOnly(bottom: 12.h, top: 10.h),
                              AppTextWidget(
                                textAlign: TextAlign.center,
                                style: CustomTextTheme.bottomTabs(
                                    color: lightColorPalette.grey),
                                text: subHeader,
                              ).paddingOnly(bottom: 12.h),
                            ],
                          ).paddingOnly(left: 12.w, right: 12.w),
                        ),
                        Container(
                          width: 1.sw,
                          height: 0.6.h,
                          color: lightColorPalette.grey,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: CustomInkwell(
                                onTap: okPressed,
                                child: Center(
                                  child: AppTextWidget(
                                    style: CustomTextTheme.heading2(
                                        color: lightColorPalette.black),
                                    text: buttonTitle,
                                  ),
                                ),
                              ),
                            )
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
}

Future<void> showCommonAlertWithTwoActionsDialog(
    {required String title,
    required String subHeader,
    String? leftButtonTitle,
    String? rightButtonTitle,
    bool? barrierDismissible,
    required Function() noPressed,
    required Function() yesPressed}) async {
  showDialog(
      barrierDismissible: barrierDismissible ?? false,
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
                                  color: lightColorPalette.black),
                              text: title,
                            ).paddingOnly(bottom: 12.h, top: 10.h),
                            AppTextWidget(
                              textAlign: TextAlign.center,
                              style: CustomTextTheme.normalText(
                                  color: lightColorPalette.grey),
                              text: subHeader,
                            ).paddingOnly(bottom: 12.h),
                          ],
                        ).paddingOnly(left: 12.w, right: 12.w),
                      ),
                      Container(
                        width: 1.sw,
                        height: 0.6.h,
                        color: lightColorPalette.grey,
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
                            color: lightColorPalette.grey,
                          ),
                          Expanded(
                              child: CustomInkwell(
                            onTap: yesPressed,
                            child: Container(
                              child: Center(
                                child: AppTextWidget(
                                  style: CustomTextTheme.heading2(
                                      color: lightColorPalette.black),
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
