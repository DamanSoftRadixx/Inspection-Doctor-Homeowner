import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_maps_place_picker_mb/google_maps_place_picker.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/app_bar/common_appbar.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/common_button/common_button.dart';
import 'package:inspection_doctor_homeowner/core/constants/app_strings.dart';
import 'package:inspection_doctor_homeowner/core/network_utility/app_end_points.dart';
import 'package:inspection_doctor_homeowner/core/theme/app_color_palette.dart';
import 'package:inspection_doctor_homeowner/features/login_signup_process/choose_map/controller/choose_map_controller.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class ChooseMapScreen extends GetView<ChooseMapController> {
  const ChooseMapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: lightColorPalette.whiteColorPrimary.shade900,
      appBar: showAppBar(),
      body: SafeArea(
        child: showMap(),
      ),
    );
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
    return Obx(() => PlacePicker(
          searchingText: "Please wait ...",
          selectText: AppStrings.selectAddress.tr,
          // outsideOfPickAreaText: "Place not in area",
          useCurrentLocation: true,
          selectInitialPosition: true,
          usePinPointingSearch: true,
          usePlaceDetailSearch: true,
          zoomGesturesEnabled: true,
          // zoomControlsEnabled: true,
          forceSearchOnZoomChanged: true,
          automaticallyImplyAppBarLeading: false,
          autocompleteLanguage: "en",
          region: 'us',
          hintText: AppStrings.searchAddress.tr,
          apiKey: EndPoints.mapKey,
          initialPosition: controller.initialLocation.value,
          hidePlaceDetailsWhenDraggingPin: false,
          selectedPlaceWidgetBuilder:
              (_, selectedPlace, state, isSearchBarFocused) {
            return isSearchBarFocused
                ? Container()
                : state == SearchingState.Searching
                    ? _buildLoadingIndicator()
                    : _buildSelectionDetails(
                        result: selectedPlace ?? PickResult());
          },
        ));
  }

  Widget _buildLoadingIndicator() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Center(
          child: LoadingAnimationWidget.discreteCircle(
            color: lightColorPalette.black,
            size: 48.h,
          ),
        ),
      ],
    ).paddingOnly(bottom: 50.h);
  }

  Widget _buildSelectionDetails({required PickResult result}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Center(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 20.w),
            child: Card(
              elevation: 5,
              child: Column(
                children: <Widget>[
                  Text(
                    result.formattedAddress!,
                    style: const TextStyle(fontSize: 16),
                    textAlign: TextAlign.center,
                  ).paddingOnly(bottom: 10.h),
                  CommonButton(
                      commonButtonBottonText: AppStrings.selectAddress.tr,
                      onPress: () async {
                        controller.onTapSelectAddressButton(result: result);
                      })
                ],
              ).paddingSymmetric(horizontal: 20.w, vertical: 20.h),
            ),
          ),
        ),
      ],
    ).paddingOnly(bottom: 50.h);
  }
}
