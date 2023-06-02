import 'package:flutter_bloc/flutter_bloc.dart';

import '../farm_model/farm_model.dart';
import '../farm_repository/farm_repository.dart';
import 'farm_event.dart';
import 'farm_state.dart';

class FarmBloc extends Bloc<FarmEvent, FarmState> {
  final FarmRepository farmRepository;

  FarmBloc({required this.farmRepository}) : super(FarmLoading()) {
    on<FarmLoad>((event, emit) async {
      emit(FarmLoading());
      try {
        final List<Farm> farms = await farmRepository.fetchAll();

        emit(
          FarmDataLoaded(farms),
        );
      } catch (error) {
        emit(FarmDataLoadingError(error));
      }
    });

    on<FarmCreate>((event, emit) async {
      try {
        await farmRepository.create(event.farm);
        final farms = await farmRepository.fetchAll();
        emit(FarmDataLoaded(farms));
      } catch (error) {
        emit(FarmDataLoadingError(error));
      }
    });

    on<FarmUpdate>((event, emit) async {
      try {
        await farmRepository.update(event.id, event.farm);

        final farms = await farmRepository.fetchAll();
        emit(FarmDataLoaded(farms));
      } catch (error) {
        emit(FarmDataLoadingError(error));
      }
    });

    on<FarmDelete>(
      (event, emit) async {
        try {
          await farmRepository.delete(event.id);
          final farms = await farmRepository.fetchAll();
          emit(FarmDataLoaded(farms));
        } catch (error) {
          emit(FarmDataLoadingError(error));
        }
      },
    );
    on<FarmReset>(
      (event, emit) {
        emit(FarmInitial());
      },
    );
  }
}
