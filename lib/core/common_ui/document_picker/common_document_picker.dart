import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/asset_widget/common_image_widget.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/text/app_text_widget.dart';
import 'package:inspection_doctor_homeowner/core/constants/app_strings.dart';
import 'package:inspection_doctor_homeowner/core/theme/app_color_palette.dart';
import 'package:inspection_doctor_homeowner/core/utils/image_resources.dart';

Widget commonDocumentPicker({required String title, String? text}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      AppTextWidget(
        textAlign: TextAlign.start,
        text: title,
        style: CustomTextTheme.normalText(
          color: lightColorPalette.primaryDarkblue,
        ),
      ),
      SizedBox(
        height: 1.h,
      ),
      DottedBorder(
        borderType: BorderType.RRect,
        radius: const Radius.circular(4),
        padding: const EdgeInsets.all(6),
        color: lightColorPalette.primaryBlue,
        dashPattern: const [5, 4],
        strokeWidth: 1,
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(4)),
          child: SizedBox(
            height: 44.h,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                AssetWidget(
                  asset: Asset(
                      type: AssetType.svg, path: ImageResource.downloadIcon),
                ),
                SizedBox(
                  width: 6.w,
                ),
                Flexible(
                    child: AppTextWidget(
                  textAlign: TextAlign.start,
                  text: text ?? AppStrings.uploadDocument.tr,
                  style: CustomTextTheme.normalText(
                    color: lightColorPalette.primaryBlue,
                  ),
                )),
              ],
            ),
          ),
        ),
      )
    ],
  );
}