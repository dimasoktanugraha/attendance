import 'dart:convert';

class AttendanceModel {

  final int? id;
  final String type;
  final String status;
  final double pinLatitude;
  final double pinLongitude;
  final double latitude;
  final double longitude;
  final double distance;
  final DateTime createdAt;

  AttendanceModel({
    this.id,
    required this.type,
    required this.status,
    required this.pinLatitude,
    required this.pinLongitude,
    required this.latitude,
    required this.longitude,
    required this.distance,
    required this.createdAt
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'type': type,
      'status': status,
      'pinLatitude': pinLatitude,
      'pinLongitude': pinLongitude,
      'latitude': latitude,
      'longitude': longitude,
      'distance': distance,
      'createdAt': createdAt.millisecondsSinceEpoch,
    };
  }

  factory AttendanceModel.fromMap(Map<String, dynamic> map) {
    return AttendanceModel(
      id: map['id'] != null ? map['id'] as int : null,
      type: map['type'] as String,
      status: map['status'] as String,
      pinLatitude: map['pinLatitude'] as double,
      pinLongitude: map['pinLongitude'] as double,
      latitude: map['latitude'] as double,
      longitude: map['longitude'] as double,
      distance: map['distance'] as double,
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory AttendanceModel.fromJson(String source) => AttendanceModel.fromMap(json.decode(source) as Map<String, dynamic>);
}