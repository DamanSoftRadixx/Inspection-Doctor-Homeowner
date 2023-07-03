// To parse this JSON data, do
//
//     final countryListingResponse = countryListingResponseFromJson(jsonString);

import 'dart:convert';

import 'package:inspection_doctor_homeowner/core/extensions/string_extensions.dart';

CountryListingResponse countryListingResponseFromJson(String str) =>
    CountryListingResponse.fromJson(json.decode(str));

String countryListingResponseToJson(CountryListingResponse data) =>
    json.encode(data.toJson());

class CountryListingResponse {
  int? code;
  bool? status;
  List<Datum>? data;

  CountryListingResponse({
    this.code,
    this.status,
    this.data,
  });

  factory CountryListingResponse.fromJson(Map<String, dynamic> json) =>
      CountryListingResponse(
        code: json["code"].toString().toIntConversion(),
        status: json["status"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "status": status,
        "data": data != null
            ? List<dynamic>.from(data!.map((x) => x.toJson()))
            : [],
      };
}

class Datum {
  int? id;
  String? name;
  String? iso3;
  String? numericCode;
  String? phonecode;
  String? createdAt;
  String? updatedAt;

  Datum({
    this.id,
    this.name,
    this.iso3,
    this.numericCode,
    this.phonecode,
    this.createdAt,
    this.updatedAt,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"].toString().toIntConversion(),
        name: json["name"].toString().toStringConversion(),
        iso3: json["iso3"].toString().toStringConversion(),
        numericCode: json["numeric_code"].toString().toStringConversion(),
        phonecode: json["phonecode"].toString().toStringConversion(),
        createdAt:
            DateTime.parse(json["created_at"]).toString().toStringConversion(),
        updatedAt:
            DateTime.parse(json["updated_at"]).toString().toStringConversion(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "iso3": iso3,
        "numeric_code": numericCode,
        "phonecode": phonecode,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}
