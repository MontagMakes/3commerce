// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:core';

import 'package:flutter/foundation.dart';

import 'package:e_commerce/models/product_model.dart';

class CartModel {
  List<ProductModel> products;
  int totalAmount;
  CartModel({
    required this.products,
    required this.totalAmount,
  });
  

  CartModel copyWith({
    List<ProductModel>? products,
    int? totalAmount,
  }) {
    return CartModel(
      products: products ?? this.products,
      totalAmount: totalAmount ?? this.totalAmount,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'products': products.map((x) => x.toMap()).toList(),
      'totalAmount': totalAmount,
    };
  }

  factory CartModel.fromMap(Map<String, dynamic> map) {
    return CartModel(
      products: List<ProductModel>.from((map['products'] as List<int>).map<ProductModel>((x) => ProductModel.fromMap(x as Map<String,dynamic>),),),
      totalAmount: map['totalAmount'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory CartModel.fromJson(String source) => CartModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'CartModel(products: $products, totalAmount: $totalAmount)';

  @override
  bool operator ==(covariant CartModel other) {
    if (identical(this, other)) return true;
  
    return 
      listEquals(other.products, products) &&
      other.totalAmount == totalAmount;
  }

  @override
  int get hashCode => products.hashCode ^ totalAmount.hashCode;
  }
