import 'package:inspection_doctor_homeowner/core/extensions/string_extensions.dart';

class PropertyListResponseModel {
  PropertyListResponseModel({
    this.status,
    this.success,
    this.message,
    this.data,
    this.recordsTotal,
    this.recordsFiltered,
  });

  PropertyListResponseModel.fromJson(dynamic json) {
    status = json['status'].toString().toIntConversion();
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(PropertyListData.fromJson(v));
      });
    }
    recordsTotal = json['recordsTotal'].toString().toIntConversion();
    recordsFiltered = json['recordsFiltered'].toString().toIntConversion();
  }
  int? status;
  bool? success;
  String? message;
  List<PropertyListData>? data;
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

class PropertyListData {
  PropertyListData({
    this.id,
    this.assignedUserId,
    this.createdById,
    this.propertyName,
    this.latitude,
    this.longitude,
    this.street,
    this.state,
    this.city,
    this.zipCode,
    this.lotNumber,
    this.blockNumber,
    this.permitNumber,
    this.countyId,
    this.architecturelDrawing,
    this.latestUpdate,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  PropertyListData.fromJson(dynamic json) {
    id = json['_id'].toString().toStringConversion();
    assignedUserId = json['assigned_user_id'].toString().toStringConversion();
    createdById = json['created_by_id'].toString().toStringConversion();
    propertyName = json['property_name'].toString().toStringConversion();
    latitude = json['latitude'];
    longitude = json['longitude'];
    street = json['street'].toString().toStringConversion();
    state = json['state'].toString().toStringConversion();
    city = json['city'].toString().toStringConversion();
    zipCode = json['zip_code'].toString().toStringConversion();
    lotNumber = json['lot_number'].toString().toStringConversion();
    blockNumber = json['block_number'].toString().toStringConversion();
    permitNumber = json['permit_number'].toString().toStringConversion();
    countyId =
        json['county_id'] != null ? CountyId.fromJson(json['county_id']) : null;
    architecturelDrawing = json['architecturel_drawing'] != null
        ? ArchitecturelDrawing.fromJson(json['architecturel_drawing'])
        : null;
    latestUpdate = json['latest_update'];
    deletedAt = json['deleted_at'];
    createdAt = json['createdAt'].toString().toStringConversion();
    updatedAt = json['updatedAt'].toString().toStringConversion();
    v = json['__v'].toString().toIntConversion();
  }
  String? id;
  String? assignedUserId;
  String? createdById;
  String? propertyName;
  dynamic latitude;
  dynamic longitude;
  String? street;
  String? state;
  String? city;
  String? zipCode;
  String? lotNumber;
  String? blockNumber;
  String? permitNumber;
  CountyId? countyId;
  ArchitecturelDrawing? architecturelDrawing;
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
    map['latitude'] = latitude;
    map['longitude'] = longitude;
    map['street'] = street;
    map['state'] = state;
    map['city'] = city;
    map['zip_code'] = zipCode;
    map['lot_number'] = lotNumber;
    map['block_number'] = blockNumber;
    map['permit_number'] = permitNumber;
    if (countyId != null) {
      map['county_id'] = countyId?.toJson();
    }
    if (architecturelDrawing != null) {
      map['architecturel_drawing'] = architecturelDrawing?.toJson();
    }
    map['latest_update'] = latestUpdate;
    map['deleted_at'] = deletedAt;
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    map['__v'] = v;
    return map;
  }
}

class ArchitecturelDrawing {
  ArchitecturelDrawing({
    this.id,
    this.url,
  });

  ArchitecturelDrawing.fromJson(dynamic json) {
    id = json['_id'];
    url = json['url'];
  }
  String? id;
  String? url;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['url'] = url;
    return map;
  }
}

class CountyId {
  CountyId({
    this.id,
    this.name,
  });

  CountyId.fromJson(dynamic json) {
    id = json['_id'];
    name = json['name'];
  }
  String? id;
  String? name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['name'] = name;
    return map;
  }
}
