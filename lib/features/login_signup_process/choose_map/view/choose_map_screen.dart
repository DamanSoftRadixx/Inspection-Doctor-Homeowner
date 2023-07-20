import 'package:flutter/material.dart';
import 'package:flutter_place_picker/flutter_place_picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/app_bar/common_appbar.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/common_button/common_button.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/text/app_text_widget.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/textfields/app_common_text_form_field.dart';
import 'package:inspection_doctor_homeowner/core/constants/app_strings.dart';
import 'package:inspection_doctor_homeowner/core/network_utility/app_end_points.dart';
import 'package:inspection_doctor_homeowner/core/theme/app_color_palette.dart';
import 'package:inspection_doctor_homeowner/features/login_signup_process/choose_map/controller/choose_map_controller.dart';

class ChooseMapScreen extends GetView<ChooseMapController> {
  const ChooseMapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          extendBody: true,
          backgroundColor: lightColorPalette.backgroundColor,
          appBar: showAppBar(),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: controller.predictionsList.isNotEmpty
              ? const SizedBox()
              : CommonButton(
                  commonButtonBottonText: AppStrings.selectAddress.tr,
                  onPress: () async {
                    controller.onTapSelectAddressButton();
                  }).paddingOnly(left: 20.w, right: 20.w, bottom: 20.h),
          body: SafeArea(
            child: Column(
              children: [
                showSearchBar(),
                showMap(),
              ],
            ),
          ),
        ));
  }

  AppBar showAppBar() {
    return commonAppBarWithOutElevation(
      title: AppStrings.chooseOnMap.tr,
      onPressBackButton: () {
        Get.back();
      },
    );
  }

  showMap() {
    return Obx(() => Expanded(
            child: Stack(
          children: [
            FlutterPlacePicker(
                apiKey: EndPoints.mapKey,
                initialPosition: controller.googleMapsCenter.value)
            // CommonGoogleMap(
            //   controller: controller.googleMapController,
            //   onCameraIdle: (latLng) =>
            //       controller.googleMapsCenter.value = latLng,
            //   initialLocation: controller.googleMapsCenter.value,
            //   // markerColor: GoogleMarkerColor.violet,
            //   mapType: MapType.normal,
            //   style: GoogleMapStyle.standard,
            //   initialZoom: 20.0,
            //   allowInteraction: true,
            //   allowZoom: true,
            //   showZoomControls: false,
            //   showLocation: false,
            //   showCompass: false,
            //   showMapToolbar: true,
            //   showTraffic: false,
            //   myLocationButtonEnabled: false,
            //   // centerMapOnMarkerTap: true,
            // ),
            // Center(
            //   child: Stack(
            //     children: [
            //       Container(
            //         height: 164.h,
            //         width: 164.w,
            //         decoration: BoxDecoration(
            //             shape: BoxShape.circle,
            //             color: lightColorPalette.primaryBlue.withOpacity(.10)),
            //         child: Center(
            //           child: AssetWidget(
            //             asset: Asset(
            //                 type: AssetType.svg,
            //                 path: ImageResource.dropLocationPin),
            //           ),
            //         ),
            //       ),
            //       Card(
            //         child: AppTextWidget(
            //                 textAlign: TextAlign.center,
            //                 text:
            //                     "${controller.place.value.name},\n${controller.place.value.administrativeArea},\n${controller.place.value.country}",
            //                 style: CustomTextTheme.normalText(
            //                     color: lightColorPalette.primaryDarkblue))
            //             .paddingAll(5.r),
            //       )
            //     ],
            //   ),
            // ),
            // showAddressList(),
          ],
        )));
  }

  Widget showSearchBar() {
    return Column(
      children: [
        Container(
          color: lightColorPalette.whiteColorPrimary.shade900,
          child: commonSearchFieldWidget(
                  controller: controller.searchController,
                  onChanged: (value) {
                    controller.handlePressButton(value: value);
                  },
                  focusNode: controller.searchFocusNode.value,
                  searchHint: AppStrings.searchAddress)
              .paddingOnly(left: 20.w, right: 20.w, top: 10.h, bottom: 10.h),
        ),
      ],
    );
  }

  showAddressList() {
    return Visibility(
      visible: controller.predictionsList.isNotEmpty,
      child: Stack(
        children: [
          Card(
            elevation: 20,
            color: lightColorPalette.whiteColorPrimary.shade900,
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 500),
              child: ListView.builder(
                padding: EdgeInsets.only(top: 15.h),
                shrinkWrap: true,
                itemCount: controller.predictionsList.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    horizontalTitleGap: 5,
                    leading: SizedBox(
                      height: 30.h,
                      width: 30.w,
                      child: CircleAvatar(
                        child: Icon(
                          Icons.pin_drop,
                          color: Colors.white,
                          size: 15.r,
                        ),
                      ),
                    ),
                    title: AppTextWidget(
                        text:
                            controller.predictionsList[index].description ?? "",
                        style: CustomTextTheme.normalText(
                            color: lightColorPalette.primaryDarkblue)),
                    onTap: () async {
                      await controller
                          .displayPrediction(controller.predictionsList[index]);
                      controller.predictionsList.value = [];
                      controller.predictionsList.refresh();
                    },
                  );
                },
              ),
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: InkWell(
              hoverColor: Colors.transparent,
              focusColor: Colors.transparent,
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              onTap: () async {
                controller.predictionsList.value = [];
                controller.predictionsList.refresh();
              },
              child: const Icon(
                Icons.cancel_rounded,
                size: 22,
              ),
            ),
          ).paddingOnly(top: 10.h, right: 10.w)
        ],
      ).paddingOnly(left: 10.w, right: 10.w, top: 0.h),
    );
  }
}
