import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inspection_doctor_homeowner/core/constants/app_strings.dart';
import 'package:inspection_doctor_homeowner/core/network_utility/dio_exceptions.dart';
import 'package:inspection_doctor_homeowner/core/routes/routes.dart';
import 'package:inspection_doctor_homeowner/features/add_new_property/home/model/network_model/property_list_response_model.dart';
import 'package:inspection_doctor_homeowner/features/add_new_property/home/provider/home_provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomeController extends GetxController {
  HomeProvider homeProvider = HomeProvider();
  var isLoading = false.obs;

  TextEditingController searchController = TextEditingController();

  var seacrhFocusNode = FocusNode().obs;

  RxBool isShowLoader = false.obs;

  RxBool isShowNoDataFound = false.obs;

  RxString search = "".obs;

  RxList<PropertyListData> propertyList = <PropertyListData>[].obs;

  ScrollController listController = ScrollController();

  RxInt start = 0.obs;
  RxBool loadMore = false.obs;
  final int length = 2;

  onPressAddPropertyButton() {
    Get.toNamed(Routes.addPropertyScreen);
  }

  addFocusListeners() {
    seacrhFocusNode.value.addListener(() {
      seacrhFocusNode.refresh();
    });
  }

  disposeFocusListeners() {
    seacrhFocusNode.value.removeListener(() {});
  }

  static const pageSize = 2;

  RefreshController refreshController = RefreshController();

  @override
  void onInit() {
    addFocusListeners();
    super.onInit();
    listController.addListener(pagination);
    getAddProperty();
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
    if ((listController.position.pixels ==
        listController.position.maxScrollExtent)) {
      if ((propertyList.length) > start.value) {
        loadMore.value = true;
        start.value += length;
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

  onSeacrh(String searchText) {
    search.value = searchText;
    getAddProperty();
  }

  getAddProperty({bool isFromRefresh = false}) async {
    if (isFromRefresh) {
      start.value = 0;
      start.refresh();
    }

    if (loadMore.value == false) {
      setShowLoader(value: true);
    }

    var body = json.encode({
      "search": search.value,
      "start": start.value,
      "length": length,
      "filter_user_createdby_admin": ""
    });

    try {
      PropertyListResponseModel response =
          await homeProvider.propertyList(body: body) ??
              PropertyListResponseModel();
      setShowLoader(value: false);

      if (response.success == true &&
          (response.status == 201 || response.status == 200)) {
        final int length = response.data?.length ?? 0;
        if (length == 0) {
          setShowLoader(value: false);
          loadMore.value = false;
        } else {
          if (isFromRefresh) {
            propertyList.clear();
          }
          setShowLoader(value: false);

          propertyList.value = response.data ?? [];
          propertyList.refresh();
          loadMore.refresh();
        }

        refreshController.refreshCompleted();

        log("message ${propertyList.length}");
      } else {
        setShowLoader(value: false);
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
}
