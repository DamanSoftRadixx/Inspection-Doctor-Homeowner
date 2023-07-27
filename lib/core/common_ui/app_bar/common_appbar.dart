import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/asset_widget/common_image_widget.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/common_button/custom_icon_button.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/text/app_text_widget.dart';
import 'package:inspection_doctor_homeowner/core/utils/image_resources.dart';

import '../../theme/app_color_palette.dart';

// AppBar commonAppBar({required String title, Widget? leading}) {
//   return AppBar(
//     leading: leading ?? const SizedBox(),
//     elevation: 0,
//     centerTitle: true,
//     backgroundColor: lightColorPalette.whiteColorPrimary.shade900,
//     title: AppTextWidget(
//       text: title,
//       style: CustomTextTheme.heading2(
//         color: lightColorPalette.black,
//       ),
//     ),
//   );
// }

AppBar commonAppBarWithElevation(
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
    title: AppTextWidget(
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
