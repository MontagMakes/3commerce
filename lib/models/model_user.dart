// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:e_commerce/models/model_order.dart';

//Create a user model
class UserModel {
  String name;
  String email;
  String address;
  String phoneNumber;
  List<OrderModel> orderHistory;
  UserModel({
    required this.name,
    required this.email,
    required this.address,
    required this.phoneNumber,
    required this.orderHistory,
  });

  UserModel copyWith({
    String? name,
    String? email,
    String? address,
    String? phoneNumber,
    List<OrderModel>? orderHistory,
  }) {
    return UserModel(
      name: name ?? this.name,
      email: email ?? this.email,
      address: address ?? this.address,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      orderHistory: orderHistory ?? this.orderHistory,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'email': email,
      'address': address,
      'phoneNumber': phoneNumber,
      'orderHistory': orderHistory.map((x) => x.toMap()).toList(),
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'] as String,
      email: map['email'] as String,
      address: map['address'] as String,
      phoneNumber: map['phoneNumber'] as String,
      orderHistory: List<OrderModel>.from(
        (map['orderHistory'] as List<int>).map<OrderModel>(
          (x) => OrderModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModel(name: $name, email: $email, address: $address, phoneNumber: $phoneNumber, orderHistory: $orderHistory)';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.email == email &&
        other.address == address &&
        other.phoneNumber == phoneNumber &&
        listEquals(other.orderHistory, orderHistory);
  }

  @override
  int get hashCode {
    return name.hashCode ^
        email.hashCode ^
        address.hashCode ^
        phoneNumber.hashCode ^
        orderHistory.hashCode;
  }
}
