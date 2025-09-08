import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spacex_launches/features/launches/data/repository/launches_repository.dart';
import 'package:spacex_launches/features/launches/presentation/cubit/launches_state.dart';

class LaunchesCubit extends Cubit<LaunchesState> {
  LaunchesCubit({required LaunchesRepository launchesRepository})
    : _launchesRepository = launchesRepository,
      super(LaunchesInitial());

  final LaunchesRepository _launchesRepository;

  Future<void> getLaunches() async {
    try {
      emit(LaunchesLoading());
      final launches = await _launchesRepository.getLaunches();
      emit(LaunchesLoaded(launches));
    } on Exception catch (e) {
      emit(LaunchesError(e.toString()));
    }
  }
}
