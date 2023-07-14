class PropertyListResponseModel {
  PropertyListResponseModel({
      this.status, 
      this.success, 
      this.message, 
      this.data, 
      this.recordsTotal, 
      this.recordsFiltered,});

  PropertyListResponseModel.fromJson(dynamic json) {
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
      this.assignedUserId, 
      this.createdById, 
      this.propertyName, 
      this.street, 
      this.state, 
      this.city, 
      this.zipCode, 
      this.lotNumber, 
      this.blockNumber, 
      this.permitNumber, 
      this.countyId, 
      this.acrhitecturelDrawing, 
      this.latestUpdate, 
      this.deletedAt, 
      this.createdAt, 
      this.updatedAt, 
      this.v,});

  Data.fromJson(dynamic json) {
    id = json['_id'];
    assignedUserId = json['assigned_user_id'];
    createdById = json['created_by_id'];
    propertyName = json['property_name'];
    street = json['street'];
    state = json['state'];
    city = json['city'];
    zipCode = json['zip_code'];
    lotNumber = json['lot_number'];
    blockNumber = json['block_number'];
    permitNumber = json['permit_number'];
    countyId = json['county_id'];
    acrhitecturelDrawing = json['acrhitecturel_drawing'];
    latestUpdate = json['latest_update'];
    deletedAt = json['deleted_at'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    v = json['__v'];
  }
  String? id;
  String? assignedUserId;
  String? createdById;
  String? propertyName;
  String? street;
  String? state;
  String? city;
  String? zipCode;
  String? lotNumber;
  String? blockNumber;
  String? permitNumber;
  String? countyId;
  dynamic acrhitecturelDrawing;
  bool? latestUpdate;
  dynamic deletedAt;
  String? createdAt;
  String? updatedAt;
  int? v;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['assigned_user_id'] = assignedUserId;
    map['created_by_id'] = createdById;
    map['property_name'] = propertyName;
    map['street'] = street;
    map['state'] = state;
    map['city'] = city;
    map['zip_code'] = zipCode;
    map['lot_number'] = lotNumber;
    map['block_number'] = blockNumber;
    map['permit_number'] = permitNumber;
    map['county_id'] = countyId;
    map['acrhitecturel_drawing'] = acrhitecturelDrawing;
    map['latest_update'] = latestUpdate;
    map['deleted_at'] = deletedAt;
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    map['__v'] = v;
    return map;
  }

}