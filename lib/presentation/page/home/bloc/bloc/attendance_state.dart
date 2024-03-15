part of 'attendance_bloc.dart';

@freezed
class AttendanceState with _$AttendanceState {
  const factory AttendanceState.initial() = _Initial;
  const factory AttendanceState.loading() = _Loading;
  const factory AttendanceState.loaded(AttendanceModel attendance) = _Attendance;
  const factory AttendanceState.error(String message) = _Error;
}
