import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/common_button/custom_icon_button.dart';
import 'package:inspection_doctor_homeowner/core/constants/app_strings.dart';

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
                              child: CustomTapState(
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
                              child: CustomTapState(
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
                              child: CustomTapState(
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

Future<void> showNoInternetDialog() async {
  Get.dialog(
      Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: WillPopScope(
            onWillPop: () async => true,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 1.sw,
                  margin: EdgeInsets.symmetric(horizontal: 20.w),
                  padding:
                      EdgeInsets.symmetric(horizontal: 30.w, vertical: 40.h),
                  decoration: decorationWithElevationOnly(),
                  child: Column(
                    children: [
                      const Icon(EvaIcons.wifiOff, size: 80),
                      AppTextWidget(
                        textAlign: TextAlign.center,
                        text: AppStrings.connectionLost.tr,
                        style: CustomTextTheme.heading1WithLetterSpacing(
                            color: lightColorPalette.black),
                      ),
                      SizedBox(height: 10.h),
                      AppTextWidget(
                        textAlign: TextAlign.center,
                        text: AppStrings.connectionLostMSG.tr,
                        style: CustomTextTheme.normalText(
                            color: lightColorPalette.grey),
                      ),
                      CustomTapState(
                        padding: EdgeInsets.only(top: 20.h),
                        onTap: () {
                          Get.back();
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Center(
                              child: AppTextWidget(
                                textAlign: TextAlign.center,
                                style: CustomTextTheme.heading2(
                                    color: lightColorPalette.black),
                                text: AppStrings.ok,
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      barrierDismissible: true);
}
