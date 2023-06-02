import 'package:equatable/equatable.dart';

import '../farm_model/farm_model.dart';


abstract class FarmState extends Equatable {
  const FarmState();

  @override
  List<Object> get props => [];
}

class FarmLoading extends FarmState {}
class FarmInitial extends FarmState {}

class FarmDataLoaded extends FarmState {
  final List<Farm> farms;

  const FarmDataLoaded([this.farms = const []]);

  @override
  List<Object> get props => [farms];
}

class FarmDataLoadingError extends FarmState {
  final Object error;

  const FarmDataLoadingError(this.error);
  @override
  List<Object> get props => [error];
}
