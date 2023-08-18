// To parse this JSON data, do
//
//     final inspectionStatusModel = inspectionStatusModelFromJson(jsonString);

import 'dart:convert';

InspectionStatusModel inspectionStatusModelFromJson(String str) =>
    InspectionStatusModel.fromJson(json.decode(str));

String inspectionStatusModelToJson(InspectionStatusModel data) =>
    json.encode(data.toJson());

class InspectionStatusModel {
  List<InspectionDataStatusModel>? data;

  InspectionStatusModel({
    this.data,
  });

  factory InspectionStatusModel.fromJson(Map<String, dynamic> json) =>
      InspectionStatusModel(
        data: json["data"] == null
            ? []
            : List<InspectionDataStatusModel>.from(json["data"]!
                .map((x) => InspectionDataStatusModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class InspectionDataStatusModel {
  String? statusId;
  String? statusName;
  String? homeOwnerList;
  String? inspectorList;
  String? homeownerDetailHistoryscreen;
  String? inspectorDetailHistoryScreen;

  InspectionDataStatusModel({
    this.statusId,
    this.statusName,
    this.homeOwnerList,
    this.inspectorList,
    this.homeownerDetailHistoryscreen,
    this.inspectorDetailHistoryScreen,
  });

  factory InspectionDataStatusModel.fromJson(Map<String, dynamic> json) =>
      InspectionDataStatusModel(
        statusId: json["Status id"],
        statusName: json["Status name"],
        homeOwnerList: json["Home owner list"],
        inspectorList: json["Inspector list"],
        homeownerDetailHistoryscreen: json["Homeowner detail historyscreen"],
        inspectorDetailHistoryScreen: json["Inspector detail history screen"],
      );

  Map<String, dynamic> toJson() => {
        "Status id": statusId,
        "Status name": statusName,
        "Home owner list": homeOwnerList,
        "Inspector list": inspectorList,
        "Homeowner detail historyscreen": homeownerDetailHistoryscreen,
        "Inspector detail history screen": inspectorDetailHistoryScreen,
      };
}
