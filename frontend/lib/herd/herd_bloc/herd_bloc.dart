import 'package:flutter_bloc/flutter_bloc.dart';

import '../herd_repository/herd_repository.dart';
import '../model/herd_model.dart';
import 'herd_event.dart';
import 'herd_state.dart';

class HerdBloc extends Bloc<HerdEvent, HerdState> {
  final HerdRepository herdRepository;

  HerdBloc({required this.herdRepository}) : super(HerdLoading()) {
    on<HerdLoad>(
      (event, emit) async {
        emit(HerdLoading());
        try {
          final herds = await herdRepository.fetchAll();
          emit(HerdDataLoaded(herds as Iterable<Herd>));
        } catch (error) {
          emit(HerdDataLoadingError(error));
        }
      },
    );

    on<HerdLoadOne>(
      (event, emit) async {
        emit(HerdLoading());
        try {
          final herds = await herdRepository.fetchOne(event.id);

          emit(HerdDataLoadedone(herds));
        } catch (error) {
          emit(HerdDataLoadingError(error));
        }
      },
    );

    on<HerdCreate>(
      (event, emit) async {
        try {
          await herdRepository.create(event.herd);
          final herds = await herdRepository.fetchAll();
          emit(HerdDataLoaded(herds as Iterable<Herd>));
        } catch (error) {
          emit(HerdDataLoadingError(error));
        }
      },
    );

    on<HerdUpdate>(
      (event, emit) async {
        try {
          await herdRepository.update(event.id, event.herd);
          final herds = await herdRepository.fetchAll();
          emit(HerdDataLoaded(herds as Iterable<Herd>));
          final herd = await herdRepository.fetchOne(event.id);
          emit(HerdDataLoadedone(herd));
        } catch (error) {
          emit(HerdDataLoadingError(error));
        }
      },
    );

    on<HerdReset>(
      (event, emit) {
        emit(HerdInitial());
      },
    );

    on<HerdDelete>(
      (event, emit) async {
        try {
          await herdRepository.delete(event.id);
          final herds = await herdRepository.fetchAll();
          emit(HerdDataLoaded(herds as Iterable<Herd>));
        } catch (error) {
          emit(HerdDataLoadingError(error));
        }
      },
    );
  }
}
