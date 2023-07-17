import 'package:inspection_doctor_homeowner/core/extensions/string_extensions.dart';

class DeletePropertyResponseModel {
  DeletePropertyResponseModel({
    this.status,
    this.success,
    this.data,
    this.message,
  });

  DeletePropertyResponseModel.fromJson(dynamic json) {
    status = json['status'].toString().toIntConversion();
    success = json['success'];
    data = json['data'];
    message = json['message'].toString().toStringConversion();
  }
  int? status;
  bool? success;
  dynamic data;
  String? message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['success'] = success;
    map['data'] = data;
    map['message'] = message;
    return map;
  }
}
