part of 'attendance_bloc.dart';

@freezed
class AttendanceEvent with _$AttendanceEvent {
  const factory AttendanceEvent.started() = _Started;
  const factory AttendanceEvent.setAttendance(String type, double latitude, double longitude) = _SetAttendance;
}