class AddPropertyResponseModel {
  AddPropertyResponseModel({
      this.status, 
      this.success, 
      this.data, 
      this.message,});

  AddPropertyResponseModel.fromJson(dynamic json) {
    status = json['status'];
    success = json['success'];
    data = json['data'];
    message = json['message'];
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