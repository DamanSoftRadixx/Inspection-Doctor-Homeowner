import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/asset_widget/common_image_widget.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/text/app_text_widget.dart';
import 'package:inspection_doctor_homeowner/core/constants/app_strings.dart';
import 'package:inspection_doctor_homeowner/core/theme/app_color_palette.dart';
import 'package:inspection_doctor_homeowner/core/utils/image_resources.dart';
import 'package:inspection_doctor_homeowner/features/inspection_details/give_feedback/screens/give_feedback_screen.dart';

extension Extension on GiveFeedbackScreen {
  viewReceivedFeedback({
    required int initialRating,
    required String comments,
    required String inspectorProfileImage,
    required String inspectorName,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 20.h),
        Align(
          alignment: Alignment.centerLeft,
          child: AppTextWidget(
            style: CustomTextTheme.normalText(color: lightColorPalette.grey),
            text: AppStrings.received.tr,
          ),
        ).paddingOnly(bottom: 10.h),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 36.h,
              width: 36.w,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.r),
                  border:
                      Border.all(color: lightColorPalette.grey, width: 0.3)),
              child: Center(
                child: AssetWidget(
                  color: lightColorPalette.black,
                  asset: inspectorProfileImage != ""
                      ? Asset(
                          type: AssetType.network,
                          path: inspectorProfileImage ?? "",
                        )
                      : Asset(
                          type: AssetType.svg,
                          path: ImageResource.user,
                        ),
                ),
              ),
            ),
            SizedBox(width: 10.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppTextWidget(
                    style: CustomTextTheme.buttonText(
                        color: lightColorPalette.black),
                    text: inspectorName),
                RatingBar.builder(
                  ignoreGestures: true,
                  itemSize: 20.r,
                  initialRating: double.parse(initialRating.toString()),
                  minRating: 0,
                  direction: Axis.horizontal,
                  allowHalfRating: false,
                  itemCount: 5,
                  itemPadding: const EdgeInsets.symmetric(horizontal: 0.0),
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: lightColorPalette.orange,
                  ),
                  onRatingUpdate: (rating) {},
                ),
              ],
            ),
          ],
        ).paddingOnly(bottom: 10.h),
        AppTextWidget(
                style: CustomTextTheme.subtext(color: lightColorPalette.grey),
                text: comments)
            .paddingOnly(bottom: 10.h),
      ],
    );
  }
}
