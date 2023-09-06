import 'package:inspection_doctor_homeowner/core/extensions/string_extensions.dart';

class NotificationResponseModel {
  NotificationResponseModel({
    this.status,
    this.success,
    this.message,
    this.data,
    this.recordsTotal,
    this.recordsFiltered,
  });

  NotificationResponseModel.fromJson(dynamic json) {
    status = json['status'].toString().toIntConversion();
    success = json['success'];
    message = json['message'].toString().toStringConversion();
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(NotificationResponseModelData.fromJson(v));
      });
    }
    recordsTotal = json['recordsTotal'].toString().toIntConversion();
    recordsFiltered = json['recordsFiltered'].toString().toIntConversion();
  }
  int? status;
  bool? success;
  String? message;
  List<NotificationResponseModelData>? data;
  int? recordsTotal;
  int? recordsFiltered;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['success'] = success;
    map['message'] = message;
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    map['recordsTotal'] = recordsTotal;
    map['recordsFiltered'] = recordsFiltered;
    return map;
  }
}

class NotificationResponseModelData {
  NotificationResponseModelData({
    this.id,
    this.userId,
    this.notificationType,
    this.notificationTypeId,
    this.inspectionId,
    this.title,
    this.message,
    this.readStatus,
    this.deletedAt,
    this.v,
    this.createdAt,
    this.updatedAt,
  });

  NotificationResponseModelData.fromJson(dynamic json) {
    id = json['_id'].toString().toStringConversion();
    userId = json['user_id'].toString().toStringConversion();
    notificationType =
        json['notification_type'].toString().toStringConversion();
    notificationTypeId =
        json['notification_type_id'].toString().toStringConversion();
    inspectionId = json['inspection_id'].toString().toStringConversion();
    title = json['title'].toString().toStringConversion();
    message = json['message'].toString().toStringConversion();
    readStatus = json['read_status'].toString().toIntConversion();
    deletedAt = json['deleted_at'];
    v = json['__v'].toString().toIntConversion();
    createdAt = json['createdAt'].toString().toStringConversion();
    updatedAt = json['updatedAt'].toString().toStringConversion();
  }
  String? id;
  String? userId;
  String? notificationType;
  String? notificationTypeId;
  String? inspectionId;
  String? title;
  String? message;
  int? readStatus;
  dynamic deletedAt;
  int? v;
  String? createdAt;
  String? updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['user_id'] = userId;
    map['notification_type'] = notificationType;
    map['notification_type_id'] = notificationTypeId;
    map['inspection_id'] = inspectionId;
    map['title'] = title;
    map['message'] = message;
    map['read_status'] = readStatus;
    map['deleted_at'] = deletedAt;
    map['__v'] = v;
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    return map;
  }
}
