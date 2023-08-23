class Detail {
  Detail({
      this.status, 
      this.success, 
      this.message, 
      this.data, 
      this.recordsTotal, 
      this.recordsFiltered,});

  Detail.fromJson(dynamic json) {
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
      this.homeownerId, 
      this.inspectionStatusId, 
      this.inspectorId, 
      this.latestUpdate, 
      this.propertyInspectionSchedulesHistory, 
      this.inspectorDetails, 
      this.inspectorImage, 
      this.category, 
      this.subcategory,});

  Data.fromJson(dynamic json) {
    id = json['_id'];
    homeownerId = json['homeowner_id'];
    inspectionStatusId = json['inspection_status_id'];
    inspectorId = json['inspector_id'];
    latestUpdate = json['latest_update'];
    if (json['property_inspection_schedules_history'] != null) {
      propertyInspectionSchedulesHistory = [];
      json['property_inspection_schedules_history'].forEach((v) {
        propertyInspectionSchedulesHistory?.add(PropertyInspectionSchedulesHistory.fromJson(v));
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
    category = json['category'] != null ? Category.fromJson(json['category']) : null;
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
      map['property_inspection_schedules_history'] = propertyInspectionSchedulesHistory?.map((v) => v.toJson()).toList();
    }
    if (inspectorDetails != null) {
      map['inspector_details'] = inspectorDetails?.map((v) => v.toJson()).toList();
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
      this.name,});

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
      this.name,});

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
      this.url,});

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
      this.averageRating,});

  InspectorDetails.fromJson(dynamic json) {
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    averageRating = json['average_rating'];
  }
  String? firstName;
  String? lastName;
  String? email;
  dynamic averageRating;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['first_name'] = firstName;
    map['last_name'] = lastName;
    map['email'] = email;
    map['average_rating'] = averageRating;
    return map;
  }

}

class PropertyInspectionSchedulesHistory {
  PropertyInspectionSchedulesHistory({
      this.id, 
      this.date, 
      this.time, 
      this.inspectionStatusId, 
      this.acceptedInspectionDate, 
      this.acceptedInspectionTime,});

  PropertyInspectionSchedulesHistory.fromJson(dynamic json) {
    id = json['_id'];
    date = json['date'];
    if (json['time'] != null) {
      time = [];
      json['time'].forEach((v) {
        time?.add(Time.fromJson(v));
      });
    }
    inspectionStatusId = json['inspection_status_id'];
    acceptedInspectionDate = json['accepted_inspection_date'];
    if (json['accepted_inspection_time'] != null) {
      acceptedInspectionTime = [];
      json['accepted_inspection_time'].forEach((v) {
        acceptedInspectionTime?.add(AcceptedInspectionTime.fromJson(v));
      });
    }
  }
  String? id;
  String? date;
  List<Time>? time;
  String? inspectionStatusId;
  String? acceptedInspectionDate;
  List<AcceptedInspectionTime>? acceptedInspectionTime;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['date'] = date;
    if (time != null) {
      map['time'] = time?.map((v) => v.toJson()).toList();
    }
    map['inspection_status_id'] = inspectionStatusId;
    map['accepted_inspection_date'] = acceptedInspectionDate;
    if (acceptedInspectionTime != null) {
      map['accepted_inspection_time'] = acceptedInspectionTime?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class AcceptedInspectionTime {
  AcceptedInspectionTime({
      this.starttime, 
      this.endtime,});

  AcceptedInspectionTime.fromJson(dynamic json) {
    starttime = json['starttime'];
    endtime = json['endtime'];
  }
  String? starttime;
  String? endtime;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['starttime'] = starttime;
    map['endtime'] = endtime;
    return map;
  }

}

class Time {
  Time({
      this.starttime, 
      this.endtime,});

  Time.fromJson(dynamic json) {
    starttime = json['starttime'];
    endtime = json['endtime'];
  }
  String? starttime;
  String? endtime;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['starttime'] = starttime;
    map['endtime'] = endtime;
    return map;
  }

}