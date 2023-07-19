import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/app_bar/common_appbar.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/common_button/common_button.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/textfields/app_common_text_form_field.dart';
import 'package:inspection_doctor_homeowner/core/constants/app_strings.dart';
import 'package:inspection_doctor_homeowner/core/theme/app_color_palette.dart';
import 'package:inspection_doctor_homeowner/features/login_signup_process/choose_map/controller/choose_map_controller.dart';

class ChooseMapScreen extends GetView<ChooseMapController> {
  const ChooseMapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightColorPalette.backgroundColor,
      appBar: commonAppBarWithOutElevation(
        title: AppStrings.chooseOnMap.tr,
        onPressBackButton: () {
          Get.back();
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: CommonButton(
          commonButtonBottonText: AppStrings.selectAddress.tr,
          onPress: () {
            controller.handlePressButton();
          }).paddingOnly(left: 20.w, right: 20.w, bottom: 20.h),
      body: SafeArea(
        child: Stack(
          children: [
            Obx(() => GoogleMap(
                  //Map widget from google_maps_flutter package

                  initialCameraPosition: CameraPosition(
                    //innital position in map
                    target: controller.changingLatLong.value, //initial position
                    zoom: 10.0, //initial zoom level
                  ),
                  markers: Set<Marker>.of(
                      controller.markers), //markers to show on map
                  mapType: MapType.normal, //map type
                  onMapCreated: (GoogleMapController gMapController) {
                    controller.googleMapController = gMapController;
                  },
                )),
            // showSearchBar(),
          ],
        ),
      ),
    );
  }

  Widget showSearchBar() {
    return Container(
      color: lightColorPalette.whiteColorPrimary.shade900,
      child: commonSearchFieldWidget(
              controller: controller.searchController,
              onChanged: (value) {
                controller.onSearch();
              },
              focusNode: controller.searchFocusNode.value,
              searchHint: AppStrings.searchAddress)
          .paddingOnly(left: 20.w, right: 20.w, top: 10.h, bottom: 10.h),
    );
  }
}
