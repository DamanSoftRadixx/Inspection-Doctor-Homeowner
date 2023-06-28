import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/app_text_widget.dart';
import 'package:inspection_doctor_homeowner/core/constants/common_strings.dart';
import 'package:inspection_doctor_homeowner/core/theme/app_color_palette.dart';

import '../constants/app_strings.dart';
import '../utils/image_resources.dart';
import 'asset.dart';
import 'common_image_widget.dart';
import 'custom_icon_button.dart';

Future<void> showCommonAlertSingleButtonDialog(
    {required String title,
    required String subHeader,
    Function()? okPressed}) async {
  if (Get.isDialogOpen == null || Get.isDialogOpen == false) {
    Get.dialog(
      AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(24.r),
              topRight: Radius.circular(24.r)),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AppTextWidget(
              text: title,
              style: Theme.of(Get.context!).textTheme.bodyLarge!.copyWith(
                  fontSize: 16.sp,
                  color: lightColorPalette.additionalSwatch1.shade900,
                  fontWeight: FontWeight.w600,
                  fontFamily: CommonStrings.vitnamPro),
              textAlign: TextAlign.center,
            ),
            CustomIconButton(
              icon: AssetWidget(
                color: lightColorPalette.additionalSwatch1.shade900,
                asset: Asset(path: ImageResource.cross, type: AssetType.svg),
              ),
              onPressed: () {
                Get.back();
              },
            )
          ],
        ),
        content: AppTextWidget(
            text: subHeader,
            style: Theme.of(Get.context!).textTheme.bodyLarge!.copyWith(
                fontSize: 13.sp,
                color: lightColorPalette.additionalSwatch1.shade900,
                fontWeight: FontWeight.w400,
                fontFamily: CommonStrings.vitnamPro)),
      ),
      barrierDismissible: false,
    );
  }
}

Future<void> showCommonAlertWithTwoActionsDialog(
    {required String title,
    required String subHeader,
    required Function() okPressed}) async {
  if (Get.isDialogOpen == null || Get.isDialogOpen == false) {
    Get.dialog(
      AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(24.r),
              topRight: Radius.circular(24.r)),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AppTextWidget(
              text: title,
              style: Theme.of(Get.context!).textTheme.bodyLarge!.copyWith(
                  fontSize: 18.sp,
                  color: lightColorPalette.additionalSwatch1.shade900,
                  fontWeight: FontWeight.w600,
                  fontFamily: CommonStrings.vitnamPro),
              textAlign: TextAlign.center,
            ),
            CustomIconButton(
              icon: AssetWidget(
                color: lightColorPalette.additionalSwatch1.shade900,
                asset: Asset(path: ImageResource.cross, type: AssetType.svg),
              ),
              onPressed: () {
                Get.back();
              },
            )
          ],
        ),
        content: AppTextWidget(
            text: subHeader,
            style: Theme.of(Get.context!).textTheme.bodyMedium!.copyWith(
                fontSize: 13.sp,
                color: lightColorPalette.additionalSwatch1.shade900,
                fontWeight: FontWeight.w400,
                fontFamily: CommonStrings.vitnamPro)),
        actions: <Widget>[
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.r)),
                padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 22.w),
                backgroundColor: lightColorPalette.primarySwatch.shade900,
              ),
              onPressed: okPressed,
              child: AppTextWidget(
                text: AppStrings.ok.tr,
                style: Theme.of(Get.context!).textTheme.bodyLarge!.copyWith(
                    fontSize: 14.sp,
                    color: lightColorPalette.whiteColorPrimary.shade900,
                    fontWeight: FontWeight.w600,
                    fontFamily: CommonStrings.vitnamPro),
              )).paddingOnly(right: 17.w, bottom: 8.h),
        ],
      ),
      barrierDismissible: false,
    );
  }
}

insufficientBalanceDialog() async {
  showCommonAlertSingleButtonDialog(
      title: "Insufficient Balance",
      subHeader: "Get more sparks to continue using this feature");
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
