import 'dart:convert';

import 'package:inspection_doctor_homeowner/core/extensions/string_extensions.dart';

GetLangaugeResponseModel getLangaugeResponseModelFromJson(String str) =>
    GetLangaugeResponseModel.fromJson(json.decode(str));

String getLangaugeResponseModelToJson(GetLangaugeResponseModel data) =>
    json.encode(data.toJson());

class GetLangaugeResponseModel {
  int? status;
  bool? success;
  GetLanguageResponseData? data;
  String? message;

  GetLangaugeResponseModel({
    this.status,
    this.success,
    this.data,
    this.message,
  });

  factory GetLangaugeResponseModel.fromJson(Map<String, dynamic> json) =>
      GetLangaugeResponseModel(
        status: json["status"].toString().toIntConversion(),
        success: json["success"],
        data: json["data"] == null
            ? null
            : GetLanguageResponseData.fromJson(json["data"]),
        message: json["message"].toString().toStringConversion(),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "success": success,
        "data": data?.toJson(),
        "message": message,
      };
}

class GetLanguageResponseData {
  List<Language>? languages;

  GetLanguageResponseData({
    this.languages,
  });

  factory GetLanguageResponseData.fromJson(Map<String, dynamic> json) =>
      GetLanguageResponseData(
        languages: json["languages"] == null
            ? []
            : List<Language>.from(
                json["languages"]!.map((x) => Language.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "languages": languages == null
            ? []
            : List<dynamic>.from(languages!.map((x) => x.toJson())),
      };
}

class Language {
  String? id;
  String? name;
  bool? isActive;
  String? deletedAt;
  int? v;
  String? createdAt;
  String? updatedAt;

  Language({
    this.id,
    this.name,
    this.isActive,
    this.deletedAt,
    this.v,
    this.createdAt,
    this.updatedAt,
  });

  factory Language.fromJson(Map<String, dynamic> json) => Language(
        id: json["_id"].toString().toStringConversion(),
        name: json["name"].toString().toStringConversion(),
        isActive: json["is_active"],
        deletedAt: json["deleted_at"].toString().toStringConversion(),
        v: json["__v"].toString().toIntConversion(),
        createdAt: json["createdAt"].toString().toStringConversion(),
        updatedAt: json["updatedAt"].toString().toStringConversion(),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "is_active": isActive,
        "deleted_at": deletedAt,
        "__v": v,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
      };
}
