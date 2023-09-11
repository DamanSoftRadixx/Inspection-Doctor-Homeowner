import 'package:inspection_doctor_homeowner/core/extensions/string_extensions.dart';

class CategoriesResponseModel {
  CategoriesResponseModel({
    this.status,
    this.success,
    this.data,
    this.message,
  });

  CategoriesResponseModel.fromJson(dynamic json) {
    status = json['status'].toString().toIntConversion();
    success = json['success'];
    if (json['data'] != null && json['data'] is List) {
      data = [];
      json['data'].forEach((v) {
        data?.add(Category.fromJson(v));
      });
    }
    message = json['message'].toString().toStringConversion();
  }
  int? status;
  bool? success;
  List<Category>? data;
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

class Category {
  Category({
    this.id,
    this.name,
    this.deletedAt,
    this.v,
    this.createdAt,
    this.updatedAt,
    this.image,
    this.price,
  });

  Category.fromJson(dynamic json) {
    id = json['_id'].toString().toStringConversion();
    name = json['name'].toString().toStringConversion();
    deletedAt = json['deleted_at'];
    v = json['__v'];
    createdAt = json['createdAt'].toString().toStringConversion();
    updatedAt = json['updatedAt'].toString().toStringConversion();
    image = json['image'];
    price = json['price'].toString().toIntConversion();
  }
  String? id;
  String? name;
  dynamic deletedAt;
  int? v;
  String? createdAt;
  String? updatedAt;
  String? image;
  int? price;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['name'] = name;
    map['deleted_at'] = deletedAt;
    map['__v'] = v;
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    map['image'] = image;
    map['price'] = price;
    return map;
  }
}
