class CategoriesModel {
  String title;
  String imageName;
  bool isSelected;
  String id;

  CategoriesModel(
      {required this.title,
      required this.imageName,
      required this.isSelected,
      required this.id});
}

class CategoryId {
  CategoryId({
    this.id,
    this.name,
  });

  CategoryId.fromJson(dynamic json) {
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
