import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/asset_widget/common_image_widget.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/text/app_text_widget.dart';
import 'package:inspection_doctor_homeowner/core/constants/app_strings.dart';
import 'package:inspection_doctor_homeowner/core/theme/app_color_palette.dart';
import 'package:inspection_doctor_homeowner/core/utils/image_resources.dart';

Widget commonDocumentPicker({
  required String title,
  String? text,
  required bool isFilePick,
  required Widget widget,
  String? errorMsg,
  bool? isError,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      AppTextWidget(
        textAlign: TextAlign.start,
        text: title,
        style: CustomTextTheme.normalText(
          color: lightColorPalette.black,
        ),
      ),
      SizedBox(
        height: 1.h,
      ),
      DottedBorder(
        borderType: BorderType.RRect,
        radius: Radius.circular(10.r),
        padding: const EdgeInsets.all(6),
        color: lightColorPalette.black,
        dashPattern: const [5, 4],
        strokeWidth: 1,
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(4)),
          child: SizedBox(
            height: 44.h,
            width: 1.sw,
            child: isFilePick
                ? widget
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      AssetWidget(
                        color: lightColorPalette.black,
                        asset: Asset(
                            type: AssetType.svg,
                            path: ImageResource.downloadIcon),
                      ),
                      SizedBox(
                        width: 6.w,
                      ),
                      Flexible(
                          child: AppTextWidget(
                        textAlign: TextAlign.start,
                        text: text ?? AppStrings.uploadDocument.tr,
                        style: CustomTextTheme.normalText(
                          color: lightColorPalette.black,
                        ),
                      )),
                    ],
                  ),
          ),
        ),
      ),
      Visibility(
        visible: isError ?? false,
        child: Align(
          alignment: Alignment.topLeft,
          child: AppTextWidget(
            text: errorMsg ?? "",
            style: CustomTextTheme.bottomTabs(
              color: lightColorPalette.redDark,
            ),
          ).paddingOnly(top: 5.h),
        ),
      )
    ],
  );
}
