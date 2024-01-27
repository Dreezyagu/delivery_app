// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class PricingModel {
  final num? regular;
  final num? express;

  PricingModel({required this.regular, required this.express});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'regular': regular,
      'express': express,
    };
  }

  factory PricingModel.fromMap(Map<String, dynamic> map) {
    return PricingModel(
      regular: map['regular'] != null ? map['regular'] as num : null,
      express: map['express'] != null ? map['express'] as num : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory PricingModel.fromJson(String source) =>
      PricingModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
