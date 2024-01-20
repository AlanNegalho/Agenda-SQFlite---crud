class User {
  int? id;
  String? name;
  String? description;
  userMap() {
    var mapping = <String, dynamic>{};
    mapping['id'] = id == null ? null : id; 
    mapping['name'] = name!;
    mapping['description'] = description!;
    return mapping;
  }
}