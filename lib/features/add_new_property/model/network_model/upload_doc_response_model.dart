import 'package:inspection_doctor_homeowner/core/extensions/string_extensions.dart';

class UploadDocResponseModel {
  UploadDocResponseModel({
    this.status,
    this.success,
    this.data,
    this.message,
  });

  UploadDocResponseModel.fromJson(dynamic json) {
    status = json['status'].toString().toIntConversion();
    success = json['success'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(UploadDocResponseData.fromJson(v));
      });
    }
    message = json['message'].toString().toStringConversion();
  }
  int? status;
  bool? success;
  List<UploadDocResponseData>? data;
  String? message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['success'] = success;
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    map['message'] = message;
    return map;
  }
}

class UploadDocResponseData {
  UploadDocResponseData({
    this.url,
    this.key,
    this.deletedAt,
    this.id,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  UploadDocResponseData.fromJson(dynamic json) {
    url = json['url'].toString().toStringConversion();
    key = json['key'].toString().toStringConversion();
    deletedAt = json['deleted_at'];
    id = json['_id'].toString().toStringConversion();
    createdAt = json['createdAt'].toString().toStringConversion();
    updatedAt = json['updatedAt'].toString().toStringConversion();
    v = json['__v'];
  }
  String? url;
  String? key;
  dynamic deletedAt;
  String? id;
  String? createdAt;
  String? updatedAt;
  int? v;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['url'] = url;
    map['key'] = key;
    map['deleted_at'] = deletedAt;
    map['_id'] = id;
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    map['__v'] = v;
    return map;
  }
}
