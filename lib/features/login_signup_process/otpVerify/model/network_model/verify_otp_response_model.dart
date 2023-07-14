
import 'package:inspection_doctor_homeowner/core/extensions/string_extensions.dart';

class VerifyOtpResponseModel {
  VerifyOtpResponseModel({
      this.status, 
      this.success, 
      this.data, 
      this.message,});

  VerifyOtpResponseModel.fromJson(dynamic json) {
    status = json['status'].toString().toIntConversion();
    success = json['success'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    message = json['message'].toString().toStringConversion();
  }
  int? status;
  bool? success;
  Data? data;
  String? message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['success'] = success;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    map['message'] = message;
    return map;
  }

}

class Data {
  Data({
      this.token,});

  Data.fromJson(dynamic json) {
    token = json['token'].toString().toStringConversion();
  }
  String? token;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['token'] = token;
    return map;
  }

}