import 'dart:convert';

List<Product> productListFromJson(String str) =>
    List<Product>.from(json.decode(str).map((x) => Product.fromJson(x)));

class Product {
  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.stock,
    this.description,
    this.category,
    required this.imageUrl,
    this.user,
    this.createdAt,
    this.updatedAt,
  });

  String id;
  String name;
  int price;
  int stock;
  String? description;
  String? category;
  String imageUrl;
  String? user;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json["id"],
    name: json["name"],
    price: json["price"],
    stock: json["stock"],
    description: json["description"],
    category: json["category"],
    imageUrl: json["image_url"] ?? "",
    user: json["user"],
    createdAt:
    json["created_at"] != null ? DateTime.parse(json["created_at"]) : null,
    updatedAt:
    json["updated_at"] != null ? DateTime.parse(json["updated_at"]) : null,
  );
}
