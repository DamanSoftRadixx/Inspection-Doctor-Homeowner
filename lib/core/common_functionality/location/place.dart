import 'package:google_maps_flutter/google_maps_flutter.dart';

class PlaceData {
  const PlaceData({
    this.street = '',
    this.city = '',
    this.state = '',
    this.country = '',
    this.zipCode = '',
  });

  final String street;
  final String city;
  final String state;
  final String country;
  final String zipCode;

  @override
  String toString() => '''FFPlace(

        street: $street,
        city: $city,
        state: $state,
        country: $country,
        zipCode: $zipCode,
      )''';

  @override
  bool operator ==(other) =>
      other is PlaceData &&
      street == other.street &&
      city == other.city &&
      state == other.state &&
      country == other.country &&
      zipCode == other.zipCode;
}

class FFPlace {
  const FFPlace({
    this.latLng = const LatLng(0.0, 0.0),
    this.address1 = '',
    this.address2 = '',
    this.city = '',
    this.state = '',
    this.country = '',
    this.zipCode = '',
  });

  final LatLng latLng;
  final String address1;
  final String address2;
  final String city;
  final String state;
  final String country;
  final String zipCode;

  @override
  String toString() => '''FFPlace(
        latLng: $latLng,
        name: $address1,
        address: $address2,
        city: $city,
        state: $state,
        country: $country,
        zipCode: $zipCode,
      )''';

  @override
  int get hashCode => latLng.hashCode;

  @override
  bool operator ==(other) =>
      other is FFPlace &&
      latLng == other.latLng &&
      address1 == other.address1 &&
      address2 == other.address2 &&
      city == other.city &&
      state == other.state &&
      country == other.country &&
      zipCode == other.zipCode;
}
