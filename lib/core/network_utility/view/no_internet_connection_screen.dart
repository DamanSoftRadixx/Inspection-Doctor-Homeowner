import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../common_ui/text/app_text_widget.dart';
import '../../constants/app_strings.dart';
import '../../constants/common_strings.dart';
import '../../theme/app_color_palette.dart';

class NoInternetConnectionScreen extends StatelessWidget {
  const NoInternetConnectionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        width: 1.sw,
        decoration: const BoxDecoration(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 30.h,
            ),
            AppTextWidget(
              text: AppStrings.strNoInternetConnection.tr,
              style: Theme.of(Get.context!).textTheme.displayLarge!.copyWith(
                  fontSize: 17.sp,
                  color: lightColorPalette.primarySwatch.shade900,
                  fontWeight: FontWeight.w600,
                  fontFamily: CommonStrings.generalSans),
              textAlign: TextAlign.start,
            ),
            SizedBox(
              height: 7.h,
            ),
            AppTextWidget(
              text: AppStrings.strPleaseCheckYourInternetConnectivity.tr,
              style: Theme.of(Get.context!).textTheme.displayLarge!.copyWith(
                  fontSize: 12.sp,
                  color: lightColorPalette.primarySwatch.shade800,
                  fontWeight: FontWeight.w400,
                  fontFamily: CommonStrings.generalSans),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20.h),
          ],
        ).paddingSymmetric(horizontal: 9.w),
      ).paddingSymmetric(horizontal: 16.w, vertical: 30.h),
    );
  }
}
