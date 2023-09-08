import 'package:inspection_doctor_homeowner/core/extensions/string_extensions.dart';

class CountyResponseModel {
  CountyResponseModel({
    this.status,
    this.success,
    this.data,
    this.message,
  });

  CountyResponseModel.fromJson(dynamic json) {
    status = json['status'].toString().toIntConversion();
    success = json['success'];
    if (json['data'] != null && json['data'] is List) {
      data = [];
      json['data'].forEach((v) {
        data?.add(CountyResponseModelData.fromJson(v));
      });
    }
    message = json['message'].toString().toStringConversion();
  }
  int? status;
  bool? success;
  List<CountyResponseModelData>? data;
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

class CountyResponseModelData {
  CountyResponseModelData({
    this.id,
    this.name,
    this.stateId,
    this.isActive,
    this.deletedAt,
    this.v,
    this.createdAt,
    this.updatedAt,
  });

  CountyResponseModelData.fromJson(dynamic json) {
    id = json['_id'].toString().toStringConversion();
    name = json['name'].toString().toStringConversion();
    stateId = json['state_id'].toString().toStringConversion();
    isActive = json['is_active'];
    deletedAt = json['deleted_at'];
    v = json['__v'];
    createdAt = json['createdAt'].toString().toStringConversion();
    updatedAt = json['updatedAt'].toString().toStringConversion();
  }
  String? id;
  String? name;
  String? stateId;
  bool? isActive;
  dynamic deletedAt;
  int? v;
  String? createdAt;
  String? updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['name'] = name;
    map['state_id'] = stateId;
    map['is_active'] = isActive;
    map['deleted_at'] = deletedAt;
    map['__v'] = v;
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    return map;
  }
}
