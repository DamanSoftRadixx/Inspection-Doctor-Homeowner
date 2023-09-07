import 'package:inspection_doctor_homeowner/core/extensions/string_extensions.dart';
import 'package:inspection_doctor_homeowner/core/network_utility/model/time_model.dart';

class InspectionCreateRequestModel {
  InspectionCreateRequestModel(
      {this.propertyId,
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
      this.homeownerId,
      this.categoriesName,
      this.subCategoriesName});

  InspectionCreateRequestModel.fromJson(dynamic json) {
    propertyId = json['property_id'].toString().toStringConversion();
    categoryId = json['category_id'].toString().toStringConversion();
    subcategoryId = json['subcategory_id'] != null
        ? json['subcategory_id'].cast<String>()
        : [];
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
    homeownerId = json['homeowner_id'].toString().toStringConversion();
  }
  String? propertyId;
  String? categoryId;
  List<String>? subcategoryId;
  String? date;
  List<TimeModel>? time;
  String? description;
  String? firstName;
  String? lastName;
  String? email;
  String? phone;
  String? countryCode;
  String? homeownerId;
  // local use
  String? categoriesName;
  String? subCategoriesName;

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
