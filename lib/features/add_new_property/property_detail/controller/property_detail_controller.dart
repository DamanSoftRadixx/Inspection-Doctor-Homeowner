import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/common_dialogs.dart';
import 'package:inspection_doctor_homeowner/core/constants/app_strings.dart';
import 'package:inspection_doctor_homeowner/core/network_utility/dio_exceptions.dart';
import 'package:inspection_doctor_homeowner/core/routes/routes.dart';
import 'package:inspection_doctor_homeowner/core/theme/app_color_palette.dart';
import 'package:inspection_doctor_homeowner/core/utils/enum.dart';
import 'package:inspection_doctor_homeowner/features/add_new_property/home/model/network_model/property_list_response_model.dart';
import 'package:inspection_doctor_homeowner/features/add_new_property/property_detail/model/local/inspection_status_model.dart';
import 'package:inspection_doctor_homeowner/features/add_new_property/property_detail/model/network_model/delete_response_model.dart';
import 'package:inspection_doctor_homeowner/features/add_new_property/property_detail/model/network_model/schedule_inspection_list_response_model.dart';
import 'package:inspection_doctor_homeowner/features/add_new_property/property_detail/provider/property_detail_provider.dart';
import 'package:inspection_doctor_homeowner/features/add_new_property/selectCategories/model/request_model/inspection_create_request_model.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class PropertyDetailController extends GetxController {
  PropertyDetailProvider propertyDetailProvider = PropertyDetailProvider();
  Rx<PropertyListData> propertyDetail = PropertyListData().obs;

  RxList<ScheduleInspectionResponseData> scheduleInspectionList =
      <ScheduleInspectionResponseData>[].obs;

  //search
  TextEditingController searchController = TextEditingController();
  onChangedSearch() {
    getScheduleInspectionList(isFromSearch: true);
  }

  var searchFocusNode = FocusNode().obs;
  RxBool isShowSearchLoader = false.obs;

  RxInt start = 0.obs;
  RxBool loadMore = false.obs;
  var totalRecords = 0;
  final int pageLength = 10;
  RefreshController refreshController = RefreshController();

  void pagination() {
    if ((listController.position.maxScrollExtent != 0.0 &&
        listController.position.pixels ==
            listController.position.maxScrollExtent)) {
      if (start.value < totalRecords && loadMore.value == false) {
        loadMore.value = true;
        start.value += pageLength;

        getScheduleInspectionList();
      }
    }
  }

  ScrollController listController = ScrollController();

  onPressScheduleInspectionButton() async {
    InspectionCreateRequestModel inspectionCreateRequestModel =
        InspectionCreateRequestModel(
      propertyId: propertyDetail.value.id,
    );

    await Get.toNamed(Routes.selectCategoriesScreen, arguments: {
      GetArgumentConstants.inspectionCreateRequestArg:
          inspectionCreateRequestModel,
    });

    getScheduleInspectionList();
  }

  getArguments() {
    var args = Get.arguments;
    if (args != null) {
      propertyDetail.value = args[GetArgumentConstants.propertyCard];
    }
  }

  @override
  void onInit() {
    getArguments();
    getScheduleInspectionList();
    listController.addListener(pagination);
    super.onInit();
  }

  @override
  void dispose() {
    refreshController.dispose();
    listController.dispose();
    super.dispose();
  }

  @override
  void onClose() {
    disposeFocusListeners();
    super.onClose();
  }

  disposeFocusListeners() {
    searchFocusNode.value.removeListener(() {});
  }

  RxBool isShowLoader = false.obs;
  setShowLoader({required bool value}) {
    isShowLoader.value = value;
    isShowLoader.refresh();
  }

  void onTapEditButton() {
    Get.toNamed(Routes.addPropertyScreen, arguments: {
      GetArgumentConstants.propertyDetail: propertyDetail.value,
      GetArgumentConstants.isPropertyDetailEdit: true
    })?.then((value) {
      if (value != null) {
        var result = value;
        if (result[0][GetArgumentConstants.isPropertyDetailEdit] == true) {
          Get.back(closeOverlays: true, result: [
            {GetArgumentConstants.isPropertyAdded: true}
          ]);
        }
      }
    });
  }

  void onTapDeleteButton() async {
    await showCommonAlertWithTwoActionsDialog(
        title: AppStrings.alert,
        leftButtonTitle: AppStrings.no,
        rightButtonTitle: AppStrings.yes,
        subHeader: AppStrings.areYouWantDelete,
        noPressed: () {
          Get.back();
        },
        yesPressed: () async {
          Get.back();
          await getDeleteProperty();
        });
  }

  Future<void> getDeleteProperty() async {
    setShowLoader(value: true);

    try {
      DeletePropertyResponseModel response = await propertyDetailProvider
              .deteleDetail(id: propertyDetail.value.id ?? "") ??
          DeletePropertyResponseModel();
      setShowLoader(value: false);
      if (response.success == true && (response.status == 204)) {
        Get.back(closeOverlays: true, result: [
          {GetArgumentConstants.isPropertyAdded: true}
        ]);
        Future.delayed(const Duration(milliseconds: 200), () {
          showCommonAlertSingleButtonDialog(
              title: AppStrings.alert,
              subHeader: response.message ?? "",
              okPressed: () {
                Get.back();
              },
              buttonTitle: AppStrings.ok);
        });
      } else {
        apiErrorDialog(
          message: response.message ?? AppStrings.somethingWentWrong,
          okButtonPressed: () {
            Get.back();
          },
        );
      }
    } catch (e) {
      setShowLoader(value: false);
    }
  }

  setShowSearchLoader({required bool value}) {
    isShowSearchLoader.value = value;
    isShowSearchLoader.refresh();
  }

  Future<void> getScheduleInspectionList(
      {bool isFromRefresh = false, bool isFromSearch = false}) async {
    if (isFromRefresh || isFromSearch) {
      start.value = 0;
      loadMore.value == false;
      start.refresh();
    }

    if (!isFromRefresh) {
      if (loadMore.value == false) {
        if (isFromSearch) {
          scheduleInspectionList.clear();
          setShowSearchLoader(value: true);
        } else {
          setShowLoader(value: true);
        }
      }
    }

    var body = json.encode({
      "property_id": propertyDetail.value.id,
      "user_id": propertyDetail.value.assignedUserId,
      "search": searchController.text,
      "start": start.value,
      "length": pageLength,
    });

    try {
      ScheduleInspectionListResponseModel response =
          await propertyDetailProvider.getScheduleInspectionList(
                  id: propertyDetail.value.id ?? "",
                  body: body,
                  isCancelToken: true) ??
              ScheduleInspectionListResponseModel();
      setShowLoader(value: false);
      if (response.success == true &&
          (response.status == 201 || response.status == 200)) {
        if (isFromRefresh || isFromSearch) {
          scheduleInspectionList.clear();
        }

        scheduleInspectionList.value = response.data ?? [];

        scheduleInspectionList
            .addAll(response.data ?? <ScheduleInspectionResponseData>[]);
        totalRecords = response.recordsTotal ?? 0;
        loadMore.value = false;
        scheduleInspectionList.refresh();
        loadMore.refresh();

        stopRefreshController();
      } else {
        loadMore.value = false;
        setShowLoader(value: false);
        loadMore.refresh();
        refreshController.refreshCompleted();

        setShowSearchLoader(value: false);
        apiErrorDialog(
          message: response.message ?? AppStrings.somethingWentWrong,
          okButtonPressed: () {
            Get.back();
          },
        );
      }
    } catch (e) {
      loadMore.value = false;
      setShowLoader(value: false);
      loadMore.refresh();
      refreshController.refreshCompleted();

      setShowSearchLoader(value: false);
    }
  }

  stopRefreshController() {
    refreshController.refreshCompleted();
    refreshController.loadComplete();
  }

  void onRefresh() async {
    getScheduleInspectionList(isFromRefresh: true);
  }

  Future<void> onInspectionListItem({required int index}) async {
    var listData = scheduleInspectionList[index];
    await Get.toNamed(Routes.inspectionDetailScreen,
        arguments: {GetArgumentConstants.inspectionId: listData.id});
    getScheduleInspectionList();
  }

  InspectionStatusModel getInspectionStatus({required String inspectionId}) {
    var inspectionStatusModel = InspectionStatusModel(
        message: "", color: lightColorPalette.primaryBlue);

    if (inspectionId == InspectionHistoryStatusEnum.newInspection.value) {
      inspectionStatusModel.message =
          InspectionListStatus.inspectorIsNotAssignedYet.tr;
      inspectionStatusModel.color = lightColorPalette.royalBlue;
    } else if (inspectionId ==
        InspectionHistoryStatusEnum.inspectionAcccepted.value) {
      inspectionStatusModel.message = InspectionListStatus.scheduled.tr;
      inspectionStatusModel.color = lightColorPalette.green;
    } else if (inspectionId ==
        InspectionHistoryStatusEnum.homeownerInspectionRescheduled.value) {
      inspectionStatusModel.message = InspectionListStatus.rescheduled.tr;
      inspectionStatusModel.color = lightColorPalette.goldenrod;
    } else if (inspectionId ==
        InspectionHistoryStatusEnum.homeownerInspectionCanceled.value) {
      inspectionStatusModel.message = InspectionListStatus.canceled.tr;
      inspectionStatusModel.color = lightColorPalette.redDark;
    } else if (inspectionId ==
        InspectionHistoryStatusEnum.inspectorInspectionCanceled.value) {
      inspectionStatusModel.message = InspectionListStatus.canceled.tr;
      inspectionStatusModel.color = lightColorPalette.redDark;
    } else if (inspectionId ==
        InspectionHistoryStatusEnum.inspectorInspectionRescheduled.value) {
      inspectionStatusModel.message = InspectionListStatus.rescheduled.tr;
      inspectionStatusModel.color = lightColorPalette.goldenrod;
    } else if (inspectionId ==
        InspectionHistoryStatusEnum.inspectorOnTheWay.value) {
      inspectionStatusModel.message = InspectionListStatus.onTheWay.tr;
      inspectionStatusModel.color = Colors.orange;
    } else if (inspectionId ==
        InspectionHistoryStatusEnum.inspectionStart.value) {
      inspectionStatusModel.message = InspectionListStatus.onTheWay.tr;
      inspectionStatusModel.color = lightColorPalette.dodgerBlue;
    } else if (inspectionId ==
        InspectionHistoryStatusEnum.inspectionDone.value) {
      inspectionStatusModel.message = InspectionListStatus.done.tr;
      inspectionStatusModel.color = lightColorPalette.emeraldGreen;
    } else if (inspectionId ==
        InspectionHistoryStatusEnum.inspectionReportCompleted.value) {
      inspectionStatusModel.message =
          InspectionListStatus.inspectionComplete.tr;
      inspectionStatusModel.color = lightColorPalette.emeraldGreen;
    } else if (inspectionId ==
        InspectionHistoryStatusEnum.inspectionReportCorrections.value) {
      inspectionStatusModel.message =
          InspectionListStatus.correctionRequired.tr;
      inspectionStatusModel.color = lightColorPalette.red;
    }
    return inspectionStatusModel;
  }
}
