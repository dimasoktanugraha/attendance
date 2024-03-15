import 'package:attendance/data/model/attendance_model.dart';
import 'package:attendance/domain/repositories/main_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'attendance_event.dart';
part 'attendance_state.dart';
part 'attendance_bloc.freezed.dart';

class AttendanceBloc extends Bloc<AttendanceEvent, AttendanceState> {

  MainRepository repository;

  AttendanceBloc(this.repository) : super(_Initial()) {
    on<_SetAttendance>((event, emit) async {
      emit(AttendanceState.loading());

      final response = await repository.setAttendance(event.type, event.latitude, event.longitude);

      response.fold(
        (l) => emit(AttendanceState.error(l.message)), 
        (r) => emit(AttendanceState.loaded(r))
      );
    });
  }
}
