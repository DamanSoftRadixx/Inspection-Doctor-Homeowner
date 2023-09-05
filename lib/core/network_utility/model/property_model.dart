class Properties {
  Properties({
    this.id,
    this.propertyName,
    this.latitude,
    this.longitude,
    this.isAddressAssigned,
    this.addressLine1,
    this.addressLine2,
    this.city,
    this.zipCode,
    this.lotNumber,
    this.blockNumber,
    this.plotNumber,
    this.countyId,
    this.latestUpdate,
  });

  Properties.fromJson(dynamic json) {
    id = json['_id'];
    propertyName = json['property_name'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    isAddressAssigned = json['is_address_assigned'];
    addressLine1 = json['address_line_1'];
    addressLine2 = json['address_line_2'];
    city = json['city'];
    zipCode = json['zip_code'];
    lotNumber = json['lot_number'];
    blockNumber = json['block_number'];
    plotNumber = json['plot_number'];
    countyId = json['county_id'];
    latestUpdate = json['latest_update'];
  }
  String? id;
  String? propertyName;
  String? latitude;
  String? longitude;
  bool? isAddressAssigned;
  String? addressLine1;
  String? addressLine2;
  String? city;
  String? zipCode;
  String? lotNumber;
  String? blockNumber;
  String? plotNumber;
  String? countyId;
  bool? latestUpdate;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['property_name'] = propertyName;
    map['latitude'] = latitude;
    map['longitude'] = longitude;
    map['is_address_assigned'] = isAddressAssigned;
    map['address_line_1'] = addressLine1;
    map['address_line_2'] = addressLine2;
    map['city'] = city;
    map['zip_code'] = zipCode;
    map['lot_number'] = lotNumber;
    map['block_number'] = blockNumber;
    map['plot_number'] = plotNumber;
    map['county_id'] = countyId;
    map['latest_update'] = latestUpdate;
    return map;
  }
}
