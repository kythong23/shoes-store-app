class Categories {
  int? id;
  String? name;
  String? imageURL;
  Null? description;

  Categories({this.id, this.name, this.imageURL, this.description});

  Categories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    imageURL = json['imageURL'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['imageURL'] = this.imageURL;
    data['description'] = this.description;
    return data;
  }
  static List<Categories> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => Categories.fromJson(json)).toList();
  }
}