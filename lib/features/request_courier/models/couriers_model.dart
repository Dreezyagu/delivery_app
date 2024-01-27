// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

// ignore_for_file: non_constant_identifier_names

class CouriersModel {
  final String? id;
  final String? user_id;
  final String? user_firstName;
  final String? user_lastName;
  final String? user_profilePhoto;
  final String? distance;
  final String? lng;
  final String? lat;

  CouriersModel(this.id, this.user_id, this.user_firstName, this.user_lastName,
      this.user_profilePhoto, this.distance, this.lng, this.lat);

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'user_id': user_id,
      'user_firstName': user_firstName,
      'user_lastName': user_lastName,
      'user_profilePhoto': user_profilePhoto,
      'distance': distance,
      'lng': lng,
      'lat': lat,
    };
  }

  factory CouriersModel.fromMap(Map<String, dynamic> map) {
    return CouriersModel(
      map['id'] != null ? map['id'] as String : null,
      map['user_id'] != null ? map['user_id'] as String : null,
      map['user_firstName'] != null ? map['user_firstName'] as String : null,
      map['user_lastName'] != null ? map['user_lastName'] as String : null,
      map['user_profilePhoto'] != null
          ? map['user_profilePhoto'] as String
          : null,
      map['distance'] != null ? map['distance'] as String : null,
      map['lng'] != null ? map['lng'] as String : null,
      map['lat'] != null ? map['lat'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory CouriersModel.fromJson(String source) =>
      CouriersModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
