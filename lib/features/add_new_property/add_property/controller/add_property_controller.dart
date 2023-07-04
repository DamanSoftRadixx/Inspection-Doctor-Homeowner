import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
    super.onInit();
  }

  @override
  void onClose() {
    disposeFocusListeners();
    super.onClose();
  }
}
