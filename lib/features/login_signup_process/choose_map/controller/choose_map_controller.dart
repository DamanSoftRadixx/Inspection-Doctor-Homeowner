import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_place_picker_mb/google_maps_place_picker.dart';
import 'package:inspection_doctor_homeowner/core/common_functionality/location/location.dart';
import 'package:inspection_doctor_homeowner/core/constants/app_strings.dart';

class ChooseMapController extends GetxController {
  //contrller for Google map

  Rx<LatLng> initialLocation =
      const LatLng(37.42796133580664, -122.085749655962).obs;

  @override
  void onInit() {
    // getUserLocation();
    super.onInit();
  }

  getUserLocation() async {
    await getCurrentUserLocation(
            defaultLocation: const LatLng(0.0, 0.0), cached: true)
        .then((loc) async {
      initialLocation.value = loc;
    });
  }

  void onTapSelectAddressButton({required PickResult result}) async {
    Get.back(closeOverlays: true, result: [
      {GetArgumentConstants.googleAddressPlace: result}
    ]);
  }
}
