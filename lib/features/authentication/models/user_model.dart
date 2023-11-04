// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserModel {
  final String? username;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? phone;
  final String? role;
  final String? address;
  final String? fcmToken;
  final String? id;
  final String? status;
  final String? createdAt;
  final String? updatedAt;

  UserModel(
      this.username,
      this.firstName,
      this.lastName,
      this.email,
      this.phone,
      this.role,
      this.address,
      this.fcmToken,
      this.id,
      this.status,
      this.createdAt,
      this.updatedAt);

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'username': username,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'phone': phone,
      'role': role,
      'address': address,
      'fcmToken': fcmToken,
      'id': id,
      'status': status,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      map['username'] != null ? map['username'] as String : null,
      map['firstName'] != null ? map['firstName'] as String : null,
      map['lastName'] != null ? map['lastName'] as String : null,
      map['email'] != null ? map['email'] as String : null,
      map['phone'] != null ? map['phone'] as String : null,
      map['role'] != null ? map['role'] as String : null,
      map['address'] != null ? map['address'] as String : null,
      map['fcmToken'] != null ? map['fcmToken'] as String : null,
      map['id'] != null ? map['id'] as String : null,
      map['status'] != null ? map['status'] as String : null,
      map['createdAt'] != null ? map['createdAt'] as String : null,
      map['updatedAt'] != null ? map['updatedAt'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
