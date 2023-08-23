import 'package:geocoding/geocoding.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:inspection_doctor_homeowner/core/common_functionality/location/place.dart';
import 'package:inspection_doctor_homeowner/core/network_utility/app_end_points.dart';

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

Future<FFPlace> displayPrediction(String placeId) async {
  // get detail (lat/lng)
  GoogleMapsPlaces places = GoogleMapsPlaces(
    apiKey: EndPoints.mapKey,
    apiHeaders: await const GoogleApiHeaders().getHeaders(),
  );
  final PlacesDetailsResponse detail =
      await places.getDetailsByPlaceId(placeId);
  final Geometry geometry = detail.result.geometry!;

  return getAddressFromLatLng(geometry);
}

Future<FFPlace> getAddressFromLatLng(Geometry geometry) async {
  List<Placemark> newPlace = await placemarkFromCoordinates(
      geometry.location.lat, geometry.location.lng);

  Placemark placeMark = newPlace[0];

  return FFPlace(
    latLng: LatLng(
      geometry.location.lat,
      geometry.location.lng,
    ),
    address1: placeMark.street ?? "",
    address2: placeMark.subAdministrativeArea ?? "",
    city: placeMark.locality ?? placeMark.subLocality ?? "",
    state: placeMark.administrativeArea ?? "",
    country: placeMark.country ?? "",
    zipCode: placeMark.postalCode ?? "",
  );
}
