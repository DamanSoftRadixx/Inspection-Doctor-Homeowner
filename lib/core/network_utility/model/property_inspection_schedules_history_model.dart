import 'package:inspection_doctor_homeowner/core/network_utility/model/time_model.dart';

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
  });

  PropertyInspectionSchedulesHistory.fromJson(dynamic json) {
    id = json['_id'];
    date = json['date'];
    if (json['time'] != null) {
      time = [];
      json['time'].forEach((v) {
        time?.add(TimeModel.fromJson(v));
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
        acceptedInspectionTime?.add(TimeModel.fromJson(v));
      });
    }
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
    return map;
  }
}
