import 'package:inspection_doctor_homeowner/features/schedule_an_Inspection/propertyDetail/model/network_model/Inspector_details.dart';
import 'package:inspection_doctor_homeowner/features/schedule_an_Inspection/propertyDetail/model/network_model/property_inspection_schedules_history_model.dart';

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
    status = json['status'];
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(ScheduleInspectionResponseData.fromJson(v));
      });
    }
    recordsTotal = json['recordsTotal'];
    recordsFiltered = json['recordsFiltered'];
  }
  int? status;
  bool? success;
  String? message;
  List<ScheduleInspectionResponseData>? data;
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

class ScheduleInspectionResponseData {
  ScheduleInspectionResponseData({
    this.id,
    this.homeownerId,
    this.inspectionStatusId,
    this.inspectorId,
    this.latestUpdate,
    this.propertyInspectionSchedulesHistory,
    this.inspectorDetails,
    this.inspectorImage,
    this.category,
    this.subcategory,
  });

  ScheduleInspectionResponseData.fromJson(dynamic json) {
    id = json['_id'];
    homeownerId = json['homeowner_id'];
    inspectionStatusId = json['inspection_status_id'];
    inspectorId = json['inspector_id'];
    latestUpdate = json['latest_update'];
    if (json['property_inspection_schedules_history'] != null) {
      propertyInspectionSchedulesHistory = [];
      json['property_inspection_schedules_history'].forEach((v) {
        propertyInspectionSchedulesHistory
            ?.add(PropertyInspectionSchedulesHistory.fromJson(v));
      });
    }
    if (json['inspector_details'] != null) {
      inspectorDetails = [];
      json['inspector_details'].forEach((v) {
        inspectorDetails?.add(InspectorDetails.fromJson(v));
      });
    }
    if (json['inspector_image'] != null) {
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
  String? inspectionStatusId;
  String? inspectorId;
  bool? latestUpdate;
  List<PropertyInspectionSchedulesHistory>? propertyInspectionSchedulesHistory;
  List<InspectorDetails>? inspectorDetails;
  List<InspectorImage>? inspectorImage;
  Category? category;
  List<Subcategory>? subcategory;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['homeowner_id'] = homeownerId;
    map['inspection_status_id'] = inspectionStatusId;
    map['inspector_id'] = inspectorId;
    map['latest_update'] = latestUpdate;
    if (propertyInspectionSchedulesHistory != null) {
      map['property_inspection_schedules_history'] =
          propertyInspectionSchedulesHistory?.map((v) => v.toJson()).toList();
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
