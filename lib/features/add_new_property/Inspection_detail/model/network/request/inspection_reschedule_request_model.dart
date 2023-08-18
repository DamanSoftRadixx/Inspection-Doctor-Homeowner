import 'package:inspection_doctor_homeowner/core/extensions/string_extensions.dart';
import 'package:inspection_doctor_homeowner/core/network_utility/model/time_model.dart';

class InspectionRescheduleRequestModel {
  InspectionRescheduleRequestModel({
    this.type,
    this.date,
    this.time,
    this.description,
    this.firstName,
    this.lastName,
    this.email,
    this.phone,
    this.countryCode,
  });

  InspectionRescheduleRequestModel.fromJson(dynamic json) {
    type = json['type'].toString().toStringConversion();
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
  }
  String? type;
  String? date;
  List<TimeModel>? time;
  String? description;
  String? firstName;
  String? lastName;
  String? email;
  String? phone;
  String? countryCode;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['type'] = type;
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
    return map;
  }
}
