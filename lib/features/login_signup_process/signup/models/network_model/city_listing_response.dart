import 'dart:convert';

import 'package:inspection_doctor_homeowner/core/extensions/string_extensions.dart';


CityListingResponse cityListingResponseFromJson(String str) =>
    CityListingResponse.fromJson(json.decode(str));

String cityListingResponseToJson(CityListingResponse data) =>
    json.encode(data.toJson());

class CityListingResponse {
  int? code;
  bool? status;
  List<Datum>? data;

  CityListingResponse({
    this.code,
    this.status,
    this.data,
  });

  factory CityListingResponse.fromJson(Map<String, dynamic> json) =>
      CityListingResponse(
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
  int? stateId;
  String? stateCode;
  int? countryId;
  String? countryCode;
  String? createdAt;
  String? updatedAt;

  Datum({
    this.id,
    this.name,
    this.stateId,
    this.stateCode,
    this.countryId,
    this.countryCode,
    this.createdAt,
    this.updatedAt,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"].toString().toIntConversion(),
        name: json["name"].toString().toStringConversion(),
        stateId: json["state_id"].toString().toIntConversion(),
        stateCode: json["state_code"].toString().toStringConversion(),
        countryId: json["country_id"].toString().toIntConversion(),
        countryCode: json["country_code"].toString().toStringConversion(),
        createdAt:
            DateTime.parse(json["created_at"]).toString().toStringConversion(),
        updatedAt:
            DateTime.parse(json["updated_at"]).toString().toStringConversion(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "state_id": stateId,
        "state_code": stateCode,
        "country_id": countryId,
        "country_code": countryCode,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}
