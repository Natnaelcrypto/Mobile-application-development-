import 'package:equatable/equatable.dart';

import '../model/herd_model.dart';

abstract class HerdState extends Equatable {
  const HerdState();

  @override
  List<Object> get props => [];
}

class HerdLoading extends HerdState {}
class HerdInitial extends HerdState {}

class HerdDataLoaded extends HerdState {
  final Iterable<Herd> herds;
  const HerdDataLoaded([this.herds = const []]);
  @override
  List<Object> get props => [herds];
}

class HerdDataLoadedone extends HerdState {
  final Herd herds;
  const HerdDataLoadedone(this.herds);
  @override
  List<Object> get props => [herds];
}

class HerdDataLoadingError extends HerdState {
  final Object error;

  const HerdDataLoadingError(this.error);
  @override
  List<Object> get props => [error];
}
