class Product {
  String? id;
  String? name;
  double price = 0;

  Product.fromJson(Map<String, dynamic> map) {
    id = map['id'];
    name = map['name'];
    price = map['price'];
  }

  toJson() {
    return {'id': id, 'name': name, 'price': price};
  }
}
