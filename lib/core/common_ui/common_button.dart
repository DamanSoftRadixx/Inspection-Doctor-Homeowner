import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/app_text_widget.dart';
import 'package:inspection_doctor_homeowner/core/theme/app_color_palette.dart';
import 'package:inspection_doctor_homeowner/core/utils/enum.dart';
import 'package:inspection_doctor_homeowner/core/utils/ui_utils.dart';

class CommonButton extends StatelessWidget {
  final Color? bgColor;
  final String commonButtonBottonText;
  final bool? isEnable;
  final bool? isIconEnable;
  final double? radius;
  final double? elevation;
  final double vertical;
  final double horizontal;
  final double? minWidth;
  final double? minHeight;
  final VoidCallback? onPress;
  final TextStyle? style;
  final ShowImagePositionAt? type;
  final MainAxisAlignment? mainAxisAlignment;
  final double? spaceBetween;
  final String? image;
  final bool? needStyle;

  const CommonButton(
      {Key? key,
      this.bgColor,
      required this.commonButtonBottonText,
      this.radius,
      this.elevation = 0.0,
      this.vertical = 18.0,
      this.horizontal = 0.0,
      this.minWidth = double.infinity,
      this.isEnable = true,
      this.isIconEnable = true,
      this.style,
      this.needStyle,
      this.mainAxisAlignment,
      this.spaceBetween,
      this.minHeight,
      this.image,
      required this.onPress,
      this.type = ShowImagePositionAt.none})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPress == null
          ? null
          : () {
              if (isRedundentClick(DateTime.now())) {
                // print('hold on, processing');
                return;
              }
              onPress!();
            },
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius ?? 4.r)),
        backgroundColor: bgColor ?? lightColorPalette.primaryBlue,
        // disabledBackgroundColor: lightColorPalette.additionalSwatch1.shade800,
        textStyle: style ??
            CustomTextTheme.buttonText(
              color: lightColorPalette.whiteColorPrimary.shade900,
            ),
        splashFactory: isEnable == true ? null : NoSplash.splashFactory,
        elevation: elevation,
        maximumSize: Size(minWidth!, minHeight ?? 45.h),
        minimumSize: Size(minWidth!, minHeight ?? 45.h),
        padding: EdgeInsets.symmetric(vertical: 0, horizontal: horizontal),
      ),
      child: AppTextWidget(
        text: commonButtonBottonText,
        style: CustomTextTheme.buttonText(
          color: lightColorPalette.whiteColorPrimary.shade900,
        ),
      ),
    );
  }
}
