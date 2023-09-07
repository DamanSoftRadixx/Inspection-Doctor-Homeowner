import 'package:inspection_doctor_homeowner/core/extensions/string_extensions.dart';

class GetCountyResponseModel {
  GetCountyResponseModel({
    this.status,
    this.success,
    this.data,
    this.message,
  });

  GetCountyResponseModel.fromJson(dynamic json) {
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
    this.counties,
  });

  Data.fromJson(dynamic json) {
    if (json['counties'] != null) {
      counties = [];
      json['counties'].forEach((v) {
        counties?.add(Counties.fromJson(v));
      });
    }
  }
  List<Counties>? counties;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (counties != null) {
      map['counties'] = counties?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class Counties {
  Counties({
    this.id,
    this.name,
    this.stateId,
    this.isActive,
    this.deletedAt,
    this.v,
    this.createdAt,
    this.updatedAt,
  });

  Counties.fromJson(dynamic json) {
    id = json['_id'].toString().toStringConversion();
    name = json['name'].toString().toStringConversion();

    stateId = json['state_id'].toString().toStringConversion();
    isActive = json['is_active'];
    deletedAt = json['deleted_at'].toString().toStringConversion();
    v = json['__v'].toString().toIntConversion();
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
