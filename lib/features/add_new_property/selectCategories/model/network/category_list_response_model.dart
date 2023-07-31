class CategoryListResponseModel {
  CategoryListResponseModel({
      this.status, 
      this.success, 
      this.message, 
      this.data, 
      this.recordsTotal, 
      this.recordsFiltered,});

  CategoryListResponseModel.fromJson(dynamic json) {
    status = json['status'];
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(Data.fromJson(v));
      });
    }
    recordsTotal = json['recordsTotal'];
    recordsFiltered = json['recordsFiltered'];
  }
  int? status;
  bool? success;
  String? message;
  List<Data>? data;
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

class Data {
  Data({
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
      this.totalSubCategory,});

  Data.fromJson(dynamic json) {
    id = json['_id'];
    parentId = json['parent_id'];
    inspectorCategoryId = json['inspector_category_id'];
    name = json['name'];
    image = json['image'];
    isActive = json['is_active'];
    deletedAt = json['deleted_at'];
    v = json['__v'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    totalSubCategory = json['totalSubCategory'];
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