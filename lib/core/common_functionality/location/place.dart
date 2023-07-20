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
