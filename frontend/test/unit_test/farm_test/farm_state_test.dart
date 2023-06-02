import 'package:flutter_test/flutter_test.dart';
import 'package:pro/farm/farm_model/farm_model.dart';
import 'package:pro/farm/farm_bloc/farm_state.dart';

void main() {
  group('FarmState', () {
    test('FarmLoading state should have empty props', () {
      final state = FarmLoading();
      expect(state.props, isEmpty);
    });

    test('FarmDataLoaded state should have the correct props', () {
      final farms = [
        Farm(
          userID: 'user1',
          farmName: 'Farm A',
          id_: '1',
          expirationDate: '2023-01-01',
          itemName: 'Item A',
          dosage: '2 tablets',
          instructions: 'Take with water',
          isfeed: false,
          ismedication: true,
          quantity: '10',
          brand: 'Brand A',
          type: 'Type A',
        ),
        Farm(
          userID: 'user1',
          farmName: 'Farm B',
          id_: '2',
          expirationDate: '2023-02-01',
          itemName: 'Item B',
          dosage: '1 tablet',
          instructions: 'Take after meals',
          isfeed: true,
          ismedication: false,
          quantity: '20',
          brand: 'Brand B',
          type: 'Type B',
        ),
      ];
      final state = FarmDataLoaded(farms);

      expect(state.props, [farms]);
    });

    test('FarmDataLoadingError state should have the correct props', () {
      final error = 'Failed to load farms';
      final state = FarmDataLoadingError(error);

      expect(state.props, [error]);
    });
  });
}
