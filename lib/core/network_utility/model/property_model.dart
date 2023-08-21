class Properties {
  String? propertyName;
  String? addressLine1;
  String? addressLine2;
  String? state;
  String? city;
  String? zipCode;
  String? lotNumber;
  String? blockNumber;
  String? permitNumber;

  Properties({
    this.propertyName,
    this.addressLine1,
    this.addressLine2,
    this.state,
    this.city,
    this.zipCode,
    this.lotNumber,
    this.blockNumber,
    this.permitNumber,
  });

  factory Properties.fromJson(Map<String, dynamic> json) => Properties(
        propertyName: json["property_name"],
        addressLine1: json["address_line_1"],
        addressLine2: json["address_line_2"],
        state: json["state"],
        city: json["city"],
        zipCode: json["zip_code"],
        lotNumber: json["lot_number"],
        blockNumber: json["block_number"],
        permitNumber: json["permit_number"],
      );

  Map<String, dynamic> toJson() => {
        "property_name": propertyName,
        "address_line_1": addressLine1,
        "address_line_2": addressLine2,
        "state": state,
        "city": city,
        "zip_code": zipCode,
        "lot_number": lotNumber,
        "block_number": blockNumber,
        "permit_number": permitNumber,
      };
}
