import 'package:dartz/dartz.dart';
import '../../data/base/failure.dart';
import '../../data/model/attendance_model.dart';
import '../repositories/main_repository.dart';

class GetAttendance {
  final MainRepository repository;

  GetAttendance(this.repository);

  Future<Either<Failure, List<AttendanceModel>>> execute() {
    return repository.getAttendance();
  }
}
