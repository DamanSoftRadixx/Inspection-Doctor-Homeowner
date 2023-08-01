import 'package:inspection_doctor_homeowner/core/extensions/string_extensions.dart';

class ScheduleInspectionListResponseModel {
  ScheduleInspectionListResponseModel({
    this.status,
    this.success,
    this.message,
    this.data,
    this.recordsTotal,
    this.recordsFiltered,
  });

  ScheduleInspectionListResponseModel.fromJson(dynamic json) {
    status = json['status'].toString().toIntConversion();
    success = json['success'];
    message = json['message'].toString().toStringConversion();
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(ScheduleInspectionListResponseDataModel.fromJson(v));
      });
    }
    recordsTotal = json['recordsTotal'].toString().toIntConversion();
    recordsFiltered = json['recordsFiltered'].toString().toIntConversion();
  }
  int? status;
  bool? success;
  String? message;
  List<ScheduleInspectionListResponseDataModel>? data;
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

class ScheduleInspectionListResponseDataModel {
  ScheduleInspectionListResponseDataModel({
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
    this.report,
    this.reportDescription,
    this.reportEmail,
    this.islatest,
    this.propertyInspectionParentId,
    this.latestUpdate,
    this.properties,
    this.architecturelDrawingUrl,
    this.category,
    this.subcategory,
  });

  ScheduleInspectionListResponseDataModel.fromJson(dynamic json) {
    id = json['_id'].toString().toStringConversion();
    date = json['date'].toString().toStringConversion();
    if (json['time'] != null) {
      time = [];
      json['time'].forEach((v) {
        time?.add(Time.fromJson(v));
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
    // if (json['accepted_inspection_time'] != null) {
    //   acceptedInspectionTime = [];
    //   json['accepted_inspection_time'].forEach((v) {
    //     acceptedInspectionTime?.add(Dynamic.fromJson(v));
    //   });
    // }
    report = json['report'].toString().toStringConversion();
    reportDescription =
        json['report_description'].toString().toStringConversion();
    // if (json['report_email'] != null) {
    //   reportEmail = [];
    //   json['report_email'].forEach((v) {
    //     reportEmail?.add(Dynamic.fromJson(v));
    //   });
    // }
    islatest = json['islatest'];
    propertyInspectionParentId =
        json['property_inspection_parent_id'].toString().toStringConversion();
    latestUpdate = json['latest_update'];
    properties = json['properties'] != null
        ? Properties.fromJson(json['properties'])
        : null;
    architecturelDrawingUrl = json['architecturel_drawing_url'] != null
        ? ArchitecturelDrawingUrl.fromJson(json['architecturel_drawing_url'])
        : null;
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
  String? date;
  List<Time>? time;
  String? description;
  String? firstName;
  String? lastName;
  String? email;
  String? phone;
  dynamic countryCode;
  String? inspectionStatusId;
  dynamic acceptedInspectionDate;
  List<dynamic>? acceptedInspectionTime;
  dynamic report;
  dynamic reportDescription;
  List<dynamic>? reportEmail;
  int? islatest;
  dynamic propertyInspectionParentId;
  bool? latestUpdate;
  Properties? properties;
  ArchitecturelDrawingUrl? architecturelDrawingUrl;
  Category? category;
  List<Subcategory>? subcategory;

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
    map['report'] = report;
    map['report_description'] = reportDescription;
    if (reportEmail != null) {
      map['report_email'] = reportEmail?.map((v) => v.toJson()).toList();
    }
    map['islatest'] = islatest;
    map['property_inspection_parent_id'] = propertyInspectionParentId;
    map['latest_update'] = latestUpdate;
    if (properties != null) {
      map['properties'] = properties?.toJson();
    }
    if (architecturelDrawingUrl != null) {
      map['architecturel_drawing_url'] = architecturelDrawingUrl?.toJson();
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

class ArchitecturelDrawingUrl {
  ArchitecturelDrawingUrl({
    this.url,
  });

  ArchitecturelDrawingUrl.fromJson(dynamic json) {
    url = json['url'];
  }
  String? url;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['url'] = url;
    return map;
  }
}

class Properties {
  Properties({
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
    this.latestUpdate,
  });

  Properties.fromJson(dynamic json) {
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
    latestUpdate = json['latest_update'];
  }
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
  bool? latestUpdate;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['assigned_user_id'] = assignedUserId.toString().toStringConversion();
    map['created_by_id'] = createdById.toString().toStringConversion();
    map['property_name'] = propertyName.toString().toStringConversion();
    map['street'] = street.toString().toStringConversion();
    map['state'] = state.toString().toStringConversion();
    map['city'] = city.toString().toStringConversion();
    map['zip_code'] = zipCode.toString().toStringConversion();
    map['lot_number'] = lotNumber.toString().toStringConversion();
    map['block_number'] = blockNumber.toString().toStringConversion();
    map['permit_number'] = permitNumber.toString().toStringConversion();
    map['county_id'] = countyId.toString().toStringConversion();
    map['latest_update'] = latestUpdate.toString().toStringConversion();
    return map;
  }
}

class Time {
  Time({
    this.starttime,
    this.endtime,
  });

  Time.fromJson(dynamic json) {
    starttime = json['starttime'];
    endtime = json['endtime'];
  }
  String? starttime;
  String? endtime;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['starttime'] = starttime.toString().toStringConversion();
    map['endtime'] = endtime.toString().toStringConversion();
    return map;
  }
}
