class StateResponseModel {
  StateResponseModel({
    this.status,
    this.success,
    this.data,
    this.message,
  });

  StateResponseModel.fromJson(dynamic json) {
    status = json['status'];
    success = json['success'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(StateResponseModelData.fromJson(v));
      });
    }
    message = json['message'];
  }
  int? status;
  bool? success;
  List<StateResponseModelData>? data;
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

class StateResponseModelData {
  StateResponseModelData({
    this.id,
    this.name,
    this.countryId,
    this.code,
    this.isActive,
    this.deletedAt,
    this.v,
    this.createdAt,
    this.updatedAt,
  });

  StateResponseModelData.fromJson(dynamic json) {
    id = json['_id'];
    name = json['name'];
    countryId = json['country_id'];
    code = json['code'];
    isActive = json['is_active'];
    deletedAt = json['deleted_at'];
    v = json['__v'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }
  String? id;
  String? name;
  String? countryId;
  String? code;
  bool? isActive;
  dynamic deletedAt;
  int? v;
  String? createdAt;
  String? updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['name'] = name;
    map['country_id'] = countryId;
    map['code'] = code;
    map['is_active'] = isActive;
    map['deleted_at'] = deletedAt;
    map['__v'] = v;
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    return map;
  }
}
