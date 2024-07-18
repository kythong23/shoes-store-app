class Voucher {
  String? id;
  String? name;
  String? discount;

  Voucher({this.id, this.name, this.discount});

  Voucher.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    discount = json['discount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['discount'] = this.discount;
    return data;
  }
}