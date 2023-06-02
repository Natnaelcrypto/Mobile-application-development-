import 'package:equatable/equatable.dart';

import '../farm_model/farm_model.dart';


abstract class FarmEvent extends Equatable {
  const FarmEvent();
}
class FarmReset extends FarmEvent {
  const FarmReset();
  @override
  List<Object> get props => [];
}
class FarmLoad extends FarmEvent {
  const FarmLoad();

  @override
  List<Object> get props => [];
}

class FarmCreate extends FarmEvent {
  final Farm farm;

  const FarmCreate(this.farm);

  @override
  List<Object> get props => [farm];

  @override
  String toString() => 'Farm Created {Farm Id: ${farm.id_}}';
}

class FarmUpdate extends FarmEvent {
  final String id;
  final Farm farm;

  const FarmUpdate({required this.id, required this.farm});

  @override
  List<Object> get props => [id, farm];

  @override
  String toString() => 'Farm Updated {Farm Id: ${farm.id_}}';
}

class FarmDelete extends FarmEvent {
  final String id;

  const FarmDelete(this.id);

  @override
  List<Object> get props => [id];

  @override
  toString() => 'Farm Deleted {Farm Id: $id}';

  @override
  bool? get stringify => true;
}
