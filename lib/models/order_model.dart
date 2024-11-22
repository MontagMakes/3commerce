// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:e_commerce/models/product_model.dart';

class OrderModel {
  String? id;
  String? userId;
  String? address;
  List<ProductModel> products;
  int? totalAmount;
  String? orderDate;
  String? status;
  OrderModel({
    this.id,
    this.userId,
    this.address,
    required this.products,
    this.totalAmount,
    this.orderDate,
    this.status,
  });

  OrderModel copyWith({
    String? id,
    String? userId,
    String? address,
    List<ProductModel>? products,
    int? totalAmount,
    String? orderDate,
    String? status,
  }) {
    return OrderModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      address: address ?? this.address,
      products: products ?? this.products,
      totalAmount: totalAmount ?? this.totalAmount,
      orderDate: orderDate ?? this.orderDate,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'userId': userId,
      'address': address,
      'products': products.map((x) => x.toMap()).toList(),
      'totalAmount': totalAmount,
      'orderDate': orderDate,
      'status': status,
    };
  }

  factory OrderModel.fromMap(Map<String, dynamic> map) {
    return OrderModel(
      id: map['id'] != null ? map['id'] as String : null,
      userId: map['userId'] != null ? map['userId'] as String : null,
      address: map['address'] != null ? map['address'] as String : null,
      products: List<ProductModel>.from((map['products'] as List<dynamic>).map<ProductModel>((x) => ProductModel.fromMap(x as Map<String,dynamic>),),),
      totalAmount: map['totalAmount'] != null ? map['totalAmount'] as int : null,
      orderDate: map['orderDate'] != null ? map['orderDate'] as String : null,
      status: map['status'] != null ? map['status'] as String : null,
    );
  }

  @override
  String toString() {
    return 'OrderModel(id: $id, userId: $userId, address: $address, products: $products, totalAmount: $totalAmount, orderDate: $orderDate, status: $status)';
  }
}
