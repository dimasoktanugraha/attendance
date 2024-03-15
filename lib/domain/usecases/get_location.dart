import 'package:attendance/data/model/location_model.dart';
import 'package:dartz/dartz.dart';
import '../../data/base/failure.dart';
import '../repositories/main_repository.dart';

class GetLocation {
  final MainRepository repository;

  GetLocation(this.repository);

  Future<Either<Failure, LocationModel>> execute() {
    return repository.getLocation();
  }
}
