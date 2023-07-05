import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inspection_doctor_homeowner/core/routes/routes.dart';

class HomeController extends GetxController {
  var isLoading = false.obs;
  RxList<String> homeList = <String>[].obs;
  TextEditingController searchController = TextEditingController();

  var seacrhFocusNode = FocusNode().obs;

  onPressAddPropertyButton() {
    Get.toNamed(Routes.addPropertyScreen)
        ?.then((value) => homeList.add("ABC Property name"));
  }

  addFocusListeners() {
    seacrhFocusNode.value.addListener(() {
      seacrhFocusNode.refresh();
    });
  }

  disposeFocusListeners() {
    seacrhFocusNode.value.removeListener(() {});
  }

  @override
  void onInit() {
    addFocusListeners();
    super.onInit();
  }

  @override
  void onClose() {
    disposeFocusListeners();
    super.onClose();
  }
}
