import 'package:flutter/material.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/app_text_widget.dart';

import '../theme/app_color_palette.dart';

AppBar commonAppBar({required String title, Widget? leading}) {
  return AppBar(
    leading: leading ?? const SizedBox(),
    elevation: 0,
    centerTitle: true,
    backgroundColor: lightColorPalette.whiteColorPrimary.shade900,
    title: AppTextWidget(
      text: title,
      style: CustomTextTheme.heading2(
        color: lightColorPalette.primaryDarkblue,
      ),
    ),
  );
}
