import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inspection_doctor_homeowner/core/common_functionality/dismiss_keyboard.dart';
import 'package:inspection_doctor_homeowner/core/constants/app_keys.dart';
import 'package:inspection_doctor_homeowner/core/constants/app_strings.dart';
import 'package:inspection_doctor_homeowner/core/network_utility/dio_exceptions.dart';
import 'package:inspection_doctor_homeowner/core/routes/routes.dart';
import 'package:inspection_doctor_homeowner/features/schedule_an_Inspection/home/model/network_model/property_list_response_model.dart';
import 'package:inspection_doctor_homeowner/features/schedule_an_Inspection/home/provider/home_provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomeController extends GetxController {
  HomeProvider homeProvider = HomeProvider();

  TextEditingController searchController = TextEditingController();

  var searchFocusNode = FocusNode().obs;

  RxBool isShowLoader = false.obs;
  RxBool isShowSearchLoader = false.obs;
  RxList<PropertyListData> propertyList = <PropertyListData>[].obs;

  ScrollController listController = ScrollController();

  RxInt start = 0.obs;
  RxBool loadMore = false.obs;
  var totalRecords = 0;
  final int pageLength = 10;

  onPressAddPropertyButton() {
    dismissKeyboard();
    Get.toNamed(Routes.addPropertyScreen)?.then((value) {
      //  update  list when added new property or update
      if (value != null) {
        var result = value;
        if (result[0][GetArgumentConstants.isPropertyAdded] == true) {
          propertyList.clear();
          getAddProperty();
        }
      }
    });
  }

  void onTapOnPropertyCard({required PropertyListData property}) {
    dismissKeyboard();
    Get.toNamed(Routes.propertyDetailScreen,
            arguments: {GetArgumentConstants.propertyCard: property})
        ?.then((value) {
      if (value != null) {
        propertyList.clear();
        var result = value;
        if (result[0][GetArgumentConstants.isPropertyAdded] == true) {
          getAddProperty();
        }
      }
    });
  }

  addFocusListeners() {
    searchFocusNode.value.addListener(() {
      searchFocusNode.refresh();
    });
  }

  disposeFocusListeners() {
    searchFocusNode.value.removeListener(() {});
  }

  RefreshController refreshController = RefreshController();

  @override
  void onInit() {
    addFocusListeners();
    listController.addListener(pagination);
    getAddProperty();
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

  void pagination() {
    log("listController.position.maxScrollExtent : ${listController.position.maxScrollExtent}");
    if ((listController.position.maxScrollExtent != 0.0 &&
        listController.position.pixels ==
            listController.position.maxScrollExtent)) {
      if (start.value < totalRecords && loadMore.value == false) {
        loadMore.value = true;
        start.value += pageLength;
        print("start.value<<<<${start.value}");
        getAddProperty();
      }
    }
  }

  void onRefresh() async {
    getAddProperty(isFromRefresh: true);
  }

  setShowLoader({required bool value}) {
    isShowLoader.value = value;
    isShowLoader.refresh();
  }

  setShowSearchLoader({required bool value}) {
    isShowSearchLoader.value = value;
    isShowSearchLoader.refresh();
  }

  onChangedSearch() {
    getAddProperty(isFromSearch: true);
  }

  getAddProperty(
      {bool isFromRefresh = false, bool isFromSearch = false}) async {
    if (isFromRefresh || isFromSearch) {
      start.value = 0;
      loadMore.value == false;
      start.refresh();
    }

    if (!isFromRefresh) {
      if (loadMore.value == false) {
        if (isFromSearch) {
          propertyList.clear();
          setShowSearchLoader(value: true);
        } else {
          setShowLoader(value: true);
        }
      }
    }

    var body = json.encode({
      "search": searchController.text,
      "start": start.value,
      "length": pageLength,
      "filter_user_createdby_admin": ""
    });

    try {
      PropertyListResponseModel response =
          await homeProvider.propertyList(body: body, isCancelToken: true) ??
              PropertyListResponseModel();
      setShowLoader(value: false);
      setShowSearchLoader(value: false);

      if (response.success == true &&
          (response.status == 201 || response.status == 200)) {
        log("message  a");
        if (isFromRefresh || isFromSearch) {
          propertyList.clear();
        }

        propertyList.addAll(response.data ?? <PropertyListData>[]);
        totalRecords = response.recordsTotal ?? 0;
        loadMore.value = false;
        propertyList.refresh();
        loadMore.refresh();

        refreshController.refreshCompleted();
        refreshController.loadComplete();
      } else {
        loadMore.value = false;
        setShowLoader(value: false);
        loadMore.refresh();
        refreshController.refreshCompleted();

        setShowSearchLoader(value: false);
        apiErrorDialog(
          message: response.message ?? AppStrings.somethingWentWrong.tr,
          okButtonPressed: () {
            Get.back();
          },
        );
      }
    } catch (e) {
      // setShowLoader(value: false);
      /* loadMore.value = false;
      loadMore.refresh();
      setShowSearchLoader(value: false);

      refreshController.refreshCompleted();*/
    }
  }
}
