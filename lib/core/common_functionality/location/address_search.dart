import 'dart:developer';

import 'package:get/get.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:inspection_doctor_homeowner/core/common_functionality/location/place.dart';
import 'package:inspection_doctor_homeowner/core/constants/app_strings.dart';
import 'package:inspection_doctor_homeowner/core/network_utility/app_end_points.dart';
import 'package:inspection_doctor_homeowner/core/network_utility/dio_exceptions.dart';
import 'package:inspection_doctor_homeowner/core/network_utility/model/google_address_response_model.dart';
import 'package:inspection_doctor_homeowner/core/network_utility/provider/common_provider.dart';

Future<PlacesAutocompleteResponse> handlePressButton(
    {required String value}) async {
  PlacesAutocompleteResponse result = await GoogleMapsPlaces(
    apiKey: EndPoints.mapKey,
    apiHeaders: await const GoogleApiHeaders().getHeaders(),
  ).autocomplete(
    value,
    components: [Component(Component.country, "USA")],
    region: 'USA',
    language: "en",
  );

  return result;
}

Future<FFPlace> displayPrediction(
    {required String placeId, required String description}) async {
  FFPlace address = const FFPlace();

  try {
    GoogleAddressResponseModel response =
        await CommonProvider().getGoogleAddress(placeid: placeId) ??
            GoogleAddressResponseModel();

    if (response.status?.toUpperCase() == "OK") {
      List<AddressComponents> addressComponetsList =
          response.result?.addressComponents ?? [];

      log("placeId>>>>>$placeId");
      log("description>>>>>$description");
      log("formattedAddress>>>>>${response.result?.formattedAddress}");

      String address1 = "";
      String address2 = "";
      String city = "";
      String state = "";
      String country = "";
      String postalCode = "";

      for (var address in addressComponetsList) {
        List<String> typesList = address.types ?? [];
        if (typesList.contains("street_number")) {
          address1 = address.longName ?? "";
        }
        if (typesList.contains("route")) {
          if (address1 == "") {
            address1 += address.longName ?? "";
          } else {
            address1 += " ${address.longName}";
          }
        }
        if (typesList.contains("locality")) {
          city = address.longName ?? "";
        }

        if (typesList.contains("administrative_area_level_2")) {
          address2 = address.longName ?? "";
        }
        if (typesList.contains("administrative_area_level_1")) {
          state = address.longName ?? "";
        }
        if (typesList.contains("country")) {
          country = address.longName ?? "";
        }
        if (typesList.contains("postal_code")) {
          postalCode = address.longName ?? "";
        }
      }

      if (address1 == "") {
        address1 = address2;
        address2 = "";
      }

      address = FFPlace(
        latLng: LatLng(
          response.result?.geometry?.location?.lat ?? 0,
          response.result?.geometry?.location?.lng ?? 0,
        ),
        address1: address1,
        address2: address2,
        city: city,
        state: state,
        country: country,
        zipCode: postalCode,
      );

      log("addressssdadsd $address");
    } else {
      // setShowLoader(value: false);
      apiErrorDialog(
        message: AppStrings.somethingWentWrong.tr,
        okButtonPressed: () {
          Get.back();
        },
      );
    }
  } catch (e) {}

  return address;
}

// Future<FFPlace> getAddressFromLatLng(Geometry geometry) async {
//   List<Placemark> newPlace = await placemarkFromCoordinates(
//       geometry.location.lat, geometry.location.lng);

//   Placemark placeMark = newPlace[0];

//   return FFPlace(
//     latLng: LatLng(
//       geometry.location.lat,
//       geometry.location.lng,
//     ),
//     address1: placeMark.street ?? "",
//     address2: placeMark.subAdministrativeArea ?? "",
//     city: placeMark.locality ?? placeMark.subLocality ?? "",
//     state: placeMark.administrativeArea ?? "",
//     country: placeMark.country ?? "",
//     zipCode: placeMark.postalCode ?? "",
//   );
// }
