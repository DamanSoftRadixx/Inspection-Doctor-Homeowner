class Test {
  Test({
      this.status, 
      this.success, 
      this.data, 
      this.message,});

  Test.fromJson(dynamic json) {
    status = json['status'];
    success = json['success'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(Data.fromJson(v));
      });
    }
    message = json['message'];
  }
  int? status;
  bool? success;
  List<Data>? data;
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

class Data {
  Data({
      this.id, 
      this.homeownerId, 
      this.latestUpdate, 
      this.propertyInspectionSchedulesHistory, 
      this.homeownerDetails, 
      this.homeownerImage, 
      this.ratings, 
      this.properties, 
      this.stateInfo, 
      this.inspectorDetails, 
      this.inspectorImage, 
      this.category, 
      this.subcategory,});

  Data.fromJson(dynamic json) {
    id = json['_id'];
    homeownerId = json['homeowner_id'];
    latestUpdate = json['latest_update'];
    if (json['property_inspection_schedules_history'] != null) {
      propertyInspectionSchedulesHistory = [];
      json['property_inspection_schedules_history'].forEach((v) {
        propertyInspectionSchedulesHistory?.add(PropertyInspectionSchedulesHistory.fromJson(v));
      });
    }
    if (json['homeowner_details'] != null) {
      homeownerDetails = [];
      json['homeowner_details'].forEach((v) {
        homeownerDetails?.add(HomeownerDetails.fromJson(v));
      });
    }
    if (json['homeowner_image'] != null) {
      homeownerImage = [];
      json['homeowner_image'].forEach((v) {
        homeownerImage?.add(HomeownerImage.fromJson(v));
      });
    }
    if (json['ratings'] != null) {
      ratings = [];
      json['ratings'].forEach((v) {
        ratings?.add(Ratings.fromJson(v));
      });
    }
    properties = json['properties'] != null ? Properties.fromJson(json['properties']) : null;
    if (json['state_info'] != null) {
      stateInfo = [];
      json['state_info'].forEach((v) {
        stateInfo?.add(StateInfo.fromJson(v));
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
  bool? latestUpdate;
  List<PropertyInspectionSchedulesHistory>? propertyInspectionSchedulesHistory;
  List<HomeownerDetails>? homeownerDetails;
  List<HomeownerImage>? homeownerImage;
  List<Ratings>? ratings;
  Properties? properties;
  List<StateInfo>? stateInfo;
  List<InspectorDetails>? inspectorDetails;
  List<InspectorImage>? inspectorImage;
  Category? category;
  List<Subcategory>? subcategory;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['homeowner_id'] = homeownerId;
    map['latest_update'] = latestUpdate;
    if (propertyInspectionSchedulesHistory != null) {
      map['property_inspection_schedules_history'] = propertyInspectionSchedulesHistory?.map((v) => v.toJson()).toList();
    }
    if (homeownerDetails != null) {
      map['homeowner_details'] = homeownerDetails?.map((v) => v.toJson()).toList();
    }
    if (homeownerImage != null) {
      map['homeowner_image'] = homeownerImage?.map((v) => v.toJson()).toList();
    }
    if (ratings != null) {
      map['ratings'] = ratings?.map((v) => v.toJson()).toList();
    }
    if (properties != null) {
      map['properties'] = properties?.toJson();
    }
    if (stateInfo != null) {
      map['state_info'] = stateInfo?.map((v) => v.toJson()).toList();
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
      this.id, 
      this.firstName, 
      this.lastName, 
      this.email, 
      this.averageRating,});

  InspectorDetails.fromJson(dynamic json) {
    id = json['_id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    averageRating = json['average_rating'];
  }
  String? id;
  String? firstName;
  String? lastName;
  String? email;
  int? averageRating;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['first_name'] = firstName;
    map['last_name'] = lastName;
    map['email'] = email;
    map['average_rating'] = averageRating;
    return map;
  }

}

class StateInfo {
  StateInfo({
      this.id, 
      this.name,});

  StateInfo.fromJson(dynamic json) {
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

class Properties {
  Properties({
      this.id, 
      this.propertyName, 
      this.latitude, 
      this.longitude, 
      this.isAddressAssigned, 
      this.addressLine1, 
      this.addressLine2, 
      this.city, 
      this.zipCode, 
      this.lotNumber, 
      this.blockNumber, 
      this.plotNumber, 
      this.countyId, 
      this.latestUpdate,});

  Properties.fromJson(dynamic json) {
    id = json['_id'];
    propertyName = json['property_name'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    isAddressAssigned = json['is_address_assigned'];
    addressLine1 = json['address_line_1'];
    addressLine2 = json['address_line_2'];
    city = json['city'];
    zipCode = json['zip_code'];
    lotNumber = json['lot_number'];
    blockNumber = json['block_number'];
    plotNumber = json['plot_number'];
    countyId = json['county_id'];
    latestUpdate = json['latest_update'];
  }
  String? id;
  String? propertyName;
  String? latitude;
  String? longitude;
  bool? isAddressAssigned;
  String? addressLine1;
  String? addressLine2;
  String? city;
  String? zipCode;
  String? lotNumber;
  String? blockNumber;
  String? plotNumber;
  String? countyId;
  bool? latestUpdate;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['property_name'] = propertyName;
    map['latitude'] = latitude;
    map['longitude'] = longitude;
    map['is_address_assigned'] = isAddressAssigned;
    map['address_line_1'] = addressLine1;
    map['address_line_2'] = addressLine2;
    map['city'] = city;
    map['zip_code'] = zipCode;
    map['lot_number'] = lotNumber;
    map['block_number'] = blockNumber;
    map['plot_number'] = plotNumber;
    map['county_id'] = countyId;
    map['latest_update'] = latestUpdate;
    return map;
  }

}

class Ratings {
  Ratings({
      this.id, 
      this.senderId, 
      this.receiverId, 
      this.rating, 
      this.comment,});

  Ratings.fromJson(dynamic json) {
    id = json['_id'];
    senderId = json['sender_id'];
    receiverId = json['receiver_id'];
    rating = json['rating'];
    comment = json['comment'];
  }
  String? id;
  String? senderId;
  String? receiverId;
  int? rating;
  String? comment;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['sender_id'] = senderId;
    map['receiver_id'] = receiverId;
    map['rating'] = rating;
    map['comment'] = comment;
    return map;
  }

}

class HomeownerImage {
  HomeownerImage({
      this.url,});

  HomeownerImage.fromJson(dynamic json) {
    url = json['url'];
  }
  String? url;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['url'] = url;
    return map;
  }

}

class HomeownerDetails {
  HomeownerDetails({
      this.firstName, 
      this.lastName, 
      this.email,});

  HomeownerDetails.fromJson(dynamic json) {
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
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
      this.updatedAt,});

  PropertyInspectionSchedulesHistory.fromJson(dynamic json) {
    id = json['_id'];
    date = json['date'];
    if (json['time'] != null) {
      time = [];
      json['time'].forEach((v) {
        time?.add(Time.fromJson(v));
      });
    }
    description = json['description'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    phone = json['phone'];
    countryCode = json['country_code'];
    inspectionStatusId = json['inspection_status_id'];
    acceptedInspectionDate = json['accepted_inspection_date'];
    if (json['accepted_inspection_time'] != null) {
      acceptedInspectionTime = [];
      json['accepted_inspection_time'].forEach((v) {
        acceptedInspectionTime?.add(AcceptedInspectionTime.fromJson(v));
      });
    }
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }
  String? id;
  String? date;
  List<Time>? time;
  String? description;
  String? firstName;
  String? lastName;
  String? email;
  String? phone;
  String? countryCode;
  String? inspectionStatusId;
  String? acceptedInspectionDate;
  List<AcceptedInspectionTime>? acceptedInspectionTime;
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
      map['accepted_inspection_time'] = acceptedInspectionTime?.map((v) => v.toJson()).toList();
    }
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
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