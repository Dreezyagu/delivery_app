// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class PackageInfoModel {
  final String? name;
  final String? instructions;
  final String? receiverName;
  final String? receiverPhone;
  final double? worth;
  final String? photoUrl;
  final bool? fragile;
  final String? weight;
  final String? pickupAddress;
  final String? deliveryAddress;
  final String? pickupLandmark;
  final String? deliveryLandmark;

  PackageInfoModel(
      this.name,
      this.instructions,
      this.receiverName,
      this.receiverPhone,
      this.worth,
      this.photoUrl,
      this.fragile,
      this.weight,
      this.pickupAddress,
      this.deliveryAddress,
      this.pickupLandmark,
      this.deliveryLandmark);

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'instructions': instructions,
      'receiverName': receiverName,
      'receiverPhone': receiverPhone,
      'worth': worth,
      'photoUrl': photoUrl,
      'fragile': fragile,
      'weight': weight,
      'pickupAddress': pickupAddress,
      'deliveryAddress': deliveryAddress,
      'pickupLandmark': pickupLandmark,
      'deliveryLandmark': deliveryLandmark,
    };
  }

  factory PackageInfoModel.fromMap(Map<String, dynamic> map) {
    return PackageInfoModel(
      map['name'] != null ? map['name'] as String : null,
      map['instructions'] != null ? map['instructions'] as String : null,
      map['receiverName'] != null ? map['receiverName'] as String : null,
      map['receiverPhone'] != null ? map['receiverPhone'] as String : null,
      map['worth'] != null ? map['worth'] as double : null,
      map['photoUrl'] != null ? map['photoUrl'] as String : null,
      map['fragile'] != null ? map['fragile'] as bool : null,
      map['weight'] != null ? map['weight'] as String : null,
      map['pickupAddress'] != null ? map['pickupAddress'] as String : null,
      map['deliveryAddress'] != null ? map['deliveryAddress'] as String : null,
      map['pickupLandmark'] != null ? map['pickupLandmark'] as String : null,
      map['deliveryLandmark'] != null
          ? map['deliveryLandmark'] as String
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory PackageInfoModel.fromJson(String source) =>
      PackageInfoModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
