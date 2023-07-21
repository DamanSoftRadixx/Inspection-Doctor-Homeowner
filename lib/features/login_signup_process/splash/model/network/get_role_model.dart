import 'dart:convert';

import 'package:inspection_doctor_homeowner/core/extensions/string_extensions.dart';

GetRolesResponse getRolesResponseFromJson(String str) =>
    GetRolesResponse.fromJson(json.decode(str));

String getRolesResponseToJson(GetRolesResponse data) =>
    json.encode(data.toJson());

class GetRolesResponse {
  int? status;
  bool? success;
  GetRolesResponseData? data;
  String? message;

  GetRolesResponse({
    this.status,
    this.success,
    this.data,
    this.message,
  });

  factory GetRolesResponse.fromJson(Map<String, dynamic> json) =>
      GetRolesResponse(
        status: json["status"].toString().toIntConversion
          (),
        success: json["success"],
        data: json["data"] == null
            ? null
            : GetRolesResponseData.fromJson(json["data"]),
        message: json["message"].toString().toStringConversion(),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "success": success,
        "data": data?.toJson(),
        "message": message,
      };
}

class GetRolesResponseData {
  List<Role>? roles;

  GetRolesResponseData({
    this.roles,
  });

  factory GetRolesResponseData.fromJson(Map<String, dynamic> json) =>
      GetRolesResponseData(
        roles: json["roles"] == null
            ? []
            : List<Role>.from(json["roles"]!.map((x) => Role.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "roles": roles == null
            ? []
            : List<dynamic>.from(roles!.map((x) => x.toJson())),
      };
}

class Role {
  String? id;
  String? name;

  Role({
    this.id,
    this.name,
  });

  factory Role.fromJson(Map<String, dynamic> json) => Role(
        id: json["_id"].toString().toStringConversion(),
        name: json["name"].toString().toStringConversion(),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
      };
}
