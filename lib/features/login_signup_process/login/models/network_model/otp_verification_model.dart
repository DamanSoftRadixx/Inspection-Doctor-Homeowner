import 'dart:convert';

import 'package:inspection_doctor_homeowner/core/extensions/string_extensions.dart';

OtpVerificationModel otpVerificationFromJson(String str) =>
    OtpVerificationModel.fromJson(json.decode(str));

String otpVerificationToJson(OtpVerificationModel data) =>
    json.encode(data.toJson());

class OtpVerificationModel {
  OtpVerificationModel({
    this.status,
    this.message,
    this.error,
    this.data,
  });

  OtpVerificationModel.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'].toString().toStringConversion();
    error = json['error'].toString().toStringConversion();
    data = json['data'].toString().toStringConversion();
  }
  bool? status;
  String? message;
  String? error;
  String? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['message'] = message;
    map['error'] = error;
    map['data'] = data;
    return map;
  }
}
