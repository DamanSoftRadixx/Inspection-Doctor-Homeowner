class InspectorDetails {
  InspectorDetails({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.averageRating,
  });

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
  dynamic averageRating;

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
