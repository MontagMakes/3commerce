// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:e_commerce/models/model_product.dart';

class OrderModel {
  final String id;
  final List<ProductModel> products;
  final double totalAmount;
  final DateTime orderDate;
  final String status;
  OrderModel({
    required this.id,
    required this.products,
    required this.totalAmount,
    required this.orderDate,
    required this.status,
  });

  OrderModel copyWith({
    String? id,
    List<ProductModel>? products,
    double? totalAmount,
    DateTime? orderDate,
    String? status,
  }) {
    return OrderModel(
      id: id ?? this.id,
      products: products ?? this.products,
      totalAmount: totalAmount ?? this.totalAmount,
      orderDate: orderDate ?? this.orderDate,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'products': products.map((x) => x.toMap()).toList(),
      'totalAmount': totalAmount,
      'orderDate': orderDate.millisecondsSinceEpoch,
      'status': status,
    };
  }

  factory OrderModel.fromMap(Map<String, dynamic> map) {
    return OrderModel(
      id: map['id'] as String,
      products: List<ProductModel>.from((map['products'] as List<int>).map<ProductModel>((x) => ProductModel.fromMap(x as Map<String,dynamic>),),),
      totalAmount: map['totalAmount'] as double,
      orderDate: DateTime.fromMillisecondsSinceEpoch(map['orderDate'] as int),
      status: map['status'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderModel.fromJson(String source) => OrderModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'OrderModel(id: $id, products: $products, totalAmount: $totalAmount, orderDate: $orderDate, status: $status)';
  }

  @override
  bool operator ==(covariant OrderModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      listEquals(other.products, products) &&
      other.totalAmount == totalAmount &&
      other.orderDate == orderDate &&
      other.status == status;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      products.hashCode ^
      totalAmount.hashCode ^
      orderDate.hashCode ^
      status.hashCode;
  }
}
