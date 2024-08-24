// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class CategoriesModel {
  final int? id;
  final String? name;
  final String? amount;
  final String? description;
  final String? slug;
  final String? createdAt;
  final String? deletedAt;
  final String? updatedAt;

  CategoriesModel(this.id, this.name, this.amount, this.description, this.slug,
      this.createdAt, this.deletedAt, this.updatedAt);

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'amount': amount,
      'description': description,
      'slug': slug,
      'createdAt': createdAt,
      'deletedAt': deletedAt,
      'updatedAt': updatedAt,
    };
  }

  factory CategoriesModel.fromMap(Map<String, dynamic> map) {
    return CategoriesModel(
      map['id'] != null ? map['id'] as int : null,
      map['name'] != null ? map['name'] as String : null,
      map['amount'] != null ? map['amount'] as String : null,
      map['description'] != null ? map['description'] as String : null,
      map['slug'] != null ? map['slug'] as String : null,
      map['createdAt'] != null ? map['createdAt'] as String : null,
      map['deletedAt'] != null ? map['deletedAt'] as String : null,
      map['updatedAt'] != null ? map['updatedAt'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory CategoriesModel.fromJson(String source) =>
      CategoriesModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
