import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart' as dio;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_place_picker_mb/google_maps_place_picker.dart';
import 'package:inspection_doctor_homeowner/core/common_functionality/location/place.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/text/app_text_widget.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/textfields/app_common_text_form_field.dart';
import 'package:inspection_doctor_homeowner/core/constants/app_strings.dart';
import 'package:inspection_doctor_homeowner/core/network_utility/dio_exceptions.dart';
import 'package:inspection_doctor_homeowner/core/routes/routes.dart';
import 'package:inspection_doctor_homeowner/core/theme/app_color_palette.dart';
import 'package:inspection_doctor_homeowner/features/add_new_property/add_property/model/network_model/add_property_response_model.dart';
import 'package:inspection_doctor_homeowner/features/add_new_property/add_property/model/network_model/get_county_response_model.dart';
import 'package:inspection_doctor_homeowner/features/add_new_property/add_property/model/network_model/property_update_response_model.dart';
import 'package:inspection_doctor_homeowner/features/add_new_property/add_property/model/network_model/upload_doc_response_model.dart';
import 'package:inspection_doctor_homeowner/features/add_new_property/add_property/provider/add_property_provider.dart';
import 'package:inspection_doctor_homeowner/features/add_new_property/home/model/network_model/property_list_response_model.dart';
import 'package:keyboard_actions/keyboard_actions.dart';

class AddPropertyController extends GetxController {
  AddPropertyProvider addPropertyProvider = AddPropertyProvider();
  Rx<TextEditingController> propertyController = TextEditingController().obs;
  Rx<TextEditingController> streetController = TextEditingController().obs;
  Rx<TextEditingController> cityController = TextEditingController().obs;
  Rx<TextEditingController> stateController = TextEditingController().obs;
  Rx<TextEditingController> zipCodeController = TextEditingController().obs;
  Rx<TextEditingController> permitNumberController =
      TextEditingController().obs;
  Rx<TextEditingController> lotNumberController = TextEditingController().obs;
  Rx<TextEditingController> blockNumberController = TextEditingController().obs;

  Rx<FocusNode> propertyFocusNode = FocusNode().obs;
  Rx<FocusNode> streetFocusNode = FocusNode().obs;
  Rx<FocusNode> cityFocusNode = FocusNode().obs;
  Rx<FocusNode> stateFocusNode = FocusNode().obs;
  Rx<FocusNode> zipCodeFocusNode = FocusNode().obs;
  Rx<FocusNode> permitNumberFocusNode = FocusNode().obs;
  Rx<FocusNode> lotNumberFocusNode = FocusNode().obs;
  Rx<FocusNode> blockNumberFocusNode = FocusNode().obs;

  // RxList<DropdownModel> beddingMaterialList = <DropdownModel>[].obs;

  RxBool isShowLoader = false.obs;

  Rx<File> pdfFile = File("").obs;

  RxBool propertyNameError = false.obs;
  RxBool streetError = false.obs;
  RxBool cityError = false.obs;
  RxBool stateError = false.obs;
  RxBool zipCodeError = false.obs;
  RxBool permitNumberError = false.obs;
  RxBool lotNumberError = false.obs;
  RxBool blockNumberError = false.obs;
  RxBool countyError = false.obs;
  RxBool documentError = false.obs;

  RxString propertyNameErrorMessage = "".obs;
  RxString streetErrorMessage = "".obs;
  RxString cityErrorMessage = "".obs;
  RxString stateErrorMessage = "".obs;
  RxString zipCodeErrorMessage = "".obs;
  RxString permitNumberErrorMessage = "".obs;
  RxString lotNumberErrorMessage = "".obs;
  RxString blockNumberErrorMessage = "".obs;
  RxString countyErrorMessage = "".obs;
  RxString documentErrorMessage = "".obs;

  RxBool isUplodedingFile = false.obs;
  RxBool isPropertyDetailEdit = false.obs;

  Rx<PropertyListData> propertyDetail = PropertyListData().obs;

  Rx<UploadDocResponseData> uploadData = UploadDocResponseData().obs;

  Rx<FFPlace> place = const FFPlace().obs;

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

  RxList<DropdownModel> countiesList = <DropdownModel>[].obs;
  var selectedBaseMaterialDropDown = DropdownModel().obs;

  @override
  void onInit() {
    getArguments();
    getCounties();
    addFocusListeners();

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

  onPressAddPropertyButton() {
    validate(
      perpertyName: propertyController.value.text,
      street: streetController.value.text,
      city: cityController.value.text,
      state: stateController.value.text,
      zipCode: zipCodeController.value.text,
      permitNumber: permitNumberController.value.text,
      lotNumber: lotNumberController.value.text,
      blockNumber: blockNumberController.value.text,
      docment: pdfFile.value.path,
      county: selectedBaseMaterialDropDown.value.id,
    );
  }

  setShowLoader({required bool value}) {
    isShowLoader.value = value;
    isShowLoader.refresh();
  }

  getArguments() {
    var args = Get.arguments;
    if (args != null) {
      isPropertyDetailEdit.value =
          args[GetArgumentConstants.isPropertyDetailEdit];
      propertyDetail.value = args[GetArgumentConstants.propertyDetail];

      if (isPropertyDetailEdit.value == true) {
        propertyController.value.text = propertyDetail.value.propertyName ?? "";
        streetController.value.text = propertyDetail.value.street ?? "";
        cityController.value.text = propertyDetail.value.city ?? "";
        stateController.value.text = propertyDetail.value.state ?? "";
        zipCodeController.value.text = propertyDetail.value.zipCode ?? "";
        permitNumberController.value.text =
            propertyDetail.value.permitNumber ?? "";
        lotNumberController.value.text = propertyDetail.value.lotNumber ?? "";
        blockNumberController.value.text =
            propertyDetail.value.blockNumber ?? "";
        lotNumberController.value.text = propertyDetail.value.blockNumber ?? "";

        // String? id = propertyDetail.value.architecturelDrawing?.id;

        log("message>>>>> ${propertyDetail.value.countyId?.name}");

        log("message>>>>> ${propertyDetail.value.architecturelDrawing?.id}");

        if (propertyDetail.value.architecturelDrawing?.id != "" &&
            propertyDetail.value.architecturelDrawing?.id != null) {
          pdfFile.value =
              File(propertyDetail.value.architecturelDrawing?.url ?? "");

          uploadData.value.id = propertyDetail.value.architecturelDrawing?.id;
        }
      }
    }
  }

  void validate({
    required String perpertyName,
    required String street,
    required String city,
    required String state,
    required String zipCode,
    required String permitNumber,
    required String lotNumber,
    required String blockNumber,
    required String county,
    required String docment,
  }) async {
    if (perpertyName.isEmpty &&
        street.isEmpty &&
        city.isEmpty &&
        state.isEmpty &&
        zipCode.isEmpty &&
        permitNumber.isEmpty &&
        lotNumber.isEmpty &&
        blockNumber.isEmpty &&
        county.isEmpty &&
        docment.isEmpty) {
      propertyNameError.value = true;
      streetError.value = true;
      cityError.value = true;
      stateError.value = true;
      zipCodeError.value = true;
      permitNumberError.value = true;
      lotNumberError.value = true;
      blockNumberError.value = true;
      countyError.value = true;
      documentError.value = true;
      propertyNameErrorMessage.value = ErrorMessages.propertyEmty;
      propertyNameErrorMessage.value = ErrorMessages.propertyEmty;
      streetErrorMessage.value = ErrorMessages.streetEmty;
      cityErrorMessage.value = ErrorMessages.cityEmty;
      zipCodeErrorMessage.value = ErrorMessages.zipCodeEmty;
      permitNumberErrorMessage.value = ErrorMessages.permitEmty;
      lotNumberErrorMessage.value = ErrorMessages.lotEmty;
      blockNumberErrorMessage.value = ErrorMessages.blockEmty;
      stateErrorMessage.value = ErrorMessages.stateEmty;
      countyErrorMessage.value = ErrorMessages.countyEmty;
      documentErrorMessage.value = ErrorMessages.docEmty;
    } else if (perpertyName.isEmpty) {
      propertyNameError.value = true;
      propertyNameErrorMessage.value = ErrorMessages.propertyEmty;
    } else if (street.isEmpty) {
      streetError.value = true;
      streetErrorMessage.value = ErrorMessages.streetEmty;
    } else if (city.isEmpty) {
      cityError.value = true;
      cityErrorMessage.value = ErrorMessages.cityEmty;
    } else if (state.isEmpty) {
      stateError.value = true;
      stateErrorMessage.value = ErrorMessages.stateEmty;
    } else if (zipCode.isEmpty) {
      zipCodeError.value = true;
      zipCodeErrorMessage.value = ErrorMessages.zipCodeEmty;
    } else if (permitNumber.isEmpty) {
      permitNumberError.value = true;
      permitNumberErrorMessage.value = ErrorMessages.permitEmty;
    } else if (lotNumber.isEmpty) {
      lotNumberError.value = true;
      lotNumberErrorMessage.value = ErrorMessages.lotEmty;
    } else if (blockNumber.isEmpty) {
      blockNumberError.value = true;
      blockNumberErrorMessage.value = ErrorMessages.blockEmty;
    } else if (county.isEmpty) {
      countyError.value = true;
      countyErrorMessage.value = ErrorMessages.countyEmty;
    } else if (docment.isEmpty) {
      documentError.value = true;
      documentErrorMessage.value = ErrorMessages.docEmty;
    } else {
      propertyNameError.value = false;
      streetError.value = false;
      cityError.value = false;
      stateError.value = false;
      zipCodeError.value = false;
      permitNumberError.value = false;
      lotNumberError.value = false;
      blockNumberError.value = false;
      countyError.value = false;
      documentError.value = false;

      if (isPropertyDetailEdit.value) {
        if (propertyDetail.value.architecturelDrawing?.url !=
            pdfFile.value.path) {
          uploadDocuments();
        } else {
          updateAddProperty();
        }
      } else {
        uploadDocuments();
      }
    }
  }

  void onChangedPropertyNameTextField({required String value}) {
    if (value.length == 1 && value.contains(" ")) {
      propertyController.value.text = propertyController.value.text.trim();
    }
    if (value.length >= 2) {
      propertyNameError.value = false;
    }
  }

  void onChangedStreetTextField({required String value}) {
    if (value.length == 1 && value.contains(" ")) {
      streetController.value.text = streetController.value.text.trim();
    }
    if (value.length >= 2) {
      streetError.value = false;
    }
  }

  void onChangedCityTextField({required String value}) {
    if (value.length == 1 && value.contains(" ")) {
      cityController.value.text = cityController.value.text.trim();
    }
    if (value.length >= 2) {
      cityError.value = false;
    }
  }

  void onChangedStateTextField({required String value}) {
    if (value.length == 1 && value.contains(" ")) {
      stateController.value.text = stateController.value.text.trim();
    }
    if (value.length >= 2) {
      stateError.value = false;
    }
  }

  void onChangedZipCodeTextField({required String value}) {
    if (value.length >= 2) {
      zipCodeError.value = false;
    }
  }

  void onChangedPermitNumberTextField({required String value}) {
    if (value.length >= 2) {
      permitNumberError.value = false;
    }
  }

  void onChangedLotNumberTextField({required String value}) {
    if (value.length >= 2) {
      lotNumberError.value = false;
    }
  }

  void onChangedBlocTextField({required String value}) {
    if (value.length >= 2) {
      blockNumberError.value = false;
    }
  }

  KeyboardActionsConfig buildConfig(BuildContext context) {
    return KeyboardActionsConfig(
      keyboardActionsPlatform: KeyboardActionsPlatform.IOS,
      keyboardBarColor: Colors.grey[200],
      nextFocus: true,
      actions: [
        KeyboardActionsItem(
            focusNode: zipCodeFocusNode.value,
            displayArrows: false,
            toolbarButtons: [
              (node) {
                return GestureDetector(
                  onTap: () => zipCodeFocusNode.value.requestFocus(),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: AppTextWidget(
                      textAlign: TextAlign.start,
                      text: AppStrings.next.tr,
                      style: CustomTextTheme.normalText(
                        color: lightColorPalette.black,
                      ),
                    ),
                  ),
                );
              }
            ]),
        KeyboardActionsItem(
            focusNode: permitNumberFocusNode.value,
            displayArrows: false,
            toolbarButtons: [
              (node) {
                return GestureDetector(
                  onTap: () => permitNumberFocusNode.value.requestFocus(),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: AppTextWidget(
                      textAlign: TextAlign.start,
                      text: AppStrings.next.tr,
                      style: CustomTextTheme.normalText(
                        color: lightColorPalette.black,
                      ),
                    ),
                  ),
                );
              }
            ]),
        KeyboardActionsItem(
            focusNode: lotNumberFocusNode.value,
            displayArrows: false,
            toolbarButtons: [
              (node) {
                return GestureDetector(
                  onTap: () => lotNumberFocusNode.value.requestFocus(),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: AppTextWidget(
                      textAlign: TextAlign.start,
                      text: AppStrings.next.tr,
                      style: CustomTextTheme.normalText(
                        color: lightColorPalette.black,
                      ),
                    ),
                  ),
                );
              }
            ]),
        KeyboardActionsItem(
            focusNode: blockNumberFocusNode.value,
            displayArrows: false,
            toolbarButtons: [
              (node) {
                return GestureDetector(
                  onTap: () => blockNumberFocusNode.value.requestFocus(),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: AppTextWidget(
                      textAlign: TextAlign.start,
                      text: AppStrings.next.tr,
                      style: CustomTextTheme.normalText(
                        color: lightColorPalette.black,
                      ),
                    ),
                  ),
                );
              }
            ]),
      ],
    );
  }

  Future<void> onTapUploadPDF() async {
    FilePickerResult? result = await FilePicker.platform
        .pickFiles(type: FileType.custom, allowedExtensions: ['pdf']);

    if (result != null) {
      pdfFile.value = File(result.files.single.path ?? "");

      log("onTapUploadPDF ${pdfFile.value.path}");
      documentError.value = false;
    } else {
      // User canceled the picker
    }
  }

  getCounties() async {
    setShowLoader(value: true);
    try {
      GetCountyResponseModel response =
          await addPropertyProvider.counties() ?? GetCountyResponseModel();
      setShowLoader(value: false);
      if (response.success == true &&
          (response.status == 201 || response.status == 200)) {
        if (response.data?.counties != []) {
          DropdownModel();

          response.data?.counties
              ?.map((e) => countiesList.add(DropdownModel(
                    id: e.id ?? "",
                    name: e.name ?? "",
                    stateId: e.stateId ?? "",
                  )))
              .toList();
        }
        if (propertyDetail.value.countyId?.name != "") {
          countiesList.map(
            (element) {
              if (element.name == propertyDetail.value.countyId?.name) {
                onSelectBaseMaterialDropdown(value: element);
              }
            },
          ).toList();
        }

        //   //  snackbar(response.message ?? "");
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

  void uploadDocuments() async {
    setShowLoader(value: true);

    var formData = dio.FormData.fromMap({
      'type': 'architecturel_drawing',
      'file_type': 'file',
      "files": await dio.MultipartFile.fromFile(pdfFile.value.path),
    });

    try {
      UploadDocResponseModel response =
          await addPropertyProvider.uploadDoc(body: formData) ??
              UploadDocResponseModel();

      if (response.success == true &&
          (response.status == 201 || response.status == 200)) {
        uploadData.value = response.data?.first ?? UploadDocResponseData();
        //  snackbar(response.message ?? "");

        log("uploadDocuments ${uploadData.value.id}");

        isPropertyDetailEdit.value ? updateAddProperty() : getAddProperty();
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

  getAddProperty() async {
    // setShowLoader(value: true);

    var body = json.encode({
      "assigned_user_id": "",
      "property_name": propertyController.value.text,
      "street": streetController.value.text,
      "city": cityController.value.text,
      "zip_code": zipCodeController.value.text,
      "lot_number": lotNumberController.value.text,
      "block_number": blockNumberController.value.text,
      "permit_number": permitNumberController.value.text,
      "state": stateController.value.text,
      "county_id": selectedBaseMaterialDropDown.value.id,
      "architecturel_drawing": uploadData.value.id
    });

    try {
      AddPropertyResponseModel response =
          await addPropertyProvider.addProperty(body: body) ??
              AddPropertyResponseModel();
      setShowLoader(value: false);
      if (response.success == true &&
          (response.status == 201 || response.status == 200)) {
        Get.back(closeOverlays: true, result: [
          {GetArgumentConstants.isPropertyAdded: true}
        ]);
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

  updateAddProperty() async {
    setShowLoader(value: true);

    var body = json.encode({
      "property_name": propertyController.value.text,
      "street": streetController.value.text,
      "city": cityController.value.text,
      "zip_code": zipCodeController.value.text,
      "lot_number": lotNumberController.value.text,
      "block_number": blockNumberController.value.text,
      "permit_number": permitNumberController.value.text,
      "state": stateController.value.text,
      "county_id": selectedBaseMaterialDropDown.value.id,
      "architecturel_drawing": uploadData.value.id
    });

    log("uploadDocuments>>>> $body");

    try {
      PropertyUpdateResponseModel response =
          await addPropertyProvider.updatePropertyDetail(
                  body: body, id: propertyDetail.value.id ?? "") ??
              PropertyUpdateResponseModel();
      setShowLoader(value: false);
      if (response.success == true &&
          (response.status == 201 || response.status == 200)) {
        // Get.back(closeOverlays: true, result: [
        //   {GetArgumentConstants.isPropertyAdded: true}
        // ]);

        // Get.until(
        //     (route) => route.settings.name == Routes.dashboard ? true : false);
        Get.back(result: [
          {GetArgumentConstants.isPropertyDetailEdit: true}
        ]);
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

  void onTapChooseButton() {
    Get.toNamed(Routes.chooseMap)?.then((value) async {
      if (value != null) {
        PickResult result = value[0][GetArgumentConstants.googleAddressPlace];

        // log("adrAddress ${result.adrAddress}");

        // log("message>>>>>> ${result.formattedAddress}");
        // log("message>>>>> ${result.addressComponents?.first.longName}");
        // log("message ${result.placeId}");

        // for (var i in result.addressComponents ?? []) {
        //   print("Long Name: ${i.longName}   Long Name: ${i.types}");
        // }

        place.value = FFPlace(
          latLng: LatLng(
            result.geometry?.location.lat ?? 0,
            result.geometry?.location.lng ?? 0,
          ),
          name: result.name ?? "",
          address: result.addressComponents
                  ?.firstWhereOrNull((e) => e.types.contains('subpremise'))
                  ?.longName ??
              "",
          city: result.addressComponents
                  ?.firstWhereOrNull((e) => e.types.contains('locality'))
                  ?.longName ??
              result.addressComponents
                  ?.firstWhereOrNull((e) => e.types.contains('sublocality'))
                  ?.longName ??
              '',
          state: result.addressComponents
                  ?.firstWhereOrNull(
                      (e) => e.types.contains('administrative_area_level_1'))
                  ?.longName ??
              '',
          country: result.addressComponents
                  ?.firstWhereOrNull((e) => e.types.contains('country'))
                  ?.longName ??
              '',
          zipCode: result.addressComponents
                  ?.firstWhereOrNull((e) => e.types.contains('postal_code'))
                  ?.longName ??
              '',
        );

        streetController.value.text = place.value.address;
        cityController.value.text = place.value.city;
        stateController.value.text = place.value.state;
        zipCodeController.value.text = place.value.zipCode;
      }
    });
  }

  bool get isAppPropertyButtonEnable {
    return propertyController.value.text.isNotEmpty &&
        streetController.value.text.isNotEmpty &&
        cityController.value.text.isNotEmpty &&
        stateController.value.text.isNotEmpty &&
        zipCodeController.value.text.isNotEmpty &&
        permitNumberController.value.text.isNotEmpty &&
        lotNumberController.value.text.isNotEmpty &&
        blockNumberController.value.text.isNotEmpty &&
        selectedBaseMaterialDropDown.value.id.isNotEmpty &&
        pdfFile.value.path.isNotEmpty;
  }
}
