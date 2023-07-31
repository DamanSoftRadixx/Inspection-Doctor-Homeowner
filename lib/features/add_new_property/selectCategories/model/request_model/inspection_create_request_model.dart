class InspectionCreateRequestModel {
  InspectionCreateRequestModel({
      this.propertyId, 
      this.categoryId, 
      this.subcategoryId, 
      this.date, 
      this.time, 
      this.description, 
      this.firstName, 
      this.lastName, 
      this.email, 
      this.phone, 
      this.countryCode, 
      this.homeownerId,});

  InspectionCreateRequestModel.fromJson(dynamic json) {
    propertyId = json['property_id'];
    categoryId = json['category_id'];
    subcategoryId = json['subcategory_id'] != null ? json['subcategory_id'].cast<String>() : [];
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
    homeownerId = json['homeowner_id'];
  }
  String? propertyId;
  String? categoryId;
  List<String>? subcategoryId;
  String? date;
  List<Time>? time;
  String? description;
  String? firstName;
  String? lastName;
  String? email;
  String? phone;
  String? countryCode;
  String? homeownerId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['property_id'] = propertyId;
    map['category_id'] = categoryId;
    map['subcategory_id'] = subcategoryId;
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
    map['homeowner_id'] = homeownerId;
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