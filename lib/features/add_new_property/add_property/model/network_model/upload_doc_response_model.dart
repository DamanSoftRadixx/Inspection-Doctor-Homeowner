class UploadDocResponseModel {
  UploadDocResponseModel({
      this.status, 
      this.success, 
      this.data, 
      this.message,});

  UploadDocResponseModel.fromJson(dynamic json) {
    status = json['status'];
    success = json['success'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(Data.fromJson(v));
      });
    }
    message = json['message'];
  }
  int? status;
  bool? success;
  List<Data>? data;
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

class Data {
  Data({
      this.url, 
      this.key, 
      this.deletedAt, 
      this.id, 
      this.createdAt, 
      this.updatedAt, 
      this.v,});

  Data.fromJson(dynamic json) {
    url = json['url'];
    key = json['key'];
    deletedAt = json['deleted_at'];
    id = json['_id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
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