import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/text/app_text_widget.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/textfields/app_common_text_form_field.dart';
import 'package:inspection_doctor_homeowner/core/constants/app_strings.dart';
import 'package:inspection_doctor_homeowner/core/theme/app_color_palette.dart';
import 'package:inspection_doctor_homeowner/features/inspection_details/give_feedback/screens/give_feedback_screen.dart';

extension Extension on GiveFeedbackScreen {
  addRatingview() {
    return Column(
      children: [
        showHeading(),
        showRatingSelection(),
        getReviewBox(),
      ],
    );
  }

  getReviewBox() {
    return Align(
        alignment: Alignment.centerLeft,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            commonTextFieldWidget(
              height: 88.h,
              maxLines: 5,
              textCapitalization: TextCapitalization.sentences,
              focusNode: controller.reviewFocusNode.value,
              controller: controller.reviewController.value,
              title: AppStrings.writeReview.tr,
              hint: AppStrings.writeReview.tr,
              maxLength: 300,
              // isError: controller.descError.value,
              // errorMsg: controller.descErrorMessage.value,
              keyboardType: TextInputType.name,
              textInputAction: TextInputAction.next,
              // inputFormatters: <TextInputFormatter>[
              //   FilteringTextInputFormatter(RegExp("[a-zA-Z " "]"),
              //       allow: true),
              // ],
              onChanged: (value) {
                controller.onChangedReviewField(value: value);
              },
            )
          ],
        )).paddingOnly(top: 11.h);
  }

  Widget showRatingSelection() {
    return Container(
      alignment: Alignment.center,
      width: 335.w,
      decoration:
          decoration2(bgColor: lightColorPalette.whiteColorPrimary.shade900),
      child: Column(
        children: [
          RatingBar.builder(
            itemSize: 50,
            initialRating: 0,
            minRating: 0,
            direction: Axis.horizontal,
            allowHalfRating: false,
            itemCount: 5,
            itemPadding: const EdgeInsets.symmetric(horizontal: 0.0),
            itemBuilder: (context, _) => Icon(
              Icons.star,
              color: lightColorPalette.orange,
            ),
            onRatingUpdate: (rating) {
              controller.onRatingSelection(rating);
            },
          ).paddingOnly(top: 20.h, bottom: 16.h),
          SizedBox(
            height: 24.h,
            child: AppTextWidget(
              textAlign: TextAlign.center,
              text: controller
                  .feedBackList[int.parse(controller.selectedRating.value
                      .toString()
                      .replaceAll(".0", ""))]
                  .text
                  .tr,
              style: CustomTextTheme.heading3(
                color: lightColorPalette.black,
              ),
            ).paddingOnly(bottom: 20.h),
          )
        ],
      ),
    ).paddingOnly(top: 30.h, bottom: 30.h);
  }

  Column showHeading() {
    return Column(
      children: [
        Center(
          child: AppTextWidget(
            textAlign: TextAlign.center,
            text: AppStrings.rateYourExp.tr,
            style: CustomTextTheme.heading3(
              color: lightColorPalette.black,
            ),
          ).paddingOnly(top: 50.h, bottom: 5.h),
        ),
        Center(
          child: AppTextWidget(
            textAlign: TextAlign.center,
            text: AppStrings.areYouSatisfiedithTheInspection.tr,
            style: CustomTextTheme.normalText2(
              color: lightColorPalette.grey,
            ),
          ),
        ),
      ],
    );
  }
}
