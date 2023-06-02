import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mockito/mockito.dart';
import 'package:pro/farm/farm_bloc/farm_bloc.dart';
import 'package:pro/farm/farm_bloc/farm_event.dart';
import 'package:pro/farm/farm_bloc/farm_event.dart';
import 'package:pro/farm/farm_bloc/farm_state.dart';
import 'package:pro/farm/farm_model/farm_model.dart';
import 'package:pro/farm/farm_model/farm_model.dart';
import 'package:pro/farm/farm_repository/farm_repository.dart';
import 'package:pro/farm/farm_bloc/farm_state.dart';

class MockFarmRepository extends Mock implements FarmRepository {}

void main() {
  group('FarmBloc', () {
    late FarmBloc farmBloc;
    late MockFarmRepository mockFarmRepository;

    setUp(() {
      mockFarmRepository = MockFarmRepository();
      farmBloc = FarmBloc(farmRepository: mockFarmRepository);
    });

    tearDown(() {
      farmBloc.close();
    });

    test('Initial state should be FarmLoading', () {
      expect(farmBloc.state, FarmLoading());
    });

    test('FarmLoad event should emit FarmLoading and FarmDataLoaded states',
        () {
      final farms = [
        Farm(
            userID: 'userID',
            farmName: 'farmName',
            expirationDate: 'expirationDate',
            itemName: 'itemName',
            dosage: 'dosage',
            instructions: 'instructions',
            isfeed: true,
            ismedication: true,
            quantity: 'quantity',
            brand: 'brand',
            type: 'type',
            id_: '_id'),
        Farm(
            userID: 'userID',
            farmName: 'farmName',
            expirationDate: 'expirationDate',
            itemName: 'itemName',
            dosage: 'dosage',
            instructions: 'instructions',
            isfeed: true,
            ismedication: true,
            quantity: 'quantity',
            brand: 'brand',
            type: 'type',
            id_: '_id'),
      ];
      when(mockFarmRepository.fetchAll())
          .thenAnswer((_) => Future.value(farms));

      final expectedStates = [
        FarmLoading(),
        FarmDataLoaded(farms),
      ];

      expectLater(farmBloc.stream, emitsInOrder(expectedStates));

      farmBloc.add(FarmLoad());
    });

    test('FarmCreate event should emit FarmDataLoaded state', () {
      final farm = Farm(
          userID: 'userID',
          farmName: 'farmName',
          expirationDate: 'expirationDate',
          itemName: 'itemName',
          dosage: 'dosage',
          instructions: 'instructions',
          isfeed: true,
          ismedication: true,
          quantity: 'quantity',
          brand: 'brand',
          type: 'type',
          id_: '_id');
      when(mockFarmRepository.create(farm)).thenAnswer((_) => Future.value());

      final farms = [
        Farm(
            userID: 'userID',
            farmName: 'farmName',
            expirationDate: 'expirationDate',
            itemName: 'itemName',
            dosage: 'dosage',
            instructions: 'instructions',
            isfeed: true,
            ismedication: true,
            quantity: 'quantity',
            brand: 'brand',
            type: 'type',
            id_: '_id'),
        Farm(
            userID: 'userID',
            farmName: 'farmName',
            expirationDate: 'expirationDate',
            itemName: 'itemName',
            dosage: 'dosage',
            instructions: 'instructions',
            isfeed: true,
            ismedication: true,
            quantity: 'quantity',
            brand: 'brand',
            type: 'type',
            id_: '_id'),
      ];
      when(mockFarmRepository.fetchAll())
          .thenAnswer((_) => Future.value(farms));

      final expectedStates = [
        FarmDataLoaded(farms),
      ];

      expectLater(farmBloc.stream, emitsInOrder(expectedStates));

      farmBloc.add(FarmCreate(farm));
    });

    test('FarmUpdate event should emit FarmDataLoaded state', () {
      final id = '1';
      final farm = Farm(
          userID: 'userID',
          farmName: 'farmName',
          expirationDate: 'expirationDate',
          itemName: 'itemName',
          dosage: 'dosage',
          instructions: 'instructions',
          isfeed: true,
          ismedication: true,
          quantity: 'quantity',
          brand: 'brand',
          type: 'type',
          id_: '_id');
      when(mockFarmRepository.update(id, farm))
          .thenAnswer((_) => Future.value());

      final farms = [
        Farm(
            userID: 'userID',
            farmName: 'farmName',
            expirationDate: 'expirationDate',
            itemName: 'itemName',
            dosage: 'dosage',
            instructions: 'instructions',
            isfeed: true,
            ismedication: true,
            quantity: 'quantity',
            brand: 'brand',
            type: 'type',
            id_: '_id'),
        Farm(
            userID: 'userID',
            farmName: 'farmName',
            expirationDate: 'expirationDate',
            itemName: 'itemName',
            dosage: 'dosage',
            instructions: 'instructions',
            isfeed: true,
            ismedication: true,
            quantity: 'quantity',
            brand: 'brand',
            type: 'type',
            id_: '_id'),
      ];
      when(mockFarmRepository.fetchAll())
          .thenAnswer((_) => Future.value(farms));

      final expectedStates = [
        FarmDataLoaded(farms),
      ];

      expectLater(farmBloc.stream, emitsInOrder(expectedStates));

      farmBloc.add(FarmUpdate(id: '', farm: null!));
    });

    test('FarmDelete event should emit FarmDataLoaded state', () {
      final id = '1';
      when(mockFarmRepository.delete(id)).thenAnswer((_) => Future.value());

      final farms = [
        Farm(
            userID: 'userID',
            farmName: 'farmName',
            expirationDate: 'expirationDate',
            itemName: 'itemName',
            dosage: 'dosage',
            instructions: 'instructions',
            isfeed: true,
            ismedication: true,
            quantity: 'quantity',
            brand: 'brand',
            type: 'type',
            id_: '_id'),
        Farm(
            userID: 'userID',
            farmName: 'farmName',
            expirationDate: 'expirationDate',
            itemName: 'itemName',
            dosage: 'dosage',
            instructions: 'instructions',
            isfeed: true,
            ismedication: true,
            quantity: 'quantity',
            brand: 'brand',
            type: 'type',
            id_: '_id'),
      ];
      when(mockFarmRepository.fetchAll())
          .thenAnswer((_) => Future.value(farms));

      final expectedStates = [
        FarmDataLoaded(farms),
      ];

      expectLater(farmBloc.stream, emitsInOrder(expectedStates));

      farmBloc.add(FarmDelete(id));
    });
  });
}
