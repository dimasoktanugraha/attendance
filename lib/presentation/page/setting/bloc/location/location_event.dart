part of 'location_bloc.dart';

@freezed
class LocationEvent with _$LocationEvent {
  const factory LocationEvent.started() = _Started;
  const factory LocationEvent.setLocation(double latitude, double longitude) = _SetLocation;
  const factory LocationEvent.getLocation() = _GetLocation;
}