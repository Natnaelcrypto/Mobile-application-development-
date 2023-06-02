import 'package:flutter_test/flutter_test.dart';
import 'package:pro/herd/model/herd_model.dart';
import 'package:pro/herd/herd_bloc/herd_state.dart';

void main() {
  group('HerdState', () {
    test('HerdLoading should have empty props', () {
      expect(HerdLoading().props, []);
    });

    test('HerdDataLoaded should have herds in props', () {
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
      expect(HerdDataLoaded(herds).props, [herds]);
    });

    test('HerdDataLoadedone should have herd in props', () {
      final herd = Herd(
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
      );
      expect(HerdDataLoadedone(herd).props, [herd]);
    });

    test('HerdDataLoadingError should have error in props', () {
      final error = Exception('Error loading data');
      expect(HerdDataLoadingError(error).props, [error]);
    });
  });
}
