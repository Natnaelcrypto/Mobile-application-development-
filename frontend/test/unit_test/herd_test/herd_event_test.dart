import 'package:flutter_test/flutter_test.dart';
import 'package:pro/herd/model/herd_model.dart';
import 'package:pro/herd/herd_bloc/herd_event.dart';

void main() {
  group('HerdEvent', () {
    test('HerdLoad should have empty props', () {
      expect(HerdLoad().props, []);
    });

    test('HerdLoadOne should have id in props', () {
      const id = '1';
      expect(HerdLoadOne(id).props, [id]);
    });

    test('HerdCreate should have herd in props', () {
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
      expect(HerdCreate(herd).props, [herd]);
    });

    test('HerdUpdate should have id and herd in props', () {
      const id = '1';
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
      expect(HerdUpdate(id, herd).props, [id, herd]);
    });

    test('HerdDelete should have id in props', () {
      const id = '1';
      expect(HerdDelete(id).props, [id]);
    });

    // Additional tests for toString and stringify can be added here
  });
}
