part of 'location_bloc.dart';

@freezed
class LocationState with _$LocationState {
  const factory LocationState.initial() = _Initial;
  const factory LocationState.loading() = _Loading;
  const factory LocationState.loaded(LocationModel location) = _Location;
  const factory LocationState.error(String message) = _Error;
}
