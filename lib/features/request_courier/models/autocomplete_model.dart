// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class AutocompleteModel {
  final String? description;
  final String? placeId;

  AutocompleteModel(this.description, this.placeId);

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'description': description,
      'place_id': placeId,
    };
  }

  factory AutocompleteModel.fromMap(Map<String, dynamic> map) {
    return AutocompleteModel(
      map['description'] != null ? map['description'] as String : null,
      map['place_id'] != null ? map['place_id'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory AutocompleteModel.fromJson(String source) =>
      AutocompleteModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

class PlacesCordinates {
  final double lat;
  final double lng;

  PlacesCordinates(this.lat, this.lng);

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'lat': lat,
      'lng': lng,
    };
  }

  factory PlacesCordinates.fromMap(Map<String, dynamic> map) {
    return PlacesCordinates(
      map['lat'] as double,
      map['lng'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory PlacesCordinates.fromJson(String source) =>
      PlacesCordinates.fromMap(json.decode(source) as Map<String, dynamic>);
}
