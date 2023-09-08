import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/common_dialogs.dart';
import 'package:inspection_doctor_homeowner/core/constants/app_keys.dart';
import 'package:inspection_doctor_homeowner/core/constants/app_strings.dart';
import 'package:inspection_doctor_homeowner/core/network_utility/dio_exceptions.dart';
import 'package:inspection_doctor_homeowner/features/inspection_details/scheduled_property/model/network/request/inspection_detail_response_model.dart';
import 'package:inspection_doctor_homeowner/features/inspection_details/give_feedback/model/local_model/feedback_model.dart';
import 'package:inspection_doctor_homeowner/features/inspection_details/give_feedback/model/network/feedback_response_model.dart';
import 'package:inspection_doctor_homeowner/features/inspection_details/give_feedback/provider/give_feedback_provider.dart';

class GiveFeedBackController extends GetxController {
  GiveFeedbackProvider giveFeedbackProvider = GiveFeedbackProvider();
  RxList<FeedbackModel> feedBackList = <FeedbackModel>[].obs;

  RxDouble selectedRating = 0.0.obs;
  Rx<TextEditingController> reviewController = TextEditingController().obs;
  Rx<FocusNode> reviewFocusNode = FocusNode().obs;
  var isShowLoader = false.obs;

  RxString inspectorId = "".obs;
  RxString homeownerId = "".obs;
  RxString inspectionId = "".obs;
  RxList<Ratings> ratings = <Ratings>[].obs;
  RxString inspectorName = "".obs;
  RxString inspectorPic = "".obs;
  RxString homeownerName = "".obs;
  RxString homeownerPic = "".obs;

  getArguments() {
    var args = Get.arguments;

    if (args != null) {
      if (args[GetArgumentConstants.inspectionId] != null) {
        inspectionId.value = args[GetArgumentConstants.inspectionId];
      }
      if (args[GetArgumentConstants.inspectorId] != null) {
        inspectorId.value = args[GetArgumentConstants.inspectorId];
      }
      if (args[GetArgumentConstants.homeownerId] != null) {
        homeownerId.value = args[GetArgumentConstants.homeownerId];
      }
      if (args[GetArgumentConstants.ratings] != null) {
        ratings.value = args[GetArgumentConstants.ratings];
        ratings.refresh();
      }
      if (args[GetArgumentConstants.inspectorName] != null) {
        inspectorName.value = args[GetArgumentConstants.inspectorName];
      }
      if (args[GetArgumentConstants.inspectorPic] != null) {
        inspectorPic.value = args[GetArgumentConstants.inspectorPic];
      }
      if (args[GetArgumentConstants.homeOwnerPic] != null) {
        homeownerPic.value = args[GetArgumentConstants.homeOwnerPic];
      }
      if (args[GetArgumentConstants.homeOwnerName] != null) {
        homeownerName.value = args[GetArgumentConstants.homeOwnerName];
      }
    }
  }

  @override
  void onInit() {
    feedBackList.addAll([
      FeedbackModel(ratingNo: 0.0, text: ""),
      FeedbackModel(ratingNo: 1.0, text: AppStrings.poor),
      FeedbackModel(ratingNo: 2.0, text: AppStrings.okey),
      FeedbackModel(ratingNo: 3.0, text: AppStrings.good),
      FeedbackModel(ratingNo: 4.0, text: AppStrings.excellent),
      FeedbackModel(ratingNo: 5.0, text: AppStrings.outstanding),
    ]);
    getArguments();
    addFocusListeners();

    super.onInit();
  }

  void onChangedReviewField({required String value}) {
    if (value.length == 1 && value.contains(" ")) {
      reviewController.value.text = reviewController.value.text.trim();
    }
  }

  addFocusListeners() {
    reviewFocusNode.value.addListener(() {
      reviewFocusNode.refresh();
    });
  }

  void onRatingSelection(double rating) {
    selectedRating.value = rating;
    reviewFocusNode.value.unfocus();
  }

  disposeFocusListeners() {
    reviewFocusNode.value.removeListener(() {});
  }

  @override
  void dispose() {
    disposeFocusListeners();
    super.dispose();
  }

  setShowLoader({required bool value}) {
    isShowLoader.value = value;
    isShowLoader.refresh();
  }

  void addFeedback() async {
    setShowLoader(value: true);

    var body = {
      "receiver_id": inspectorId.value.toString(),
      "rating": selectedRating.value,
      "comment": reviewController.value.text
    };
    log("body>>>> ${jsonEncode(body)}");
    try {
      FeedbackResponseModel response = await giveFeedbackProvider.addFeedback(
              body: body, id: inspectionId.value) ??
          FeedbackResponseModel();
      setShowLoader(value: false);
      if (response.success == true &&
          response.data != [] &&
          (response.status == 201 || response.status == 200)) {
        showCommonAlertSingleButtonDialog(
            title: AppStrings.alert.tr,
            subHeader: response.message ?? "",
            okPressed: () {
              Get.back();
              Get.back(closeOverlays: true, result: [
                {GetArgumentConstants.isNeedtoRefersh: true}
              ]);
            },
            buttonTitle: 'Ok');
      } else {
        setShowLoader(value: false);
        apiErrorDialog(
          message: response.message ?? AppStrings.somethingWentWrong.tr,
          okButtonPressed: () {
            Get.back();
          },
        );
      }
    } catch (e) {
      setShowLoader(value: false);
    }
  }
}
