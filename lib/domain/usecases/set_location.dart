import 'package:attendance/data/model/location_model.dart';
import 'package:dartz/dartz.dart';
import '../../data/base/failure.dart';
import '../repositories/main_repository.dart';

class SetLocation {
  final MainRepository repository;

  SetLocation(this.repository);

  Future<Either<Failure, LocationModel>> execute(String title, double latitude, double longitude) {
    return repository.setLocation(title, latitude, longitude);
  }
}
