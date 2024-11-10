// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ProductModel {
  final String title;
  final String description;
  final int price;
  final String imageUrl;
  final String modelUrl; // Link to 3D model
  ProductModel({
    required this.title,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.modelUrl,
  });

  ProductModel copyWith({
    String? title,
    String? description,
    int? price,
    String? imageUrl,
    String? modelUrl,
  }) {
    return ProductModel(
      title: title ?? this.title,
      description: description ?? this.description,
      price: price ?? this.price,
      imageUrl: imageUrl ?? this.imageUrl,
      modelUrl: modelUrl ?? this.modelUrl,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'description': description,
      'price': price,
      'imageUrl': imageUrl,
      'modelUrl': modelUrl,
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      title: map['title'] as String,
      description: map['description'] as String,
      price: map['price'] as int,
      imageUrl: map['imageUrl'] as String,
      modelUrl: map['modelUrl'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductModel.fromJson(String source) => ProductModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ProductModel(title: $title, description: $description, price: $price, imageUrl: $imageUrl, modelUrl: $modelUrl)';
  }

  @override
  bool operator ==(covariant ProductModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.title == title &&
      other.description == description &&
      other.price == price &&
      other.imageUrl == imageUrl &&
      other.modelUrl == modelUrl;
  }

  @override
  int get hashCode {
    return title.hashCode ^
      description.hashCode ^
      price.hashCode ^
      imageUrl.hashCode ^
      modelUrl.hashCode;
  }
}
