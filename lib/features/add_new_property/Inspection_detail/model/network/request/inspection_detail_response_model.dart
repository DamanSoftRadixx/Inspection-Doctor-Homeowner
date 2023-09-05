import 'package:inspection_doctor_homeowner/core/network_utility/model/property_model.dart';
import 'package:inspection_doctor_homeowner/features/add_new_property/property_detail/model/network_model/Inspector_details.dart';
import 'package:inspection_doctor_homeowner/features/add_new_property/property_detail/model/network_model/property_inspection_schedules_history_model.dart';
import 'package:inspection_doctor_homeowner/features/add_new_property/property_detail/model/network_model/schedule_inspection_list_response_model.dart';

class InspectionDetailResponseModel {
  InspectionDetailResponseModel({
    this.status,
    this.success,
    this.data,
    this.message,
  });

  InspectionDetailResponseModel.fromJson(dynamic json) {
    status = json['status'];
    success = json['success'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(InspectionDetailData.fromJson(v));
      });
    }
    message = json['message'];
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
    this.latestUpdate,
    this.propertyInspectionSchedulesHistory,
    this.ratings,
    this.properties,
    this.stateInfo,
    this.inspectorDetails,
    this.inspectorImage,
    this.category,
    this.subcategory,
    this.homeownerImage,
  });

  InspectionDetailData.fromJson(dynamic json) {
    id = json['_id'];
    homeownerId = json['homeowner_id'];
    latestUpdate = json['latest_update'];
    if (json['property_inspection_schedules_history'] != null) {
      propertyInspectionSchedulesHistory = [];
      json['property_inspection_schedules_history'].forEach((v) {
        propertyInspectionSchedulesHistory
            ?.add(PropertyInspectionSchedulesHistory.fromJson(v));
      });
    }
    if (json['ratings'] != null) {
      ratings = [];
      json['ratings'].forEach((v) {
        ratings?.add(Ratings.fromJson(v));
      });
    }
    properties = json['properties'] != null
        ? Properties.fromJson(json['properties'])
        : null;
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
    if (json['homeowner_image'] != null) {
      homeownerImage = [];
      json['homeowner_image'].forEach((v) {
        homeownerImage?.add(HomeownerImage.fromJson(v));
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
  bool? latestUpdate;
  List<PropertyInspectionSchedulesHistory>? propertyInspectionSchedulesHistory;
  List<Ratings>? ratings;
  Properties? properties;
  List<StateInfo>? stateInfo;
  List<InspectorDetails>? inspectorDetails;
  List<InspectorImage>? inspectorImage;
  Category? category;
  List<Subcategory>? subcategory;
  List<HomeownerImage>? homeownerImage;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['homeowner_id'] = homeownerId;
    map['latest_update'] = latestUpdate;
    if (propertyInspectionSchedulesHistory != null) {
      map['property_inspection_schedules_history'] =
          propertyInspectionSchedulesHistory?.map((v) => v.toJson()).toList();
    }
    if (ratings != null) {
      map['ratings'] = ratings?.map((v) => v.toJson()).toList();
    }
    if (properties != null) {
      map['properties'] = properties?.toJson();
    }
    if (homeownerImage != null) {
      map['homeowner_image'] = homeownerImage?.map((v) => v.toJson()).toList();
    }
    if (stateInfo != null) {
      map['state_info'] = stateInfo?.map((v) => v.toJson()).toList();
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

class HomeownerImage {
  HomeownerImage({
    this.url,
  });

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

class StateInfo {
  StateInfo({
    this.id,
    this.name,
  });

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

class Ratings {
  Ratings({
    this.id,
    this.senderId,
    this.receiverId,
    this.rating,
    this.comment,
  });

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
