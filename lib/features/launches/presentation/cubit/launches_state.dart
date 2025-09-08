import 'package:equatable/equatable.dart';
import 'package:spacex_launches/features/launches/data/repository/models/launch_entity.dart';

abstract class LaunchesState extends Equatable {
  const LaunchesState();

  @override
  List<Object> get props => [];
}

class LaunchesInitial extends LaunchesState {}

class LaunchesLoading extends LaunchesState {}

class LaunchesLoaded extends LaunchesState {
  const LaunchesLoaded(this.launches);

  final List<LaunchEntity> launches;

  @override
  List<Object> get props => [launches];
}

class LaunchesError extends LaunchesState {
  const LaunchesError(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}
