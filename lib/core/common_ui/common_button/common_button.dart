import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/asset_widget/common_image_widget.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/text/app_text_widget.dart';
import 'package:inspection_doctor_homeowner/core/theme/app_color_palette.dart';
import 'package:inspection_doctor_homeowner/core/utils/enum.dart';
import 'package:inspection_doctor_homeowner/core/utils/image_resources.dart';
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
  final Widget? icon;
  final BorderSide? border;

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
      this.type = ShowImagePositionAt.none,
      this.icon,
      this.border})
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
        disabledBackgroundColor: lightColorPalette.black.withOpacity(0.50),
        side: border,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius ?? 10.r)),
        backgroundColor: bgColor ?? lightColorPalette.black,
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          icon ?? const SizedBox(),
          AppTextWidget(
            text: commonButtonBottonText,
            style: style ??
                CustomTextTheme.buttonText(
                  color: lightColorPalette.whiteColorPrimary.shade900,
                ),
          ).paddingOnly(left: 1.5.w),
        ],
      ),
    );
  }
}

Widget commonRadioButton(
    {required String text,
    required bool isSelected,
    required Function() onTap}) {
  return GestureDetector(
    onTap: () {
      onTap();
    },
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        isSelected
            ? AssetWidget(
                color: Colors.green,
                asset: Asset(type: AssetType.svg, path: ImageResource.checked),
              )
            : AssetWidget(
                asset: Asset(type: AssetType.svg, path: ImageResource.unCheck),
              ),
        SizedBox(
          width: 10.w,
        ),
        Flexible(
            child: AppTextWidget(
          textAlign: TextAlign.start,
          text: text,
          style: CustomTextTheme.categoryText(
            color: lightColorPalette.black,
          ),
        )),
      ],
    ),
  );
}

Widget commonTermAndConditionsButton(
    {required String text,
    required bool isSelected,
    required Function() onTap}) {
  return GestureDetector(
    onTap: () {
      onTap();
    },
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 2.h),
          child: isSelected
              ? AssetWidget(
                  asset: Asset(
                      type: AssetType.svg,
                      path: ImageResource.selectedCheckbox),
                )
              : AssetWidget(
                  asset: Asset(
                      type: AssetType.svg,
                      path: ImageResource.unSelectedCheckbox),
                ),
        ),
        SizedBox(
          width: 10.w,
        ),
        Flexible(
            child: AppTextWidget(
          textAlign: TextAlign.start,
          text: text,
          style: CustomTextTheme.normalTextWithLineHeight20(
            color: lightColorPalette.grey,
          ),
        )),
      ],
    ),
  );
}
