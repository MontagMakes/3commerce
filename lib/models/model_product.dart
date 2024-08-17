// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ProductModel {
  String name;
  String description;
  String category;
  String imageURL;
  String modelURL;
  int price;
  bool instock;
  ProductModel({
    required this.name,
    required this.description,
    required this.price,
    required this.category,
    required this.imageURL,
    required this.modelURL,
    required this.instock,
  });

  ProductModel copyWith({
    String? name,
    String? description,
    int? price,
    String? category,
    String? imageURL,
    String? modelURL,
    bool? instock,
  }) {
    return ProductModel(
      name: name ?? this.name,
      description: description ?? this.description,
      price: price ?? this.price,
      category: category ?? this.category,
      imageURL: imageURL ?? this.imageURL,
      modelURL: modelURL ?? this.modelURL,
      instock: instock ?? this.instock,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'description': description,
      'price': price,
      'category': category,
      'imageURL': imageURL,
      'modelURL': modelURL,
      'instock': instock,
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      name: map['name'] as String,
      description: map['description'] as String,
      price: map['price'] as int,
      category: map['category'] as String,
      imageURL: map['imageURL'] as String,
      modelURL: map['modelURL'] as String,
      instock: map['instock'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductModel.fromJson(String source) =>
      ProductModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ProductModel(name: $name, description: $description, price: $price, category: $category, imageURL: $imageURL, modelURL: $modelURL, instock: $instock)';
  }

  @override
  bool operator ==(covariant ProductModel other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.description == description &&
        other.price == price &&
        other.category == category &&
        other.imageURL == imageURL &&
        other.modelURL == modelURL &&
        other.instock == instock;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        description.hashCode ^
        price.hashCode ^
        category.hashCode ^
        imageURL.hashCode ^
        modelURL.hashCode ^
        instock.hashCode;
  }
}
