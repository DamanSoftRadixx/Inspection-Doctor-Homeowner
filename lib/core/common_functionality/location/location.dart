import 'dart:async';

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:inspection_doctor_homeowner/core/common_functionality/location/place.dart';

LatLng? cachedUserLocation;

Future<LatLng> getCurrentUserLocation(
    {required LatLng defaultLocation, bool cached = false}) async {
  if (cached && cachedUserLocation != null) {
    return cachedUserLocation!;
  }
  return queryCurrentUserLocation().then((loc) {
    if (loc != null) {
      cachedUserLocation = loc;
    }
    return loc ?? defaultLocation;
  }).onError((error, _) {
    print("Error querying user location: $error");
    return defaultLocation;
  });
}

Future<LatLng?> queryCurrentUserLocation() async {
  final serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    return Future.error('Location services are disabled.');
  }

  var permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return Future.error('Location permissions are denied');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.');
  }

  final position = await Geolocator.getCurrentPosition();
  return position.latitude != 0 && position.longitude != 0
      ? LatLng(position.latitude, position.longitude)
      : null;
}

setCameraPosition(
    {required LatLng target,
    required Completer<GoogleMapController> googleMapController}) async {
  CameraPosition cameraPosition = CameraPosition(
      bearing: 192.8334901395799,
      target: target,
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);
  final GoogleMapController controller = await googleMapController.future;
  await controller
      .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
}

placeFromString(Placemark place) {
  return PlaceData(
    street: place.street as String,
    city: place.locality as String,
    state: place.administrativeArea as String,
    country: place.administrativeArea as String,
    zipCode: place.postalCode as String,
  );
}
