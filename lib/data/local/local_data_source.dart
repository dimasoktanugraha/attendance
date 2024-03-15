import 'package:attendance/data/model/attendance_model.dart';
import 'package:attendance/data/model/location_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'database_provider.dart';

abstract class LocalDataSource {
  
  Future<LocationModel> insertLocation(String title, double latitude, double longitude);
  Future<LocationModel> getLocation();

  Future<AttendanceModel> insertAttendance(String type, double latitude, double longitude);
  Future<List<AttendanceModel>> getAttendanceList();

  Future<void> deleteAll();
}

class LocalDatasourceImpl implements LocalDataSource{

  final DatabaseProvider provider;

  LocalDatasourceImpl({
    required this.provider,
  });


  @override
  Future<LocationModel> insertLocation(String title, double latitude, double longitude) async {
    await provider.deleteLocation();
    await provider.insertLocation(
        LocationModel(title: title, latitude: latitude, longitude: longitude, createdAt: DateTime.now()));
    return await provider.getLocation();
  }

  @override
  Future<LocationModel> getLocation() {
    return provider.getLocation();
  }

  @override
  Future<AttendanceModel> insertAttendance(String type, double latitude, double longitude) async {
    final result = await provider.getLocation();

    double distance = Geolocator.distanceBetween(latitude, longitude, result.latitude, result.longitude);

    final status = (distance < 50.0) ? 'Approved' : 'Declined';
    final data = AttendanceModel(
        type: type,
        status: status,
        pinLatitude: result.latitude,
        pinLongitude: result.longitude,
        latitude: latitude,
        longitude: longitude,
        distance: distance,
        createdAt: DateTime.now()
    );

    await provider.insertAttendance(data);
    return data;
  }

  @override
  Future<List<AttendanceModel>> getAttendanceList() {
    return provider.getAttendanceList();
  }

  @override
  Future<void> deleteAll() async{
    return await provider.deleteAll();
  }
}