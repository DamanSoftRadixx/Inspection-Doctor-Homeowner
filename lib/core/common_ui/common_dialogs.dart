import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart' as cupertino_dialog;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../constants/app_strings.dart';
import '../theme/app_color_palette.dart';
import 'text/app_text_widget.dart';

Future<void> showCommonAlertSingleButtonDialog(
    {required String title,
    required String subHeader,
    required String buttonTitle,
    Function()? okPressed}) async {
  // Get.back(closeOverlays: true);
  if (Get.isDialogOpen == null || Get.isDialogOpen == false) {
    Get.dialog(
      cupertino_dialog.CupertinoAlertDialog(
        title: Center(
          child: AppTextWidget(
            text: title,
            style: CustomTextTheme.normalText(
                color: lightColorPalette.primaryDarkblue),
            textAlign: TextAlign.center,
          ),
        ),
        content: AppTextWidget(
          text: subHeader,
          style: Theme.of(Get.context!).textTheme.bodyMedium!.copyWith(
              fontSize: 12.sp,
              color: lightColorPalette.secondarySwatch.shade900,
              fontWeight: FontWeight.w400,
              letterSpacing: -0.08,
              fontFamily: AppStrings.cancel),
          textAlign: TextAlign.center,
        ),
        actions: <CupertinoDialogAction>[
          CupertinoDialogAction(
            onPressed: okPressed,
            child: Center(
              child: AppTextWidget(
                text: buttonTitle,
                style: CustomTextTheme.normalText(
                    color: lightColorPalette.primaryDarkblue),
                textAlign: TextAlign.start,
              ),
            ),
          ),
        ],
      ),

      //      ),
      // ],
      //  )
    );
  }
}

Future<void> showCommonAlertWithTwoActionsDialog(
    {required String title,
    required String subHeader,
    String? leftButtonTitle,
    String? rightButtonTitle,
    required Function() okPressed}) async {
  // Get.back(closeOverlays: true);
  if (Get.isDialogOpen == null || Get.isDialogOpen == false) {
    Get.dialog(
      cupertino_dialog.CupertinoAlertDialog(
        title: Center(
          child: AppTextWidget(
            text: title,
            style: CustomTextTheme.normalText(
                color: lightColorPalette.primaryDarkblue),
            textAlign: TextAlign.center,
          ),
        ),
        content: AppTextWidget(
          text: subHeader,
          style: CustomTextTheme.normalText(
              color: lightColorPalette.primaryDarkblue),
          textAlign: TextAlign.center,
        ),
        actions: <CupertinoDialogAction>[
          CupertinoDialogAction(
            onPressed: () {
              Get.back();
            },
            child: AppTextWidget(
              text: leftButtonTitle ?? AppStrings.cancel,
              style: CustomTextTheme.normalText(
                  color: lightColorPalette.primaryDarkblue),
              textAlign: TextAlign.start,
            ),
          ),
          CupertinoDialogAction(
            onPressed: () {
              okPressed();
            },
            child: AppTextWidget(
              text: rightButtonTitle ?? AppStrings.ok,
              style: CustomTextTheme.normalText(
                  color: lightColorPalette.primaryDarkblue),
              textAlign: TextAlign.start,
            ),
          ),
        ],
      ),

      //      ),
      // ],
      //  )
    );
  }
}

/*showCupertinoModalPopup<void>(
    context: context,
    builder: (BuildContext context) => CupertinoAlertDialog(
      title: Center(
        child: AppTextWidget(
          text: title,
          style: Theme.of(Get.context!).textTheme.bodyText1!.copyWith(
              fontSize: 16.sp,
              color: lightColorPalette.primarySwatch.shade900,
              fontWeight: FontWeight.w600,
              fontFamily: CommonStrings.sfProFont),
          textAlign: TextAlign.center,
        ),
      ),
      content: AppTextWidget(
        text: subHeader,
        style: Theme.of(Get.context!).textTheme.bodyText2!.copyWith(
            fontSize: 13.sp,
            color: lightColorPalette.primarySwatch.shade700,
            fontWeight: FontWeight.w300,
            fontFamily: CommonStrings.sfProFont),
        textAlign: TextAlign.center,
      ),
      actions: <CupertinoDialogAction>[
        CupertinoDialogAction(
          onPressed: okPressed,
          child: AppTextWidget(
            text: "Ok",
            style: Theme.of(Get.context!).textTheme.bodyText1!.copyWith(
                fontSize: 17.sp,
                color: lightColorPalette.primarySwatch.shade800,
                fontWeight: FontWeight.w400,
                fontFamily: CommonStrings.sfProFont),
            textAlign: TextAlign.start,
          ),
        ),
      ],
    ),
  );*/
