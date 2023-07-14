import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:inspection_doctor_homeowner/core/constants/app_strings.dart';
import 'package:inspection_doctor_homeowner/core/network_utility/dio_exceptions.dart';
import 'package:inspection_doctor_homeowner/core/routes/routes.dart';
import 'package:inspection_doctor_homeowner/features/add_new_property/home/model/network_model/property_list_response_model.dart';
import 'package:inspection_doctor_homeowner/features/add_new_property/home/provider/home_provider.dart';

class HomeController extends GetxController {
  HomeProvider homeProvider = HomeProvider();
  var isLoading = false.obs;

  TextEditingController searchController = TextEditingController();

  var seacrhFocusNode = FocusNode().obs;

  RxBool isShowLoader = false.obs;

  RxBool isShowNoDataFound = false.obs;

  RxString search = "".obs;

  RxList<PropertyListData> propertyList = <PropertyListData>[].obs;

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

  final PagingController<int, PropertyListData> pagingController =
      PagingController(firstPageKey: 0);

  @override
  void onInit() {
    getAddProperty(pageKey: 0, isShowLoader: true);
    pagingController.addPageRequestListener((pageKey) {
      log("addPageRequestListener $pageKey");
      getAddProperty(pageKey: pageKey, isShowLoader: false);
    });
    //
    addFocusListeners();
    super.onInit();
  }

  @override
  void dispose() {
    pagingController.dispose();
    super.dispose();
  }

  @override
  void onClose() {
    disposeFocusListeners();
    super.onClose();
  }

  setShowLoader({required bool value}) {
    isShowLoader.value = value;
    isShowLoader.refresh();
  }

  onSeacrh(String searchText) {
    search.value = searchText;
    getAddProperty(
      pageKey: 0,
      isShowLoader: true,
    );
  }

  getAddProperty({
    required int pageKey,
    required bool isShowLoader,
  }) async {
    if (isShowLoader == true) {
      setShowLoader(value: true);
    }

    var body = json.encode({
      "search": search.value,
      "start": pageKey,
      "length": pageSize,
      "filter_user_createdby_admin": ""
    });

    try {
      PropertyListResponseModel response =
          await homeProvider.propertyList(body: body) ??
              PropertyListResponseModel();
      setShowLoader(value: false);

      if (search.value.isNotEmpty) {
        pagingController.itemList?.clear();
      }

      if (response.success == true &&
          (response.status == 201 || response.status == 200)) {
        final int length = response.data?.length ?? 0;
        if (length == 0) {
          isShowNoDataFound.value = true;
          propertyList.value = response.data ?? [];
          propertyList.refresh();
          final isLastPage = propertyList.length < pageSize;
          if (isLastPage) {
            pagingController.appendLastPage(propertyList);
          } else {
            final nextPageKey = pageKey + propertyList.length;
            pagingController.appendPage(propertyList, nextPageKey);
          }
        } else {
          isShowNoDataFound.value = false;
          propertyList.value = response.data ?? [];
          propertyList.refresh();
          final isLastPage = propertyList.length < pageSize;

          if (isLastPage) {
            pagingController.appendLastPage(propertyList);
          } else {
            final nextPageKey = pageKey + propertyList.length;
            pagingController.appendPage(propertyList, nextPageKey);
          }
        }
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
