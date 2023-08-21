class Model {
  Model({
      this.status, 
      this.success, 
      this.message, 
      this.data, 
      this.recordsTotal, 
      this.recordsFiltered,});

  Model.fromJson(dynamic json) {
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
      this.latitude, 
      this.longitude, 
      this.addressLine1, 
      this.addressLine2, 
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
      this.v,});

  Data.fromJson(dynamic json) {
    id = json['_id'];
    assignedUserId = json['assigned_user_id'];
    createdById = json['created_by_id'];
    propertyName = json['property_name'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    addressLine1 = json['address_line_1'];
    addressLine2 = json['address_line_2'];
    state = json['state'] != null ? State.fromJson(json['state']) : null;
    city = json['city'];
    zipCode = json['zip_code'];
    lotNumber = json['lot_number'];
    blockNumber = json['block_number'];
    permitNumber = json['permit_number'];
    countyId = json['county_id'] != null ? CountyId.fromJson(json['county_id']) : null;
    architecturelDrawing = json['architecturel_drawing'] != null ? ArchitecturelDrawing.fromJson(json['architecturel_drawing']) : null;
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
  String? latitude;
  String? longitude;
  String? addressLine1;
  String? addressLine2;
  State? state;
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
    map['address_line_1'] = addressLine1;
    map['address_line_2'] = addressLine2;
    if (state != null) {
      map['state'] = state?.toJson();
    }
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
      this.url,});

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
      this.name,});

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

class State {
  State({
      this.id, 
      this.name,});

  State.fromJson(dynamic json) {
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