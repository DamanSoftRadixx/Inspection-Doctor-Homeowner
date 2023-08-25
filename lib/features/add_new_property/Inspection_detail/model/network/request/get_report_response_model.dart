class GetReportResponseModel {
  GetReportResponseModel({
    this.status,
    this.success,
    this.data,
    this.message,
  });

  GetReportResponseModel.fromJson(dynamic json) {
    status = json['status'];
    success = json['success'];
    data = json['data'] != null
        ? GetReportResponseModelData.fromJson(json['data'])
        : null;
    message = json['message'];
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
    this.reportType,
    this.reportEmail,
    this.reportDescription,
  });

  GetReportResponseModelData.fromJson(dynamic json) {
    reportUrl =
        json['report_url'] != null ? json['report_url'].cast<String>() : [];
    reportType = json['report_type'];
    reportEmail =
        json['report_email'] != null ? json['report_email'].cast<String>() : [];
    reportDescription = json['report_description'];
  }
  List<String>? reportUrl;
  String? reportType;
  List<String>? reportEmail;
  String? reportDescription;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['report_url'] = reportUrl;
    map['report_type'] = reportType;
    map['report_email'] = reportEmail;
    map['report_description'] = reportDescription;
    return map;
  }
}
