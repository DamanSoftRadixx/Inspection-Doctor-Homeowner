import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inspection_doctor_homeowner/core/routes/routes.dart';

class HomeController extends GetxController {
  var isLoading = false.obs;
  RxList<String> homeList = <String>[].obs;
  TextEditingController searchController = TextEditingController();
  FocusNode seacrhFocusNode = FocusNode();

  onPressAddPropertyButton() {
    Get.toNamed(Routes.addPropertyScreen)
        ?.then((value) => homeList.add("ABC Property name"));
  }
}
