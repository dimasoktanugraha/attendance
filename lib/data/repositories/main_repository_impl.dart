import 'dart:io';
import 'package:attendance/data/model/attendance_model.dart';
import 'package:attendance/data/model/location_model.dart';
import 'package:dartz/dartz.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';

import '../../domain/repositories/main_repository.dart';
import '../base/failure.dart';
import '../local/local_data_source.dart';

class MainRepositoryImpl extends MainRepository{
  final LocalDataSource localDataSource;

  MainRepositoryImpl({
    required this.localDataSource
  });

  @override
  Future<Either<Failure, List<AttendanceModel>>> getAttendance() async{
    try{
      final result = await localDataSource.getAttendanceList();
      return Right(result);
    }on DatabaseException catch (e){
      return Left(DatabaseFailure(e.toString()));
    } catch (e){
      return Left(CommonFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, AttendanceModel>> setAttendance(String type, double latitude, double longitude) async{
    try{
      final result = await localDataSource.insertAttendance(type, latitude, longitude);
      return Right(result);
    }on DatabaseException catch (e){
      return Left(DatabaseFailure(e.toString()));
    } catch (e){
      return Left(CommonFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, LocationModel>> setLocation(String title, double latitude, double longitude) async{
    try{
      final result = await localDataSource.insertLocation(title, latitude, longitude);
      return Right(result);
    }on DatabaseException catch (e){
      return Left(DatabaseFailure(e.toString()));
    } catch (e){
      return Left(CommonFailure(e.toString()));
    }
  }
  
  @override
  Future<Either<Failure, LocationModel>> getLocation() async{
    try{
      final result = await localDataSource.getLocation();
      return Right(result);
    }on DatabaseException catch (e){
      return Left(DatabaseFailure(e.toString()));
    } catch (e){
      return Left(CommonFailure(e.toString()));
    }
  }

}
