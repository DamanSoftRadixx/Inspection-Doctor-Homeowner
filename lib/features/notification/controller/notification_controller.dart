import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inspection_doctor_homeowner/core/constants/app_keys.dart';
import 'package:inspection_doctor_homeowner/core/constants/app_strings.dart';
import 'package:inspection_doctor_homeowner/core/date_formatter/date_formatter.dart';
import 'package:inspection_doctor_homeowner/core/network_utility/dio_exceptions.dart';
import 'package:inspection_doctor_homeowner/core/routes/routes.dart';
import 'package:inspection_doctor_homeowner/features/notification/model/network/notification_edit_response_model.dart';
import 'package:inspection_doctor_homeowner/features/notification/model/network/notification_response_model.dart';
import 'package:inspection_doctor_homeowner/features/notification/provider/notification_provider.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class NotificationController extends GetxController {
  NotificationProvider notificationProvider = NotificationProvider();
  var isShowNoInspectionDialogUI = false.obs;
  //Loader
  RxBool isShownotificationLoader = false.obs;
  RxBool isShowOnInitLoader = false.obs;
  RxBool isShowScheduledLoader = false.obs;
  //pagination scheduled insepction
  ScrollController notificationListController = ScrollController();
  RxInt notificationStart = 0.obs;
  RxBool notificationLoadMore = false.obs;
  final int notificationLength = 10;
  RxInt notificationTotalNumberOfRecord = 0.obs;

  RxList<NotificationResponseModelData> notificationList =
      <NotificationResponseModelData>[].obs;

  RefreshController notificationRefreshController = RefreshController();

  setScheduledLoader({required bool value}) {
    isShowScheduledLoader.value = value;
    isShowScheduledLoader.refresh();
  }

  setOnInitLoader({required bool value}) {
    isShowOnInitLoader.value = value;
    isShowOnInitLoader.refresh();
  }

  setShownotificationLoader({required bool value}) {
    isShownotificationLoader.value = value;
    isShownotificationLoader.refresh();
  }

  bool compairDate(NotificationResponseModelData data) {
    bool result = false;

    DateTime currentDate =
        DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
    DateTime notificationDate = DateFormat("MM/dd/yyyy")
        .parse(getLocalDateFromUtc(dateString: data.createdAt ?? ""));
    result = currentDate.compareTo(notificationDate) == 0;

    return result;
  }

  getNotification({
    bool isFromRefresh = false,
    bool isFromOnInit = false,
    // bool isFromSearch = false
  }) async {
    if (isFromRefresh) {
      notificationStart.value = 0;
      notificationStart.refresh();
    }

    if (!isFromRefresh &&
        !isFromOnInit &&
        notificationLoadMore.value == false) {
      setScheduledLoader(value: true);
    }

    var body = json.encode({"start": 0, "length": 10});

    try {
      NotificationResponseModel response =
          await notificationProvider.notificationList(body: body) ??
              NotificationResponseModel();
      setScheduledLoader(value: false);
      if (response.success == true &&
          (response.status == 201 || response.status == 200)) {
        if (isFromRefresh) {
          notificationList.clear();
        }
        notificationList.value.addAll(response.data ?? []);
        notificationTotalNumberOfRecord.value = response.recordsTotal ?? 0;
        notificationLoadMore(false);
        notificationList.refresh();
        stopRefreshController();

        if (!isFromOnInit) {
          showHideNoInspectionDialog();
        }
      } else {
        stopRefreshController();
        apiErrorDialog(
          message: response.message ?? AppStrings.somethingWentWrong.tr,
          okButtonPressed: () {
            Get.back();
          },
        );
      }
    } catch (e) {
      stopRefreshController();
    }
  }

  void paginationNotification() {
    if ((notificationListController.position.pixels ==
        notificationListController.position.maxScrollExtent)) {
      if (notificationTotalNumberOfRecord.value > notificationStart.value &&
          notificationList.length < notificationTotalNumberOfRecord.value &&
          !(notificationLoadMore.value)) {
        notificationLoadMore.value = true;
        notificationStart.value += notificationLength;

        getNotification();
      }
    }
  }

  void onTapCard({required String inspectionId, required String id}) {
    editStatus(id: id, inspection_id: inspectionId);
  }

  @override
  void onInit() {
    notificationListController.addListener(paginationNotification);
    hitInspectionApis();
    super.onInit();
  }

  void onRefreshnotifications() {
    getNotification(isFromRefresh: true);
  }

  stopRefreshController() {
    notificationRefreshController.refreshCompleted();
    notificationRefreshController.loadComplete();
  }

  hitInspectionApis() async {
    setOnInitLoader(value: true);
    await getNotification(isFromOnInit: true);
    showHideNoInspectionDialog();
    setOnInitLoader(value: false);
  }

  showHideNoInspectionDialog() {
    if (notificationList.isEmpty) {
      isShowNoInspectionDialogUI.value = true;
    } else {
      isShowNoInspectionDialogUI.value = false;
    }
    isShowNoInspectionDialogUI.refresh();
  }

  editStatus({required String inspection_id, required String id}) async {
    setOnInitLoader(value: true);

    try {
      NotificationEditModel response =
          await notificationProvider.editNotificationStatus(id: id) ??
              NotificationEditModel();

      setOnInitLoader(value: false);

      if (response.success == true) {
        if (inspection_id != "") {
          Get.toNamed(Routes.inspectionDetailScreen,
                  arguments: {GetArgumentConstants.inspectionId: inspection_id})
              ?.then((value) {
            if (value != null) {
              bool result = value[0][GetArgumentConstants.isNeedToUpdateList];

              if (result == true) {
                getNotification();
              }
            }
          });
        } else {
          onRefreshnotifications();
        }
      } else {
        setOnInitLoader(value: false);
        apiErrorDialog(
          message: response.message ?? AppStrings.somethingWentWrong.tr,
          okButtonPressed: () {
            Get.back();
          },
        );
      }
    } catch (e) {
      setOnInitLoader(value: false);
    }
  }
}
