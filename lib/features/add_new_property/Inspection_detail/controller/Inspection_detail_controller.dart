import 'dart:convert';

import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/document_picker/pdf_viewer.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/snackbar/snackbar.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/textfields/app_common_text_form_field.dart';
import 'package:inspection_doctor_homeowner/core/constants/app_strings.dart';
import 'package:inspection_doctor_homeowner/core/date_formatter/date_formatter.dart';
import 'package:inspection_doctor_homeowner/core/network_utility/dio_exceptions.dart';
import 'package:inspection_doctor_homeowner/core/network_utility/model/time_model.dart';
import 'package:inspection_doctor_homeowner/core/utils/enum.dart';
import 'package:inspection_doctor_homeowner/core/utils/image_resources.dart';
import 'package:inspection_doctor_homeowner/features/add_new_property/Inspection_detail/model/local/inspection_history_local_model.dart';
import 'package:inspection_doctor_homeowner/features/add_new_property/Inspection_detail/model/network/request/inspection_reschedule_request_model.dart';
import 'package:inspection_doctor_homeowner/features/add_new_property/Inspection_detail/provider/Inspection_detail_provider.dart';
import 'package:inspection_doctor_homeowner/features/add_new_property/selectCategories/model/network/category_list_response_model.dart';
import 'package:intl/intl.dart';

class InspectionDetailController extends GetxController {
  InspectionDetailProvider inspectionDetailProvider =
      InspectionDetailProvider();
  RxBool isShowLoader = false.obs;
  RxBool isShowInitialLoader = false.obs;
  Rx<InspectionDetailData> inspectionDetail = InspectionDetailData().obs;
  Rx<String> inspectionId = "".obs;
  Rx<String> selectedDate = "".obs;
  RxList<DropdownModel> timeList = <DropdownModel>[].obs;
  var selectTime = DropdownModel().obs;

  Rx<CategoryListResponseDataModel> selectedCategory =
      CategoryListResponseDataModel().obs;

  RxString selectedCountryCode = "1".obs;

  Rx<FocusNode> firstNameFocusNode = FocusNode().obs;
  Rx<FocusNode> lastNameFocusNode = FocusNode().obs;
  Rx<FocusNode> emailFocusNode = FocusNode().obs;
  Rx<FocusNode> phoneNumberFocusNode = FocusNode().obs;
  Rx<FocusNode> descriptionFocusNode = FocusNode().obs;
  RxList<DropdownModel> selectedTime = <DropdownModel>[].obs;
  Rx<TextEditingController> firstNameController = TextEditingController().obs;
  Rx<TextEditingController> lastNameController = TextEditingController().obs;
  Rx<TextEditingController> emailController = TextEditingController().obs;
  Rx<TextEditingController> phoneNumberController = TextEditingController().obs;
  Rx<TextEditingController> descriptionController = TextEditingController().obs;

  RxBool emailError = false.obs;
  RxBool firstNameError = false.obs;
  RxBool lastNameError = false.obs;
  RxBool phoneError = false.obs;
  RxBool descError = false.obs;

  RxString firstNameErrorMessage = "".obs;
  RxString lastNameErrorMessage = "".obs;
  RxString phoneErrorMessage = "".obs;
  RxString emailErrorMessage = "".obs;

  var inspectionHistoryList = <InspectionHistoryLocalModel>[].obs;
  // RxList<WidgetSize> widgetSizeList = <WidgetSize>[].obs;

  @override
  void onInit() {
    initTimeList();
    getArguments();
    super.onInit();
  }

  getArguments() {
    var args = Get.arguments;
    if (args != null) {
      inspectionId.value = args[GetArgumentConstants.inspectionId] ?? "";
      getScheduleInspectionDetailsList(isFromOnInit: true);
    }
  }

  initTimeList() {
    timeList.addAll([
      DropdownModel(
          id: "0",
          name: "All day (8am-6pm)",
          startTime: '08:00',
          endTime: "18:00"),
      DropdownModel(
          id: "1",
          name: "Morning (8am-12pm)",
          startTime: '08:00',
          endTime: "12:00"),
      DropdownModel(
          id: "2",
          name: "Afternoon (12pm-3pm)",
          startTime: '12:00',
          endTime: "15:00"),
      DropdownModel(
          id: "3",
          name: "Evening (3pm-6pm)",
          startTime: '15:00',
          endTime: "18:00"),
    ]);
  }

  addFocusListeners() {
    firstNameFocusNode.value.addListener(() {
      firstNameFocusNode.refresh();
    });
    lastNameFocusNode.value.addListener(() {
      lastNameFocusNode.refresh();
    });
    emailFocusNode.value.addListener(() {
      emailFocusNode.refresh();
    });

    phoneNumberFocusNode.value.addListener(() {
      phoneNumberFocusNode.refresh();
    });
    descriptionFocusNode.value.addListener(() {
      phoneNumberFocusNode.refresh();
    });
  }

  disposeFocusListeners() {
    firstNameFocusNode.value.removeListener(() {});
    lastNameFocusNode.value.removeListener(() {});
    emailFocusNode.value.removeListener(() {});
    phoneNumberFocusNode.value.removeListener(() {});
    descriptionFocusNode.value.removeListener(() {});
  }

  onSelectTimeDropdown({required DropdownModel value}) async {
    selectTime.value = value;
    selectedTime.refresh();
  }

  void onSelectCountryCode({required Country country}) {
    selectedCountryCode.value = country.phoneCode;
  }

  void onChangedFirstNameTextField({required String value}) {
    if (value.length == 1 && value.contains(" ")) {
      firstNameController.value.text = firstNameController.value.text.trim();
    }

    if (value.length >= 2) {
      firstNameError.value = false;
    }
  }

  void onChangedDescriptionField({required String value}) {
    if (value.length == 1 && value.contains(" ")) {
      descriptionController.value.text =
          descriptionController.value.text.trim();
    }

    if (value.length >= 2) {
      descError.value = false;
    }

    descriptionController.refresh();
  }

  void onChangedLastNameTextField({required String value}) {
    if (value.length == 1 && value.contains(" ")) {
      lastNameController.value.text = lastNameController.value.text.trim();
    }
    if (value.length >= 2) {
      lastNameError.value = false;
    }
  }

  void onChangedEmailTextField({required String value}) {
    if (value.length == 1 && value.contains(" ")) {
      firstNameController.value.text = firstNameController.value.text.trim();
    }
    if (value.isNotEmpty && emailController.value.text.isEmail) {
      emailError.value = false;
    }
  }

  void onChangedPhoneTextField({required String value}) {
    if (phoneNumberController.value.text.length > 6) {
      phoneError.value = false;
    }
  }

  setShowLoader({required bool value}) {
    isShowLoader.value = value;
    isShowLoader.refresh();
  }

  setInitialShowLoader({required bool value}) {
    isShowInitialLoader.value = value;
    isShowInitialLoader.refresh();
  }

  Future<void> getScheduleInspectionDetailsList(
      {bool isFromOnInit = false}) async {
    if (isFromOnInit) {
      setInitialShowLoader(value: true);
    } else {
      setShowLoader(value: true);
    }

    try {
      InspectionDetailResponseModel response = await inspectionDetailProvider
              .scheduleInspectionDetails(id: inspectionId.value) ??
          InspectionDetailResponseModel();
      setShowLoader(value: false);
      setInitialShowLoader(value: false);
      if (response.success == true &&
          (response.status == 200 || response.status == 201)) {
        inspectionDetail.value = response.data?[0] ?? InspectionDetailData();
        createInspectionHistoryListFromResponse();
      } else {
        apiErrorDialog(
          message: response.message ?? AppStrings.somethingWentWrong,
          okButtonPressed: () {
            Get.back();
          },
        );
      }
    } catch (e) {
      setInitialShowLoader(value: false);
      setShowLoader(value: false);
    }
  }

  createInspectionHistoryListFromResponse() {
    var historyList =
        inspectionDetail.value.propertyInspectionSchedulesHistory ?? [];
    var categoryName = inspectionDetail.value.category?.name ?? "";
    var inspectorList = inspectionDetail.value.inspectorDetails ?? [];

    var inspectorName = "";

    if (inspectorList.isNotEmpty) {
      var firstName = inspectorList[0].firstName ?? "";
      var lastName = inspectorList[0].lastName ?? "";

      if (lastName.isNotEmpty) {
        inspectorName = "$firstName $lastName";
      } else {
        inspectorName = "$firstName";
      }
    }

    inspectionHistoryList.clear();

    for (int i = 0; i < historyList.length; i++) {
      var historyStatusId = historyList[i].inspectionStatusId ?? "";
      var historyData = historyList[i];

      if (historyStatusId == InspectionHistoryStatusEnum.newInspection.value) {
        var inspectionDate =
            getDateFormattedFromString(date: historyData.date ?? "");

        var timeList = historyData.time ?? [];
        var timeSlotString = getTimeString(timeList: timeList);

        inspectionHistoryList.add(InspectionHistoryLocalModel(
            id: historyData.id ?? "",
            message:
                "You have requested $categoryName inspection by $inspectionDate $timeSlotString.",
            title: AppStrings.inspectionRequested,
            iconPath: ImageResource.blackCircle,
            isShowLine: i == historyList.length - 1 ? false : true,
            historyResponse: historyData,
            isShowCancelButton: true,
            isShowRescheduleButton: true));
      } else if (historyStatusId ==
          InspectionHistoryStatusEnum.inspectionAcccepted.value) {
        var inspectionDate =
            getDateFormattedFromString(date: historyData.date ?? "");

        var timeList = historyData.time ?? [];
        var timeSlotString = getTimeString(timeList: timeList);

        inspectionHistoryList.add(InspectionHistoryLocalModel(
            id: historyData.id ?? "",
            message:
                "Inspector $inspectorName is assigned and inspection is scheduled at $inspectionDate $timeSlotString.",
            title: AppStrings.inspectorAssigned,
            iconPath: ImageResource.blackCircle,
            isShowLine: i == historyList.length - 1 ? false : true,
            historyResponse: historyData,
            isShowCancelButton: true));
      } else if (historyStatusId ==
          InspectionHistoryStatusEnum.homeownerInspectionRescheduled.value) {
        var inspectionDate =
            getDateFormattedFromString(date: historyData.date ?? "");

        var timeList = historyData.time ?? [];
        var timeSlotString = getTimeString(timeList: timeList);

        inspectionHistoryList.add(InspectionHistoryLocalModel(
            id: historyData.id ?? "",
            message:
                "You have rescheduled the inspection at $inspectionDate  $timeSlotString.",
            title: AppStrings.inspectionRescheduled,
            iconPath: ImageResource.blackCircle,
            isShowLine: i == historyList.length - 1 ? false : true,
            historyResponse: historyData,
            isShowCancelButton: true,
            isShowRescheduleButton: true));
      } else if (historyStatusId ==
          InspectionHistoryStatusEnum.homeownerInspectionCanceled.value) {
        inspectionHistoryList.add(InspectionHistoryLocalModel(
            id: historyData.id ?? "",
            message: "You have canceled the inspection.",
            title: AppStrings.inspectionCanceled,
            iconPath: ImageResource.cancel,
            isShowLine: i == historyList.length - 1 ? false : true,
            historyResponse: historyData));
      } else if (historyStatusId ==
          InspectionHistoryStatusEnum.inspectorInspectionCanceled.value) {
        inspectionHistoryList.add(InspectionHistoryLocalModel(
            id: historyData.id ?? "",
            message: "Inspector $inspectorName Canceled the inspection.",
            title: AppStrings.inspectionCanceled,
            iconPath: ImageResource.cancel,
            isShowLine: i == historyList.length - 1 ? false : true,
            historyResponse: historyData));
      } else if (historyStatusId ==
          InspectionHistoryStatusEnum.inspectorInspectionRescheduled.value) {
        var inspectionDate =
            getDateFormattedFromString(date: historyData.date ?? "");

        var timeList = historyData.time ?? [];
        var timeSlotString = getTimeString(timeList: timeList);

        inspectionHistoryList.add(InspectionHistoryLocalModel(
          id: historyData.id ?? "",
          message:
              "Inspector $inspectorName rescheduled the inspection at $inspectionDate  $timeSlotString.",
          title: AppStrings.inspectionRescheduled,
          iconPath: ImageResource.blackCircle,
          isShowLine: i == historyList.length - 1 ? false : true,
          historyResponse: historyData,
          isShowCancelButton: true,
        ));
      } else if (historyStatusId ==
          InspectionHistoryStatusEnum.inspectorOnTheWay.value) {
        inspectionHistoryList.add(InspectionHistoryLocalModel(
            id: historyData.id ?? "",
            message: "Inspector $inspectorName is on the way for inspection.",
            title: AppStrings.inspectorIsOnTheWay,
            iconPath: ImageResource.blackCircle,
            isShowLine: i == historyList.length - 1 ? false : true,
            historyResponse: historyData));
      } else if (historyStatusId ==
          InspectionHistoryStatusEnum.inspectionStart.value) {
        inspectionHistoryList.add(InspectionHistoryLocalModel(
            id: historyData.id ?? "",
            message: "Inspector $inspectorName has started the inspection.",
            title: AppStrings.inspectionStarted,
            iconPath: ImageResource.blackCircle,
            isShowLine: i == historyList.length - 1 ? false : true,
            historyResponse: historyData));
      } else if (historyStatusId ==
          InspectionHistoryStatusEnum.inspectionDone.value) {
        inspectionHistoryList.add(InspectionHistoryLocalModel(
          id: historyData.id ?? "",
          message:
              "Inspector $inspectorName has completed the inspection and now wait for the report.",
          title: AppStrings.inspectionDone,
          iconPath: ImageResource.blackCircle,
          isShowLine: i == historyList.length - 1 ? false : true,
          historyResponse: historyData,
        ));
      } else if (historyStatusId ==
          InspectionHistoryStatusEnum.inspectionReportCompleted.value) {
        inspectionHistoryList.add(InspectionHistoryLocalModel(
            id: historyData.id ?? "",
            message:
                "Inspector $inspectorName has submitted the report. Correction is required, please view the report from here.",
            title: AppStrings.inspectionComplete,
            iconPath: ImageResource.blackCircle,
            isShowLine: i == historyList.length - 1 ? false : true,
            historyResponse: historyData,
            isShowGiveFeedBackButton: true,
            isShowViewReportButton: true));
      } else if (historyStatusId ==
          InspectionHistoryStatusEnum.inspectionReportCorrections.value) {
        inspectionHistoryList.add(InspectionHistoryLocalModel(
            id: historyData.id ?? "",
            message:
                "Inspector $inspectorName has submitted the report. Your inspection is approved. Please view the report from here.",
            title: AppStrings.correctionRequired,
            iconPath: ImageResource.blackCircle,
            isShowLine: i == historyList.length - 1 ? false : true,
            historyResponse: historyData,
            isShowGiveFeedBackButton: true,
            isShowViewReportButton: true));
      }
    }

    print("historydata : ${inspectionHistoryList.length}");
    inspectionHistoryList.refresh();
  }

  String getTimeString({required List<TimeModel> timeList}) {
    var timeSlotString = "";

    for (var time in timeList) {
      var startTimeString =
          getLocalTimeFromUtc(dateTimeString: time.starttime ?? "");
      var endTimeString =
          getLocalTimeFromUtc(dateTimeString: time.endtime ?? "");

      if (timeSlotString.isEmpty) {
        timeSlotString = "$startTimeString - $endTimeString";
      } else {
        timeSlotString += ", $startTimeString - $endTimeString";
      }
    }

    return timeSlotString;
  }

  onOpenReScheduledBottomSheet() {
    InspectionSchedulesHistoryModel firstHistoryItemDetail =
        inspectionDetail.value.propertyInspectionSchedulesHistory?[0] ??
            InspectionSchedulesHistoryModel();

    firstNameController.value.text = firstHistoryItemDetail.firstName ?? "";
    lastNameController.value.text = firstHistoryItemDetail.lastName ?? "";
    emailController.value.text = firstHistoryItemDetail.email ?? "";
    phoneNumberController.value.text = firstHistoryItemDetail.phone ?? "";
    selectedCountryCode.value = firstHistoryItemDetail.countryCode ?? "";
    descriptionController.value.text = firstHistoryItemDetail.description ?? "";
    selectedDate.value = getDateFormattedFromString(
        date: firstHistoryItemDetail.date ?? "", newPattern: "dd/MM/yyyy");
    selectedCountryCode.value = firstHistoryItemDetail.countryCode ?? "";

    var timeRespList = firstHistoryItemDetail.time ?? [];
    selectedTime.clear();
    for (var object in timeRespList) {
      var startTime =
          get24HoursLocalTimeFromUtc(dateTimeString: object.starttime ?? "");
      var endTime =
          get24HoursLocalTimeFromUtc(dateTimeString: object.endtime ?? "");

      DropdownModel? selectedItem = timeList.value.firstWhereOrNull((element) =>
          element.startTime == startTime && element.endTime == endTime);

      if (selectedItem != null) {
        selectedTime.add(selectedItem);
      }
    }
  }

  Future<void> inspectionRescheduleApi({required Object body}) async {
    setShowLoader(value: true);
    Get.back();
    try {
      InspectionDetailResponseModel response = await inspectionDetailProvider
              .inspectionRescheduling(id: inspectionId.value, body: body) ??
          InspectionDetailResponseModel();
      setShowLoader(value: false);
      if (response.success == true &&
          (response.status == 200 || response.status == 201)) {
        await getScheduleInspectionDetailsList();
        snackbar(response.message ?? "");
      } else {
        apiErrorDialog(
          message: response.message ?? AppStrings.somethingWentWrong,
          okButtonPressed: () {
            Get.back();
          },
        );
      }
    } catch (e) {
      setInitialShowLoader(value: false);
      setShowLoader(value: false);
    }
  }

  void onPressRescheduleSubmitButton() {
    if (isValidRescheduleForm()) {
      var inspectionRescheduleRequestModel = InspectionRescheduleRequestModel();
      inspectionRescheduleRequestModel.type = "rescheduled";
      List<TimeModel> utcDateTimeList = [];

      if (selectedTime.isNotEmpty) {
        selectedTime.map((e) {
          utcDateTimeList.add(TimeModel(
              starttime:
                  getUtcDateString(date: selectedDate.value, time: e.startTime),
              endtime:
                  getUtcDateString(date: selectedDate.value, time: e.endTime)));
        }).toList();
      }

      inspectionRescheduleRequestModel.firstName =
          firstNameController.value.text;
      inspectionRescheduleRequestModel.lastName = lastNameController.value.text;
      inspectionRescheduleRequestModel.phone = phoneNumberController.value.text;
      inspectionRescheduleRequestModel.email = emailController.value.text;
      inspectionRescheduleRequestModel.phone = phoneNumberController.value.text;
      inspectionRescheduleRequestModel.description =
          descriptionController.value.text;
      inspectionRescheduleRequestModel.date = getDateFormattedFromString(
          date: selectedDate.value, newPattern: "yyyy-MM-dd");
      inspectionRescheduleRequestModel.countryCode = selectedCountryCode.value;

      inspectionRescheduleRequestModel.time = utcDateTimeList;

      var body = json.encode(inspectionRescheduleRequestModel);

      inspectionRescheduleApi(body: body);
    }
  }

  void onPressCancelInspectionButton() {
    var inspectionRescheduleRequestModel = InspectionRescheduleRequestModel();
    inspectionRescheduleRequestModel.type = "cancelled";

    List<TimeModel> utcDateTimeList = [];
    var currentDate = DateTime.now();
    var currentDateTime = DateFormat("dd/MM/yyyy").format(currentDate);
    var selectedDate = DateFormat("yyyy-MM-dd").format(currentDate);

    utcDateTimeList.add(TimeModel(
        starttime: getUtcDateString(date: currentDateTime),
        endtime: getUtcDateString(date: currentDateTime)));
    inspectionRescheduleRequestModel.date = selectedDate;
    inspectionRescheduleRequestModel.time = utcDateTimeList;

    var body = json.encode(inspectionRescheduleRequestModel);
    inspectionRescheduleApi(body: body);
  }

  bool isValidRescheduleForm() {
    var isValid = true;
    if (firstNameController.value.text.isEmpty &&
        lastNameController.value.text.isEmpty &&
        emailController.value.text.isEmpty &&
        phoneNumberController.value.text.isEmpty) {
      firstNameError.value = true;
      lastNameError.value = true;
      emailError.value = true;
      phoneError.value = true;

      lastNameError.value = true;

      firstNameErrorMessage.value = ErrorMessages.firstNameIsEmpty;
      lastNameErrorMessage.value = ErrorMessages.lastNameIsEmpty;
      emailErrorMessage.value = ErrorMessages.emailIsEmpty;
      phoneErrorMessage.value = ErrorMessages.phoneIsEmpty;

      isValid = false;
    } else if (firstNameController.value.text.isEmpty) {
      firstNameError.value = true;
      firstNameErrorMessage.value = ErrorMessages.firstNameIsEmpty;
      isValid = false;
    } else if (firstNameController.value.text.length < 2) {
      firstNameError.value = true;
      firstNameErrorMessage.value = ErrorMessages.firstNameMatch;
      isValid = false;
    } else if (lastNameController.value.text.isEmpty) {
      lastNameError.value = true;
      lastNameErrorMessage.value = ErrorMessages.lastNameIsEmpty;
      isValid = false;
    } else if (lastNameController.value.text.length < 2) {
      lastNameError.value = true;
      lastNameErrorMessage.value = ErrorMessages.lastNameMatch;
      isValid = false;
    } else if (emailController.value.text.isEmpty) {
      emailError.value = true;
      emailErrorMessage.value = ErrorMessages.emailIsEmpty;
      isValid = false;
    } else if (!emailController.value.text.isEmail) {
      emailErrorMessage.value = ErrorMessages.emailIsNotValid;
      emailError.value = true;
      isValid = false;
    } else if (phoneNumberController.value.text.isEmpty) {
      phoneError.value = true;
      phoneErrorMessage.value = ErrorMessages.phoneIsEmpty;
      isValid = false;
    } else if (phoneNumberController.value.text.length < 7) {
      phoneError.value = true;
      phoneErrorMessage.value = ErrorMessages.phoneValid;
      isValid = false;
    } else {
      firstNameError.value = false;
      lastNameError.value = false;
      emailError.value = false;
      phoneError.value = false;
      isValid = true;
    }

    return isValid;
  }

  bool get isEnable {
    return selectedDate.value != "" &&
        selectedTime.isNotEmpty &&
        firstNameController.value.text.isNotEmpty &&
        lastNameController.value.text.isNotEmpty &&
        phoneNumberController.value.text.isNotEmpty &&
        descriptionController.value.text.isNotEmpty &&
        emailController.value.text.isNotEmpty;
  }

  void onPressViewReportButton() {
    var reportPath = inspectionDetail.value.report ?? "";
    var list = reportPath.split(".");
    var fileName = AppStrings.inspectionReport.tr;

    if (list.isNotEmpty && list.length >= 2) {
      fileName = "${list[list.length - 2]}.${list[list.length - 1]}";
    }

    Navigator.push(
        Get.context!,
        MaterialPageRoute(
          builder: (context) => FlutterFlowPdfViewer(
            networkPath: reportPath,
            title: fileName,
          ),
        ));
  }
}
