import 'package:dartz/dartz.dart';
import '../../data/base/failure.dart';
import '../../data/model/attendance_model.dart';
import '../repositories/main_repository.dart';

class SetAttendance {
  final MainRepository repository;

  SetAttendance(this.repository);

  Future<Either<Failure, AttendanceModel>> execute(String type, double latitude, double longitude) {
    return repository.setAttendance(type, latitude, longitude);
  }
}
