import 'package:attendance/domain/usecases/get_attendance.dart';
import 'package:attendance/domain/usecases/set_attendance.dart';
import 'package:attendance/presentation/page/history/bloc/history/history_bloc.dart';
import 'package:attendance/presentation/page/home/bloc/bloc/attendance_bloc.dart';
import 'package:attendance/presentation/page/setting/bloc/location/location_bloc.dart';
import 'package:get_it/get_it.dart';

import '../data/local/database_provider.dart';
import '../data/local/local_data_source.dart';
import '../data/repositories/main_repository_impl.dart';
import '../domain/repositories/main_repository.dart';
import '../domain/usecases/get_location.dart';
import '../domain/usecases/set_location.dart';
import '../presentation/page/setting/bloc/theme/theme_bloc.dart';

final locator = GetIt.instance;

void init() {

  // Database
  locator.registerLazySingleton<DatabaseProvider>(() => DatabaseProvider());

  // Data Source
  locator.registerLazySingleton<LocalDataSource>(
          () => LocalDatasourceImpl(provider: locator()));

  // Repository
  locator.registerLazySingleton<MainRepository>(
          () => MainRepositoryImpl(
            localDataSource: locator(),
          ));

  // Use Case
  locator.registerLazySingleton(() => SetLocation(locator()));
  locator.registerLazySingleton(() => GetLocation(locator()));
  locator.registerLazySingleton(() => SetAttendance(locator()));
  locator.registerLazySingleton(() => GetAttendance(locator()));

  // Bloc
  locator.registerFactory(() => ThemeBloc(locator()));
  locator.registerFactory(() => LocationBloc(locator()));
  locator.registerFactory(() => AttendanceBloc(locator()));
  locator.registerFactory(() => HistoryBloc(locator()));
}