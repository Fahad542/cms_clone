import 'dart:convert';

Product productFromJson(String str) {
  final jsonData = json.decode(str);
  return Product.fromMap(jsonData);
}

String productToJson(Product data) {
  final dyn = data.toMap();
  return json.encode(dyn);
}

class Product{
  int? id;
  String? ProductName;

  Product({
    this.id,
    this.ProductName
  });

  factory Product.fromMap(Map<String, dynamic> json) => new Product(
    id: json["id"],
    ProductName: json["product_name"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "product_name": ProductName,
  };

}
