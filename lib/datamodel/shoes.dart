class Shoes {
  int? id;
  String? name;
  String? description;
  String? imageURL;
  int? price;
  int? categoryID;
  String? categoryName;

  Shoes(
      {this.id,
        this.name,
        this.description,
        this.imageURL,
        this.price,
        this.categoryID,
        this.categoryName});

  Shoes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    imageURL = json['imageURL'];
    price = json['price'];
    categoryID = json['categoryID'];
    categoryName = json['categoryName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['imageURL'] = this.imageURL;
    data['price'] = this.price;
    data['categoryID'] = this.categoryID;
    data['categoryName'] = this.categoryName;
    return data;
  }
  static List<Shoes> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => Shoes.fromJson(json)).toList();
  }
}