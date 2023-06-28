// To parse this JSON data, do
//
//     final stateListingResponse = stateListingResponseFromJson(jsonString);

import 'dart:convert';

import 'package:inspection_doctor_homeowner/core/common_ui/string_extensions.dart';

StateListingResponse stateListingResponseFromJson(String str) =>
    StateListingResponse.fromJson(json.decode(str));

String stateListingResponseToJson(StateListingResponse data) =>
    json.encode(data.toJson());

class StateListingResponse {
  int? code;
  bool? status;
  List<Datum>? data;

  StateListingResponse({
    this.code,
    this.status,
    this.data,
  });

  factory StateListingResponse.fromJson(Map<String, dynamic> json) =>
      StateListingResponse(
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
  int? countryId;
  String? countryCode;
  String? createdAt;
  String? updatedAt;

  Datum({
    this.id,
    this.name,
    this.countryId,
    this.countryCode,
    this.createdAt,
    this.updatedAt,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"].toString().toIntConversion(),
        name: json["name"].toString().toStringConversion(),
        countryId: json["country_id "].toString().toIntConversion(),
        countryCode: json["country_code"].toString().toStringConversion(),
        createdAt:
            DateTime.parse(json["created_at"]).toString().toStringConversion(),
        updatedAt:
            DateTime.parse(json["updated_at"]).toString().toStringConversion(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "country_id ": countryId,
        "country_code": countryCode,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}
