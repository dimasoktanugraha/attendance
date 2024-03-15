import 'dart:convert';

class LocationModel {

  final int? id;
  final String title;
  final double latitude;
  final double longitude;
  final DateTime createdAt;

  LocationModel({
    this.id,
    required this.title,
    required this.latitude,
    required this.longitude,
    required this.createdAt
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'latitude': latitude,
      'longitude': longitude,
      'createdAt': createdAt.millisecondsSinceEpoch,
    };
  }

  factory LocationModel.fromMap(Map<String, dynamic> map) {
    return LocationModel(
      id: map['id'] != null ? map['id'] as int : null,
      title: map['title'] as String,
      latitude: map['latitude'] as double,
      longitude: map['longitude'] as double,
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory LocationModel.fromJson(String source) => LocationModel.fromMap(json.decode(source) as Map<String, dynamic>);
}