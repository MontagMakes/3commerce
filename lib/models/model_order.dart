// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:e_commerce/models/model_product.dart';

class OrderModel {
  int userId;
  List<ProductModel> products;
  int totalNumber;
  String status;
  String date;
  OrderModel({
    required this.userId,
    required this.products,
    required this.totalNumber,
    required this.status,
    required this.date,
  });

  OrderModel copyWith({
    int? userId,
    List<ProductModel>? products,
    int? totalNumber,
    String? status,
    String? date,
  }) {
    return OrderModel(
      userId: userId ?? this.userId,
      products: products ?? this.products,
      totalNumber: totalNumber ?? this.totalNumber,
      status: status ?? this.status,
      date: date ?? this.date,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userId': userId,
      'products': products.map((x) => x.toMap()).toList(),
      'totalNumber': totalNumber,
      'status': status,
      'date': date,
    };
  }

  factory OrderModel.fromMap(Map<String, dynamic> map) {
    return OrderModel(
      userId: map['userId'] as int,
      products: List<ProductModel>.from((map['products'] as List<int>).map<ProductModel>((x) => ProductModel.fromMap(x as Map<String,dynamic>),),),
      totalNumber: map['totalNumber'] as int,
      status: map['status'] as String,
      date: map['date'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderModel.fromJson(String source) => OrderModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'OrderModel(userId: $userId, products: $products, totalNumber: $totalNumber, status: $status, date: $date)';
  }

  @override
  bool operator ==(covariant OrderModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.userId == userId &&
      listEquals(other.products, products) &&
      other.totalNumber == totalNumber &&
      other.status == status &&
      other.date == date;
  }

  @override
  int get hashCode {
    return userId.hashCode ^
      products.hashCode ^
      totalNumber.hashCode ^
      status.hashCode ^
      date.hashCode;
  }
}
