import 'dart:convert';

import 'package:inspection_doctor_homeowner/core/extensions/string_extensions.dart';

SignUpResponseModel signUpResponseModelFromJson(String str) =>
    SignUpResponseModel.fromJson(json.decode(str));

String signUpResponseModelToJson(SignUpResponseModel data) =>
    json.encode(data.toJson());

class SignUpResponseModel {
  int? status;
  bool? success;
  SignUpResponseData? data;
  String? message;

  SignUpResponseModel({
    this.status,
    this.success,
    this.data,
    this.message,
  });

  factory SignUpResponseModel.fromJson(Map<String, dynamic> json) =>
      SignUpResponseModel(
        status: json["status"].toString().toIntConversion(),
        success: json["success"],
        data: json["data"] == null
            ? null
            : SignUpResponseData.fromJson(json["data"]),
        message: json["message"].toString().toStringConversion(),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "success": success,
        "data": data?.toJson(),
        "message": message,
      };
}

class SignUpResponseData {
  int? otp;
  String? token;

  SignUpResponseData({
    this.otp,
    this.token,
  });

  factory SignUpResponseData.fromJson(Map<String, dynamic> json) =>
      SignUpResponseData(
        otp: json["otp"].toString().toIntConversion(),
        token: json["token"].toString().toStringConversion(),
      );

  Map<String, dynamic> toJson() => {
        "otp": otp,
        "token": token,
      };
}
