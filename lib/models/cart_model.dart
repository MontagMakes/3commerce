import 'dart:core';

import 'package:e_commerce/models/product_model.dart';

class CartModel {
  List<ProductModel> products;
  int totalPrice;
  CartModel({
    required this.products,
    required this.totalPrice,
  });

  CartModel copyWith({
    List<ProductModel>? products,
    int? totalPrice,
  }) {
    return CartModel(
      products: products ?? this.products,
      totalPrice: totalPrice ?? this.totalPrice,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'products': products.map((x) => x.toMap()).toList(),
      'totalPrice': totalPrice,
    };
  }

  factory CartModel.fromMap(Map<String, dynamic> map) {
    return CartModel(
      products: List<ProductModel>.from(
        (map['products'] as List<int>).map<ProductModel>(
          (x) => ProductModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
      totalPrice: map['totalPrice'] as int,
    );
  }
}
