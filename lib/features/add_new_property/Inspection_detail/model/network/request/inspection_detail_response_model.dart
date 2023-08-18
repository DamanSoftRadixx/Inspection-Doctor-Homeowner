import 'package:inspection_doctor_homeowner/core/extensions/string_extensions.dart';
import 'package:inspection_doctor_homeowner/core/network_utility/model/time_model.dart';

class InspectionDetailResponseModel {
  InspectionDetailResponseModel({
    this.status,
    this.success,
    this.data,
    this.message,
  });

  InspectionDetailResponseModel.fromJson(dynamic json) {
    status = json['status'].toString().toIntConversion();
    success = json['success'];
    if (json['data'] != null && json['data'] is List) {
      data = [];
      json['data'].forEach((v) {
        data?.add(InspectionDetailData.fromJson(v));
      });
    }
    message = json['message'].toString().toStringConversion();
  }
  int? status;
  bool? success;
  List<InspectionDetailData>? data;
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

class InspectionDetailData {
  InspectionDetailData({
    this.id,
    this.homeownerId,
    this.report,
    this.reportDescription,
    this.reportEmail,
    this.latestUpdate,
    this.propertyInspectionSchedulesHistory,
    this.properties,
    this.inspectorDetails,
    this.inspectorImage,
    this.category,
    this.subcategory,
  });

  InspectionDetailData.fromJson(dynamic json) {
    id = json['_id'].toString().toStringConversion();
    homeownerId = json['homeowner_id'].toString().toStringConversion();
    report = json['report'].toString().toStringConversion();
    reportDescription =
        json['report_description'].toString().toStringConversion();
    reportEmail =
        json['report_email'] != null ? json['report_email'].cast<String>() : [];
    latestUpdate = json['latest_update'];
    if (json['property_inspection_schedules_history'] != null &&
        json['property_inspection_schedules_history'] is List) {
      propertyInspectionSchedulesHistory = [];
      json['property_inspection_schedules_history'].forEach((v) {
        propertyInspectionSchedulesHistory
            ?.add(PropertyInspectionSchedulesHistory.fromJson(v));
      });
    }
    properties = json['properties'] != null
        ? Properties.fromJson(json['properties'])
        : null;
    if (json['inspector_details'] != null &&
        json['inspector_details'] is List) {
      inspectorDetails = [];
      json['inspector_details'].forEach((v) {
        inspectorDetails?.add(InspectorDetails.fromJson(v));
      });
    }
    if (json['inspector_image'] != null && json['inspector_image'] is List) {
      inspectorImage = [];
      json['inspector_image'].forEach((v) {
        inspectorImage?.add(InspectorImage.fromJson(v));
      });
    }
    category =
        json['category'] != null ? Category.fromJson(json['category']) : null;
    if (json['subcategory'] != null) {
      subcategory = [];
      json['subcategory'].forEach((v) {
        subcategory?.add(Subcategory.fromJson(v));
      });
    }
  }
  String? id;
  String? homeownerId;
  String? report;
  String? reportDescription;
  List<String>? reportEmail;
  bool? latestUpdate;
  List<PropertyInspectionSchedulesHistory>? propertyInspectionSchedulesHistory;
  Properties? properties;
  List<InspectorDetails>? inspectorDetails;
  List<InspectorImage>? inspectorImage;
  Category? category;
  List<Subcategory>? subcategory;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['homeowner_id'] = homeownerId;
    map['report'] = report;
    map['report_description'] = reportDescription;
    map['report_email'] = reportEmail;
    map['latest_update'] = latestUpdate;
    if (propertyInspectionSchedulesHistory != null) {
      map['property_inspection_schedules_history'] =
          propertyInspectionSchedulesHistory?.map((v) => v.toJson()).toList();
    }
    if (properties != null) {
      map['properties'] = properties?.toJson();
    }
    if (inspectorDetails != null) {
      map['inspector_details'] =
          inspectorDetails?.map((v) => v.toJson()).toList();
    }
    if (inspectorImage != null) {
      map['inspector_image'] = inspectorImage?.map((v) => v.toJson()).toList();
    }
    if (category != null) {
      map['category'] = category?.toJson();
    }
    if (subcategory != null) {
      map['subcategory'] = subcategory?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class Subcategory {
  Subcategory({
    this.id,
    this.name,
  });

  Subcategory.fromJson(dynamic json) {
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

class Category {
  Category({
    this.id,
    this.name,
  });

  Category.fromJson(dynamic json) {
    id = json['_id'].toString().toStringConversion();
    name = json['name'].toString().toStringConversion();
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

class InspectorImage {
  InspectorImage({
    this.url,
  });

  InspectorImage.fromJson(dynamic json) {
    url = json['url'];
  }
  String? url;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['url'] = url;
    return map;
  }
}

class InspectorDetails {
  InspectorDetails({
    this.firstName,
    this.lastName,
    this.email,
  });

  InspectorDetails.fromJson(dynamic json) {
    firstName = json['first_name'].toString().toStringConversion();
    lastName = json['last_name'].toString().toStringConversion();
    email = json['email'].toString().toStringConversion();
  }
  String? firstName;
  String? lastName;
  String? email;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['first_name'] = firstName;
    map['last_name'] = lastName;
    map['email'] = email;
    return map;
  }
}

class Properties {
  Properties({
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
    this.latestUpdate,
  });

  Properties.fromJson(dynamic json) {
    propertyName = json['property_name'].toString().toStringConversion();
    latitude = json['latitude'].toString().toStringConversion();
    longitude = json['longitude'].toString().toStringConversion();
    street = json['street'].toString().toStringConversion();
    state = json['state'].toString().toStringConversion();
    city = json['city'].toString().toStringConversion();
    zipCode = json['zip_code'].toString().toStringConversion();
    lotNumber = json['lot_number'].toString().toStringConversion();
    blockNumber = json['block_number'].toString().toStringConversion();
    permitNumber = json['permit_number'].toString().toStringConversion();
    countyId = json['county_id'].toString().toStringConversion();
    latestUpdate = json['latest_update'];
  }
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
  String? countyId;
  bool? latestUpdate;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
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
    map['county_id'] = countyId;
    map['latest_update'] = latestUpdate;
    return map;
  }
}

class PropertyInspectionSchedulesHistory {
  PropertyInspectionSchedulesHistory({
    this.id,
    this.date,
    this.time,
    this.description,
    this.firstName,
    this.lastName,
    this.email,
    this.phone,
    this.countryCode,
    this.inspectionStatusId,
    this.acceptedInspectionDate,
    this.acceptedInspectionTime,
    this.createdAt,
    this.updatedAt,
  });

  PropertyInspectionSchedulesHistory.fromJson(dynamic json) {
    id = json['_id'].toString().toStringConversion();
    date = json['date'].toString().toStringConversion();
    if (json['time'] != null) {
      time = [];
      json['time'].forEach((v) {
        time?.add(TimeModel.fromJson(v));
      });
    }
    description = json['description'].toString().toStringConversion();
    firstName = json['first_name'].toString().toStringConversion();
    lastName = json['last_name'].toString().toStringConversion();
    email = json['email'].toString().toStringConversion();
    phone = json['phone'].toString().toStringConversion();
    countryCode = json['country_code'].toString().toStringConversion();
    inspectionStatusId =
        json['inspection_status_id'].toString().toStringConversion();
    acceptedInspectionDate =
        json['accepted_inspection_date'].toString().toStringConversion();
    if (json['accepted_inspection_time'] != null) {
      acceptedInspectionTime = [];
      json['accepted_inspection_time'].forEach((v) {
        acceptedInspectionTime?.add(TimeModel.fromJson(v));
      });
    }
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }
  String? id;
  String? date;
  List<TimeModel>? time;
  String? description;
  String? firstName;
  String? lastName;
  String? email;
  String? phone;
  String? countryCode;
  String? inspectionStatusId;
  String? acceptedInspectionDate;
  List<TimeModel>? acceptedInspectionTime;
  String? createdAt;
  String? updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['date'] = date;
    if (time != null) {
      map['time'] = time?.map((v) => v.toJson()).toList();
    }
    map['description'] = description;
    map['first_name'] = firstName;
    map['last_name'] = lastName;
    map['email'] = email;
    map['phone'] = phone;
    map['country_code'] = countryCode;
    map['inspection_status_id'] = inspectionStatusId;
    map['accepted_inspection_date'] = acceptedInspectionDate;
    if (acceptedInspectionTime != null) {
      map['accepted_inspection_time'] =
          acceptedInspectionTime?.map((v) => v.toJson()).toList();
    }
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    return map;
  }
}
