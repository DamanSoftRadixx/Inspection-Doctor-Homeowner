// To parse this JSON data, do
//
//     final notificationEditModel = notificationEditModelFromJson(jsonString);

import 'dart:convert';

import 'package:inspection_doctor_homeowner/core/extensions/string_extensions.dart';

NotificationEditModel notificationEditModelFromJson(String str) =>
    NotificationEditModel.fromJson(json.decode(str));

String notificationEditModelToJson(NotificationEditModel data) =>
    json.encode(data.toJson());

class NotificationEditModel {
  int? status;
  bool? success;
  NotificationEditModelData? data;
  String? message;

  NotificationEditModel({
    this.status,
    this.success,
    this.data,
    this.message,
  });

  factory NotificationEditModel.fromJson(Map<String, dynamic> json) =>
      NotificationEditModel(
        status: json["status"].toString().toIntConversion(),
        success: json["success"],
        data: json["data"] == null
            ? null
            : NotificationEditModelData.fromJson(json["data"]),
        message: json["message"].toString().toStringConversion(),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "success": success,
        "data": data?.toJson(),
        "message": message,
      };
}

class NotificationEditModelData {
  NotificationEditModelData();

  factory NotificationEditModelData.fromJson(Map<String, dynamic> json) =>
      NotificationEditModelData();

  Map<String, dynamic> toJson() => {};
}
