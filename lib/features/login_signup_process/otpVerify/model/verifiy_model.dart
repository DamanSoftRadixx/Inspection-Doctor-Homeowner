// To parse this JSON data, do
//
//     final otpVerifyResponse = otpVerifyResponseFromJson(jsonString);

import 'dart:convert';

OtpVerifyResponse otpVerifyResponseFromJson(String str) =>
    OtpVerifyResponse.fromJson(json.decode(str));

String otpVerifyResponseToJson(OtpVerifyResponse data) =>
    json.encode(data.toJson());

class OtpVerifyResponse {
  int? status;
  bool? success;
  OtpVerifyResponseData? data;
  String? message;

  OtpVerifyResponse({
    this.status,
    this.success,
    this.data,
    this.message,
  });

  factory OtpVerifyResponse.fromJson(Map<String, dynamic> json) =>
      OtpVerifyResponse(
        status: json["status"],
        success: json["success"],
        data: json["data"] == null
            ? null
            : OtpVerifyResponseData.fromJson(json["data"]),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "success": success,
        "data": data?.toJson(),
        "message": message,
      };
}

class OtpVerifyResponseData {
  OtpVerifyResponseData();

  factory OtpVerifyResponseData.fromJson(Map<String, dynamic> json) =>
      OtpVerifyResponseData();

  Map<String, dynamic> toJson() => {};
}
