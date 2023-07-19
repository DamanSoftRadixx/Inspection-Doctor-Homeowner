import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_google_places_hoc081098/flutter_google_places_hoc081098.dart';
import 'package:get/get.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:inspection_doctor_homeowner/core/network_utility/app_end_points.dart';

class ChooseMapController extends GetxController {
  RxBool isShowSearchLoader = false.obs;
  TextEditingController searchController = TextEditingController();
  var searchFocusNode = FocusNode().obs;
  GoogleMapController? googleMapController;
  //contrller for Google map
  RxList<Marker> markers = <Marker>[].obs; //markers for google map
  Rx<LatLng> changingLatLong = const LatLng(0.0, 0.0).obs;

  onSearch() {}

  Future<void> displayPrediction(
      Prediction? p, ScaffoldMessengerState messengerState) async {
    if (p == null) {
      return;
    }

    // get detail (lat/lng)
    final places = GoogleMapsPlaces(
      apiKey: EndPoints.mapKey,
      apiHeaders: await const GoogleApiHeaders().getHeaders(),
    );

    final detail = await places.getDetailsByPlaceId(p.placeId!);
    final geometry = detail.result.geometry!;
    final lat = geometry.location.lat;
    final lng = geometry.location.lng;

    changingLatLong.value = LatLng(lat, lng);

    log("displayPrediction ${changingLatLong.value}");

    var driverMarker = Marker(
      markerId: const MarkerId("driverLat"),
      position: (LatLng(lat, lng)),
      anchor: const Offset(0.5, 0.5),
      flat: true,
      draggable: false,
    );

    markers.add(driverMarker);
    markers.refresh();

    messengerState.showSnackBar(
      SnackBar(
        content: Text('${p.description} - $lat/$lng'),
      ),
    );
  }

  Future<void> handlePressButton() async {
    void onError(PlacesAutocompleteResponse response) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(
        SnackBar(
          content: Text(response.errorMessage ?? 'Unknown error'),
        ),
      );
    }

    // show input autocomplete with selected mode
    // then get the Prediction selected
    final p = await PlacesAutocomplete.show(
      context: Get.context!,
      apiKey: EndPoints.mapKey,
      onError: onError,
      mode: Mode.overlay,
      language: 'fr',
      components: [Component(Component.country, 'fr')],
      resultTextStyle: Theme.of(Get.context!).textTheme.titleMedium,
    );

    await displayPrediction(p, ScaffoldMessenger.of(Get.context!));
  }
}
