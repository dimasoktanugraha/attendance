import 'package:attendance/data/model/attendance_model.dart';
import 'package:attendance/domain/repositories/main_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'history_event.dart';
part 'history_state.dart';
part 'history_bloc.freezed.dart';

class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {

  MainRepository repository;
  
  HistoryBloc(this.repository) : super(_Initial()) {
    on<_GetHistory>((event, emit) async{
      emit(const HistoryState.loading());

      final response = await repository.getAttendance();

      response.fold(
        (l) => emit(HistoryState.error(l.message)), 
        (r) => emit(HistoryState.loaded(r))
      );
    });
  }
}
