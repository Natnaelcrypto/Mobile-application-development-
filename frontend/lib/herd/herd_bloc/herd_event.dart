import 'package:equatable/equatable.dart';

import '../model/herd_model.dart';

abstract class HerdEvent extends Equatable {
  const HerdEvent();
}

class HerdLoad extends HerdEvent {
  const HerdLoad();

  @override
  List<Object> get props => [];
}

class HerdLoadOne extends HerdEvent {
  final String id;
  const HerdLoadOne(this.id);

  @override
  List<Object> get props => [];
}

class HerdCreate extends HerdEvent {
  final Herd herd;

  const HerdCreate(this.herd);

  @override
  List<Object> get props => [herd];

  @override
  String toString() => 'Herd Created {Herd Id: $herd.id}';
}

class HerdReset extends HerdEvent {
  const HerdReset();

  @override
  List<Object> get props => [];
}

class HerdUpdate extends HerdEvent {
  final String id;
  final Herd herd;

  const HerdUpdate(this.id, this.herd);

  @override
  List<Object> get props => [id, herd];

  @override
  String toString() => 'Herd Updated {Herd Id: $herd.id}';
}

class HerdDelete extends HerdEvent {
  final String id;

  const HerdDelete(this.id);

  @override
  List<Object> get props => [id];

  @override
  toString() => 'Herd Deleted {Herd Id: $id}';

  @override
  bool? get stringify => true;
}
