// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

//Create a UserModel model
class UserModel {
  final String? id;
  final String? name;
  final String? email;
  UserModel({
    this.id,
    this.name,
    this.email,
  });

  UserModel copyWith({
    String? id,
    String? name,
    String? email,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'email': email,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] != null ? map['id'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
    );
  }
  
  @override
  String toString() => 'UserModel(id: $id, name: $name, email: $email)';
}
