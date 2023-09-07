import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/asset_widget/common_image_widget.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/common_button/custom_icon_button.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/text/app_text_widget.dart';
import 'package:inspection_doctor_homeowner/core/constants/app_strings.dart';
import 'package:inspection_doctor_homeowner/core/utils/image_resources.dart';

import '../../theme/app_color_palette.dart';

AppBar commonAppBarWithElevation(
    {required String title,
    bool isShowBackButton = true,
    Function()? onPressBackButton,
    Widget? centerWidget}) {
  return AppBar(
    leading: isShowBackButton
        ? CustomInkwell(
            onTap: () {
              if (onPressBackButton != null) onPressBackButton();
            },
            child: AssetWidget(
              color: lightColorPalette.black,
              asset: Asset(type: AssetType.svg, path: ImageResource.backArrow),
              boxFit: BoxFit.fitWidth,
            ))
        : AssetWidget(
            asset: Asset(type: AssetType.svg, path: ImageResource.cid_new),
            boxFit: BoxFit.fitWidth,
          ).paddingOnly(left: 11.33.w),
    elevation: 4,
    centerTitle: true,
    shadowColor: lightColorPalette.grey.withOpacity(0.2),
    foregroundColor: lightColorPalette.whiteColorPrimary.shade900,
    backgroundColor: lightColorPalette.whiteColorPrimary.shade900,
    bottom: PreferredSize(
      preferredSize: const Size(0, 0),
      child: Container(
        width: 1.sw,
        height: 1,
        decoration: BoxDecoration(
          color: lightColorPalette.grey.withOpacity(0.3),
        ),
      ),
    ),
    title: centerWidget ??
        AppTextWidget(
          text: title,
          style: CustomTextTheme.heading2(
            color: lightColorPalette.black,
          ),
        ),
  );
}

AppBar commonAppBarWithOutElevation(
    {required String title,
    bool isShowBackButton = true,
    Function()? onPressBackButton}) {
  return AppBar(
    leading: isShowBackButton
        ? CustomInkwell(
            onTap: () {
              if (onPressBackButton != null) onPressBackButton();
            },
            child: AssetWidget(
              color: lightColorPalette.black,
              asset: Asset(type: AssetType.svg, path: ImageResource.backArrow),
              boxFit: BoxFit.fitWidth,
            ))
        : const SizedBox(),
    elevation: 0,
    centerTitle: true,
    shadowColor: lightColorPalette.grey.withOpacity(0.2),
    foregroundColor: lightColorPalette.whiteColorPrimary.shade900,
    backgroundColor: lightColorPalette.whiteColorPrimary.shade900,
    title: AppTextWidget(
      text: title,
      style: CustomTextTheme.heading2(
        color: lightColorPalette.black,
      ),
    ),
  );
}

getTopLogo() {
  return Column(
    children: [
      Stack(
        alignment: Alignment.center,
        children: [
          Center(
            child: Container(
              height: 70.h,
              width: 70.w,
              decoration: BoxDecoration(
                color: lightColorPalette.whiteColorPrimary.shade900,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    blurRadius: 0,
                    spreadRadius: 0,
                    offset: const Offset(0, 1),
                    color: lightColorPalette.black,
                  )
                ],
              ),
            ),
          ),
          Center(
            child: Container(
              height: 50.h,
              width: 50.w,
              decoration: BoxDecoration(
                color: lightColorPalette.black,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: AssetWidget(
                  color: lightColorPalette.whiteColorPrimary.shade900,
                  asset: Asset(type: AssetType.svg, path: ImageResource.cid),
                  boxFit: BoxFit.fitWidth,
                ),
              ),
            ),
          )
        ],
      ),
      Center(
        child: AppTextWidget(
          textAlign: TextAlign.center,
          text: AppStrings.cONSTRUCTION.tr,
          style: CustomTextTheme.heading3(
            color: lightColorPalette.black,
          ),
        ),
      ),
      Center(
        child: AppTextWidget(
          textAlign: TextAlign.center,
          text: AppStrings.inspectionsDoctor.tr,
          style: CustomTextTheme.normalText(
            color: lightColorPalette.black,
          ),
        ),
      )
    ],
  );
}
