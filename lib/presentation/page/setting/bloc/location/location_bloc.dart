import 'package:attendance/data/model/location_model.dart';
import 'package:attendance/domain/repositories/main_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'location_event.dart';
part 'location_state.dart';
part 'location_bloc.freezed.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {

  MainRepository repository;

  LocationBloc(this.repository) : super(const _Initial()) {

    on<_SetLocation>((event, emit) async {
      emit(LocationState.loading());

      final response = await repository.setLocation('office', event.latitude, event.longitude);

      response.fold(
        (l) => emit(LocationState.error(l.message)), 
        (r) => emit(LocationState.loaded(r))
      );
    });

    on<_GetLocation>((event, emit) async {
      emit(LocationState.loading());

      final response = await repository.getLocation();

      response.fold(
        (l) => emit(LocationState.error(l.message)), 
        (r) => emit(LocationState.loaded(r))
      );
    });
  }
}
