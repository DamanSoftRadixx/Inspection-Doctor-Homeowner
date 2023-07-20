import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:inspection_doctor_homeowner/core/common_functionality/dismiss_keyboard.dart';
import 'package:inspection_doctor_homeowner/core/common_functionality/location/location.dart';
import 'package:inspection_doctor_homeowner/core/constants/app_strings.dart';
import 'package:inspection_doctor_homeowner/core/network_utility/app_end_points.dart';

class ChooseMapController extends GetxController {
  RxBool isShowSearchLoader = false.obs;
  TextEditingController searchController = TextEditingController();
  var searchFocusNode = FocusNode().obs;

  //contrller for Google map

  Rx<LatLng> googleMapsCenter = const LatLng(0, 0).obs;

  Rx<LatLng> changingLatLong =
      const LatLng(37.415768808487435, -122.08440050482749).obs;
  RxList<Prediction> predictionsList = <Prediction>[].obs;

  Rx<CameraPosition> initialPosition = const CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  ).obs;

  Completer<GoogleMapController> googleMapController =
      Completer<GoogleMapController>();

  Rx<Placemark> place = Placemark().obs;
  Rx<LatLng> initialLocation =
      const LatLng(37.415768808487435, -122.08440050482749).obs;

  late AnimationController animationController;
  @override
  void onInit() {
    getUserLocation();
    super.onInit();
  }

  Future<void> handlePressButton({required String value}) async {
    var result = await GoogleMapsPlaces(
      apiKey: EndPoints.mapKey,
      apiHeaders: await const GoogleApiHeaders().getHeaders(),
    ).autocomplete(value);

    if (value.isEmpty) {
      predictionsList.value = [];
      predictionsList.refresh();
    }
    {
      predictionsList.value = result.predictions;
      predictionsList.refresh();
    }
  }

  Future<void> displayPrediction(Prediction? p) async {
    if (p == null) {
      return;
    }

    // get detail (lat/lng)
    GoogleMapsPlaces places = GoogleMapsPlaces(
      apiKey: EndPoints.mapKey,
      apiHeaders: await const GoogleApiHeaders().getHeaders(),
    );
    final PlacesDetailsResponse detail =
        await places.getDetailsByPlaceId(p.placeId!);
    final Geometry geometry = detail.result.geometry!;
    getAddressFromLatLng(geometry);
  }

  Future<void> getAddressFromLatLng(Geometry geometry) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(
        geometry.location.lat, geometry.location.lng);

    changingLatLong.value =
        LatLng(geometry.location.lat, geometry.location.lng);

    place.value = placemarks[0];

    dismissKeyboard();

    setCameraPosition(
        target: LatLng(geometry.location.lat, geometry.location.lng),
        googleMapController: googleMapController);
  }

  getUserLocation() async {
    await getCurrentUserLocation(
            defaultLocation: const LatLng(0.0, 0.0), cached: true)
        .then((loc) async {
      initialPosition.value = setCameraPosition(
          target: loc, googleMapController: googleMapController);

      googleMapsCenter.value = loc;

      List<Placemark> placemarks =
          await placemarkFromCoordinates(loc.latitude, loc.longitude);

      place.value = placemarks[0];
    });
  }

  void onTapSelectAddressButton() async {
    List<Placemark> placemarks = await placemarkFromCoordinates(
        googleMapsCenter.value.latitude, googleMapsCenter.value.longitude);
    Placemark placeData = placemarks[0];
    Get.back(closeOverlays: true, result: [
      {GetArgumentConstants.googleAddressPlace: placeData}
    ]);
  }
}
