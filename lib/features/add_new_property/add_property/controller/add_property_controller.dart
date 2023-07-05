import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/textfields/app_common_text_form_field.dart';

class AddPropertyController extends GetxController {
  TextEditingController propertyController = TextEditingController();
  TextEditingController streetController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController zipCodeController = TextEditingController();
  TextEditingController permitNumberController = TextEditingController();
  TextEditingController lotNumberController = TextEditingController();
  TextEditingController blockNumberController = TextEditingController();

  Rx<FocusNode> propertyFocusNode = FocusNode().obs;
  Rx<FocusNode> streetFocusNode = FocusNode().obs;
  Rx<FocusNode> cityFocusNode = FocusNode().obs;
  Rx<FocusNode> stateFocusNode = FocusNode().obs;
  Rx<FocusNode> zipCodeFocusNode = FocusNode().obs;
  Rx<FocusNode> permitNumberFocusNode = FocusNode().obs;
  Rx<FocusNode> lotNumberFocusNode = FocusNode().obs;
  Rx<FocusNode> blockNumberFocusNode = FocusNode().obs;

  RxList<DropdownModel> beddingMaterialList = <DropdownModel>[].obs;
  var selectedBaseMaterialDropDown = DropdownModel().obs;

  addFocusListeners() {
    propertyFocusNode.value.addListener(() {
      propertyFocusNode.refresh();
    });
    streetFocusNode.value.addListener(() {
      streetFocusNode.refresh();
    });
    cityFocusNode.value.addListener(() {
      cityFocusNode.refresh();
    });

    stateFocusNode.value.addListener(() {
      stateFocusNode.refresh();
    });

    zipCodeFocusNode.value.addListener(() {
      zipCodeFocusNode.refresh();
    });
    permitNumberFocusNode.value.addListener(() {
      permitNumberFocusNode.refresh();
    });

    lotNumberFocusNode.value.addListener(() {
      lotNumberFocusNode.refresh();
    });
    blockNumberFocusNode.value.addListener(() {
      blockNumberFocusNode.refresh();
    });
  }

  disposeFocusListeners() {
    propertyFocusNode.value.removeListener(() {});
    streetFocusNode.value.removeListener(() {});
    cityFocusNode.value.removeListener(() {});
    stateFocusNode.value.removeListener(() {});
    zipCodeFocusNode.value.removeListener(() {});
    permitNumberFocusNode.value.removeListener(() {});
    lotNumberFocusNode.value.removeListener(() {});
    blockNumberFocusNode.value.removeListener(() {});
  }

  @override
  void onInit() {
    addFocusListeners();
    initBaseMaterialList();
    super.onInit();
  }

  @override
  void onClose() {
    disposeFocusListeners();
    super.onClose();
  }

  onSelectBaseMaterialDropdown({required DropdownModel value}) {
    selectedBaseMaterialDropDown.value = value;
  }

  initBaseMaterialList() {
    beddingMaterialList.value = [
      DropdownModel(name: "one", id: "1"),
      DropdownModel(name: "two", id: "2"),
      DropdownModel(name: "three", id: "3"),
    ];
  }

  onPressAddPropertyButton() {
    Get.back();
  }
}
