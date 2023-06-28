// To parse this JSON data, do
//
//     final login = loginFromJson(jsonString);

import 'dart:convert';

import 'package:inspection_doctor_homeowner/core/common_ui/string_extensions.dart';

Login loginFromJson(String str) => Login.fromJson(json.decode(str));

String loginToJson(Login data) => json.encode(data.toJson());

class Login {
  Login({
    this.code,
    this.status,
    this.message,
    this.accessToken,
    this.data,
  });

  int? code;
  bool? status;
  String? message;
  String? accessToken;
  Data? data;

  factory Login.fromJson(Map<String, dynamic> json) => Login(
        code: json["code"].toString().toIntConversion(),
        status: json["status"],
        message: json["message"].toString().toStringConversion(),
        accessToken: json["access_token"].toString().toStringConversion(),
        data: json["data"] != null && json["data"].toString() != "[]"
            ? Data.fromJson(json["data"])
            : Data(),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "status": status,
        "message": message,
        "access_token": accessToken,
        "data": data?.toJson(),
      };
}

class Data {
  Data({
    this.id,
    this.name,
    this.email,
    this.language,
    this.totalPrompts,
    this.gender,
    this.roleId,
    this.role,
    this.profileImage,
    this.country,
    this.state,
    this.city,
    this.emailToken,
    this.isVerified,
    this.dontShow,
  });

  int? id;
  String? name;
  String? email;
  String? language;
  String? totalPrompts;
  String? gender;
  int? roleId;
  String? role;
  String? profileImage;
  String? country;
  String? state;
  String? city;
  String? emailToken;
  int? isVerified;
  String? dontShow;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"].toString().toIntConversion(),
        name: json["name"].toString().toStringConversion(),
        email: json["email"].toString().toStringConversion(),
        language: json["language"].toString().toStringConversion(),
        totalPrompts: json["total_prompts"].toString().toStringConversion(),
        gender: json["gender"].toString().toStringConversion(),
        roleId: json["role_id"].toString().toIntConversion(),
        role: json["role"].toString().toStringConversion(),
        profileImage: json["profile_image"].toString().toStringConversion(),
        country: json["country"].toString().toStringConversion(),
        state: json["state"].toString().toStringConversion(),
        city: json["city"].toString().toStringConversion(),
        emailToken: json["email_token"].toString().toStringConversion(),
        isVerified: json["is_verified"].toString().toIntConversion(),
        dontShow: json["dont_show"].toString().toStringConversion(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "language": language,
        "total_prompts": totalPrompts,
        "gender": gender,
        "role_id": roleId,
        "role": role,
        "profile_image": profileImage,
        "country": country,
        "state": state,
        "city": city,
        "email_token": emailToken,
        "is_verified": isVerified,
        "dont_show": dontShow,
      };
}
