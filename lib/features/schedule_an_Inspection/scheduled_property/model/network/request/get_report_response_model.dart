import 'package:inspection_doctor_homeowner/core/extensions/string_extensions.dart';

class GetReportResponseModel {
  GetReportResponseModel({
    this.status,
    this.success,
    this.data,
    this.message,
  });

  GetReportResponseModel.fromJson(dynamic json) {
    status = json['status'].toString().toIntConversion();
    success = json['success'];
    data = json['data'] != null
        ? GetReportResponseModelData.fromJson(json['data'])
        : null;
    message = json['message'].toString().toStringConversion();
  }
  int? status;
  bool? success;
  GetReportResponseModelData? data;
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

class GetReportResponseModelData {
  GetReportResponseModelData({
    this.reportUrl,
    this.reportImages,
    this.reportType,
    this.reportEmail,
    this.reportDescription,
  });

  GetReportResponseModelData.fromJson(dynamic json) {
    reportUrl = json['report_url'].toString().toStringConversion();
    reportImages =
        json['report_images'] != null && json['report_images'] is List
            ? json['report_images'].cast<String>()
            : [];
    reportType = json['report_type'].toString().toStringConversion();
    reportEmail = json['report_email'] != null && json['report_email'] is List
        ? json['report_email'].cast<String>()
        : [];
    reportDescription =
        json['report_description'].toString().toStringConversion();
  }
  String? reportUrl;
  List<String>? reportImages;
  String? reportType;
  List<String>? reportEmail;
  String? reportDescription;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['report_url'] = reportUrl;
    map['report_images'] = reportImages;
    map['report_type'] = reportType;
    map['report_email'] = reportEmail;
    map['report_description'] = reportDescription;
    return map;
  }
}
