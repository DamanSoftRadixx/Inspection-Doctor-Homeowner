// To parse this JSON data, do
//
//     final signupResponse = signupResponseFromJson(jsonString);

import 'dart:convert';

import 'package:inspection_doctor_homeowner/core/extensions/string_extensions.dart';

SignupResponse signupResponseFromJson(String str) =>
    SignupResponse.fromJson(json.decode(str));

String signupResponseToJson(SignupResponse data) => json.encode(data.toJson());

class SignupResponse {
  int? code;
  bool? status;
  String? message;
  String? token;
  Data? data;

  SignupResponse({
    this.code,
    this.status,
    this.message,
    this.token,
    this.data,
  });

  factory SignupResponse.fromJson(Map<String, dynamic> json) => SignupResponse(
        code: json["code"].toString().toIntConversion(),
        status: json["status"],
        message: json["message"].toString().toStringConversion(),
        token: json["token"].toString().toStringConversion(),
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "status": status,
        "message": message,
        "token": token,
        "data": data?.toJson(),
      };
}

class Data {
  int? id;
  String? name;
  String? email;
  String? gender;
  int? roleId;
  String? role;
  String? profileImage;
  String? country;
  String? state;
  String? city;
  String? emailToken;
  String? isVerified;

  Data({
    this.id,
    this.name,
    this.email,
    this.gender,
    this.roleId,
    this.role,
    this.profileImage,
    this.country,
    this.state,
    this.city,
    this.emailToken,
    this.isVerified,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"].toString().toIntConversion(),
        name: json["name"].toString().toStringConversion(),
        email: json["email"].toString().toStringConversion(),
        gender: json["gender"].toString().toStringConversion(),
        roleId: json["role_id"].toString().toIntConversion(),
        role: json["role"].toString().toStringConversion(),
        profileImage: json["profile_image"].toString().toStringConversion(),
        country: json["country"].toString().toStringConversion(),
        state: json["state"].toString().toStringConversion(),
        city: json["city"].toString().toStringConversion(),
        emailToken: json["email_token"].toString().toStringConversion(),
        isVerified: json["is_verified"].toString().toStringConversion(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "gender": gender,
        "role_id": roleId,
        "role": role,
        "profile_image": profileImage,
        "country": country,
        "state": state,
        "city": city,
        "email_token": emailToken,
        "is_verified": isVerified,
      };
}
