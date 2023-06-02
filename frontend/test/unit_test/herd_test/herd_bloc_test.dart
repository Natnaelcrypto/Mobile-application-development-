import 'package:flutter_test/flutter_test.dart';
import 'package:pro/herd/herd_repository/herd_repository.dart';
import 'package:pro/herd/model/herd_model.dart';
import 'package:pro/herd/herd_bloc/herd_bloc.dart';
import 'package:pro/herd/herd_bloc/herd_event.dart';
import 'package:pro/herd/herd_bloc/herd_state.dart';
import 'package:mockito/mockito.dart';

class MockHerdRepository extends Mock implements HerdRepository {}

void main() {
  group('HerdBloc', () {
    late HerdBloc herdBloc;
    late MockHerdRepository mockHerdRepository;

    setUp(() {
      mockHerdRepository = MockHerdRepository();
      herdBloc = HerdBloc(herdRepository: mockHerdRepository);
    });

    tearDown(() {
      herdBloc.close();
    });

    test('Initial state should be HerdLoading', () {
      expect(herdBloc.state, HerdLoading());
    });

    test('HerdLoad event should emit HerdDataLoaded state on successful fetch',
        () async {
      final herds = [
        Herd(
          farmname: 'Farm A',
          herdID: '1',
          age: '5',
          bread: 'Bread A',
          health_history: ['history1', 'history2'],
          vaccination: ['vaccine1', 'vaccine2'],
          medication: ['medication1', 'medication2'],
          pregnancy: ['pregnancy1', 'pregnancy2'],
          gender: 'Male',
          id: '1',
        ),
        Herd(
          farmname: 'Farm B',
          herdID: '2',
          age: '3',
          bread: 'Bread B',
          health_history: ['history3', 'history4'],
          vaccination: ['vaccine3', 'vaccine4'],
          medication: ['medication3', 'medication4'],
          pregnancy: ['pregnancy3', 'pregnancy4'],
          gender: 'Female',
          id: '2',
        ),
      ];

      when(mockHerdRepository.fetchAll())
          .thenAnswer((_) => Future.value(herds));

      final expectedStates = [
        HerdLoading(),
        HerdDataLoaded(herds),
      ];

      expectLater(herdBloc.stream, emitsInOrder(expectedStates));

      herdBloc.add(HerdLoad());
    });

    test('HerdLoad event should emit HerdDataLoadingError state on fetch error',
        () async {
      final error = 'Failed to fetch herds';

      when(mockHerdRepository.fetchAll()).thenThrow(error);

      final expectedStates = [
        HerdLoading(),
        HerdDataLoadingError(error),
      ];

      expectLater(herdBloc.stream, emitsInOrder(expectedStates));

      herdBloc.add(HerdLoad());
    });

    // Additional tests for other events (HerdLoadOne, HerdCreate, HerdUpdate, HerdDelete) can be added here
  });
}
