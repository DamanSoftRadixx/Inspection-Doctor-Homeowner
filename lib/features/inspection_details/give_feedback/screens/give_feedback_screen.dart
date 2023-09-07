import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/app_bar/common_appbar.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/common_button/common_button.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/common_loader/common_loader.dart';
import 'package:inspection_doctor_homeowner/core/constants/app_strings.dart';
import 'package:inspection_doctor_homeowner/core/theme/app_color_palette.dart';
import 'package:inspection_doctor_homeowner/features/inspection_details/give_feedback/controller/give_feedback_controller.dart';
import 'package:inspection_doctor_homeowner/features/inspection_details/give_feedback/extensions/add_rating_view.dart';
import 'package:inspection_doctor_homeowner/features/inspection_details/give_feedback/extensions/view_given_feedback.dart';
import 'package:inspection_doctor_homeowner/features/inspection_details/give_feedback/extensions/view_received_feedback.dart';

class GiveFeedbackScreen extends GetView<GiveFeedBackController> {
  const GiveFeedbackScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          backgroundColor: lightColorPalette.whiteColorPrimary.shade900,
          appBar: showAppBar(),
          bottomNavigationBar: showSubmitButton(),
          body: Stack(
            children: [
              SingleChildScrollView(
                physics: const RangeMaintainingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    viewFeedbackUi(),
                  ],
                ).paddingSymmetric(horizontal: 20.w),
              ),
              CommonLoader(isLoading: controller.isShowLoader.value)
            ],
          ),
        ));
  }

  viewFeedbackUi() {
    Widget result = const SizedBox();

    if (controller.ratings.isEmpty) {
      //if  feedback not given then we will  show feedback givin ui.

      result = addRatingview();
    } else {
      bool isShowFeedBackReceived = controller.ratings
          .any((element) => element.senderId == controller.inspectorId.value);

      bool isShowFeedBackGiven = controller.ratings
          .any((element) => element.senderId == controller.homeownerId.value);

      int receivedIndex = controller.ratings.indexWhere(
          (element) => element.senderId == controller.inspectorId.value);
      int givinIndex = controller.ratings.indexWhere(
          (element) => element.senderId == controller.homeownerId.value);

      if (isShowFeedBackReceived && isShowFeedBackGiven) {
        result = Column(
          children: [
            viewGivenFeedback(
                comments: controller.ratings[givinIndex].comment ?? "",
                initialRating: controller.ratings[givinIndex].rating ?? 0,
                homeownerName: controller.homeownerName.value,
                homeownerProfileImage: controller.homeownerPic.value),
            getDivider(),
            viewReceivedFeedback(
                comments: controller.ratings[receivedIndex].comment ?? "",
                initialRating: controller.ratings[receivedIndex].rating ?? 0,
                inspectorName: controller.inspectorName.value,
                inspectorProfileImage: controller.inspectorPic.value),
          ],
        );
      } else if (isShowFeedBackReceived == false &&
          isShowFeedBackGiven == true) {
        result = Column(
          children: [
            viewGivenFeedback(
                comments: controller.ratings[givinIndex].comment ?? "",
                initialRating: controller.ratings[givinIndex].rating ?? 0,
                homeownerName: controller.homeownerName.value,
                homeownerProfileImage: controller.homeownerPic.value),
            getDivider(),
          ],
        );
      } else if (isShowFeedBackReceived == true &&
          isShowFeedBackGiven == false) {
        result = Column(
          children: [
            viewReceivedFeedback(
                comments: controller.ratings[receivedIndex].comment ?? "",
                initialRating: controller.ratings[receivedIndex].rating ?? 0,
                inspectorName: controller.inspectorName.value,
                inspectorProfileImage: controller.inspectorPic.value),
            getDivider(),
            addRatingview()
          ],
        );
      }
    }

    return result;
  }

  AppBar showAppBar() {
    return commonAppBarWithElevation(
        title: AppStrings.feedback.tr,
        onPressBackButton: () {
          Get.back(closeOverlays: true);
        });
  }

  Widget showSubmitButton() {
    Widget result = const SizedBox();

    //if  feedback given then we will not show submit button.

    if (controller.ratings.isNotEmpty) {
      if (controller.ratings
          .any((element) => element.senderId == controller.homeownerId.value)) {
        result = const SizedBox();
      } else {
        result = CommonButton(
                commonButtonBottonText: AppStrings.submitButton.tr,
                onPress: controller.selectedRating.value == 0.0
                    ? null
                    : () {
                        controller.addFeedback();
                      })
            .paddingOnly(bottom: 38.h, left: 20.w, right: 20.w);
      }
    } else {
      result = CommonButton(
              commonButtonBottonText: AppStrings.submitButton.tr,
              onPress: controller.selectedRating.value == 0.0
                  ? null
                  : () {
                      controller.addFeedback();
                    })
          .paddingOnly(bottom: 38.h, left: 20.w, right: 20.w);
    }
    return result;
  }

  Divider getDivider() {
    return Divider(
      height: 0,
      color: lightColorPalette.grey,
      thickness: 0.3,
      indent: 0,
      endIndent: 0,
    );
  }
}
