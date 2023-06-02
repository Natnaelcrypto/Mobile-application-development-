import 'package:flutter_test/flutter_test.dart';
import 'package:pro/farm/farm_model/farm_model.dart';
import 'package:pro/farm/farm_bloc/farm_event.dart';

void main() {
  group('FarmEvent', () {
    test('FarmLoad event should have empty props', () {
      final event = FarmLoad();
      expect(event.props, isEmpty);
    });

    test('FarmCreate event should have the correct props', () {
      final farm = Farm(
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
      );
      final event = FarmCreate(farm);

      expect(event.props, [farm]);
    });

    test('FarmUpdate event should have the correct props', () {
      final farm = Farm(
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
      );
      final event = FarmUpdate(id: '1', farm: farm);

      expect(event.props, ['1', farm]);
    });

    test('FarmDelete event should have the correct props', () {
      final event = FarmDelete('1');

      expect(event.props, ['1']);
    });

    test('FarmDelete event should have stringify set to true', () {
      final event = FarmDelete('1');

      expect(event.stringify, true);
    });
  });
}
