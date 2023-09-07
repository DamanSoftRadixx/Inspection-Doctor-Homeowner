import 'package:inspection_doctor_homeowner/core/extensions/string_extensions.dart';

class CategoryListResponseModel {
  CategoryListResponseModel({
    this.status,
    this.success,
    this.message,
    this.data,
    this.recordsTotal,
    this.recordsFiltered,
  });

  CategoryListResponseModel.fromJson(dynamic json) {
    status = json['status'].toString().toIntConversion();
    success = json['success'];
    message = json['message'].toString().toStringConversion();
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(CategoryListResponseDataModel.fromJson(v));
      });
    }
    recordsTotal = json['recordsTotal'].toString().toIntConversion();
    recordsFiltered = json['recordsFiltered'].toString().toIntConversion();
  }
  int? status;
  bool? success;
  String? message;
  List<CategoryListResponseDataModel>? data;
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

class CategoryListResponseDataModel {
  CategoryListResponseDataModel({
    this.id,
    this.parentId,
    this.inspectorCategoryId,
    this.name,
    this.image,
    this.isActive,
    this.deletedAt,
    this.v,
    this.createdAt,
    this.updatedAt,
    this.totalSubCategory,
  });

  CategoryListResponseDataModel.fromJson(dynamic json) {
    id = json['_id'].toString().toStringConversion();
    parentId = json['parent_id'];
    inspectorCategoryId = json['inspector_category_id'];
    name = json['name'].toString().toStringConversion();
    image = json['image'];
    isActive = json['is_active'];
    deletedAt = json['deleted_at'];
    v = json['__v'].toString().toIntConversion();
    createdAt = json['createdAt'].toString().toStringConversion();
    updatedAt = json['updatedAt'].toString().toStringConversion();
    totalSubCategory = json['totalSubCategory'].toString().toIntConversion();
  }
  String? id;
  dynamic parentId;
  dynamic inspectorCategoryId;
  String? name;
  dynamic image;
  bool? isActive;
  dynamic deletedAt;
  int? v;
  String? createdAt;
  String? updatedAt;
  int? totalSubCategory;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['parent_id'] = parentId;
    map['inspector_category_id'] = inspectorCategoryId;
    map['name'] = name;
    map['image'] = image;
    map['is_active'] = isActive;
    map['deleted_at'] = deletedAt;
    map['__v'] = v;
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    map['totalSubCategory'] = totalSubCategory;
    return map;
  }
}
