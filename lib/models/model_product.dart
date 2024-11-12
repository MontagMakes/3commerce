// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ProductModel {
  final String id;
  final String title;
  final String description;
  final int price;
  final String ownerID;
  final String imageUrl;
  final String modelUrl;
  ProductModel({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.ownerID,
    required this.imageUrl,
    required this.modelUrl,
  });
  

  ProductModel copyWith({
    String? id,
    String? title,
    String? description,
    int? price,
    String? ownerID,
    String? imageUrl,
    String? modelUrl,
  }) {
    return ProductModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      price: price ?? this.price,
      ownerID: ownerID ?? this.ownerID,
      imageUrl: imageUrl ?? this.imageUrl,
      modelUrl: modelUrl ?? this.modelUrl,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'description': description,
      'price': price,
      'ownerID': ownerID,
      'imageUrl': imageUrl,
      'modelUrl': modelUrl,
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      id: map['id'] as String,
      title: map['title'] as String,
      description: map['description'] as String,
      price: map['price'] as int,
      ownerID: map['ownerID'] as String,
      imageUrl: map['imageUrl'] as String,
      modelUrl: map['modelUrl'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductModel.fromJson(String source) => ProductModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ProductModel(id: $id, title: $title, description: $description, price: $price, ownerID: $ownerID, imageUrl: $imageUrl, modelUrl: $modelUrl)';
  }

  @override
  bool operator ==(covariant ProductModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.title == title &&
      other.description == description &&
      other.price == price &&
      other.ownerID == ownerID &&
      other.imageUrl == imageUrl &&
      other.modelUrl == modelUrl;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      title.hashCode ^
      description.hashCode ^
      price.hashCode ^
      ownerID.hashCode ^
      imageUrl.hashCode ^
      modelUrl.hashCode;
  }
}
