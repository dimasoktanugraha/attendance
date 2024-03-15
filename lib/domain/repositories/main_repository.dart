import 'package:attendance/data/base/failure.dart';
import 'package:attendance/data/model/attendance_model.dart';
import 'package:attendance/data/model/location_model.dart';
import 'package:dartz/dartz.dart';

abstract class MainRepository {

  // Remote
  Future<Either<Failure, LocationModel>> setLocation(String title, double latitude, double longitude);
  Future<Either<Failure, LocationModel>> getLocation();
  Future<Either<Failure, AttendanceModel>> setAttendance(String type, double latitude, double longitude);
  Future<Either<Failure, List<AttendanceModel>>> getAttendance();
}
