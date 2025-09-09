import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spacex_launches/features/launches/data/repository/launches_repository.dart';
import 'package:spacex_launches/features/launches/presentation/cubit/launches_state.dart';

class LaunchesCubit extends Cubit<LaunchesState> {
  LaunchesCubit({required LaunchesRepository launchesRepository})
    : _launchesRepository = launchesRepository,
      super(const LaunchesState());

  final LaunchesRepository _launchesRepository;
  final carouselController = CarouselSliderController();

  Future<void> getRocketsAndInitialLaunches() async {
    try {
      emit(state.copyWith(rocketsStatus: DataStatus.loading));
      final rockets = await _launchesRepository.getRockets();
      if (rockets.isEmpty) {
        emit(
          state.copyWith(
            rocketsStatus: DataStatus.error,
            errorMessage: 'No rockets found',
          ),
        );
        return;
      }
      emit(state.copyWith(rockets: rockets, rocketsStatus: DataStatus.success));

      await getLaunchesByRocketId(rockets.first.rocketId);
    } on Exception catch (e) {
      emit(
        state.copyWith(
          rocketsStatus: DataStatus.error,
          errorMessage: 'Error getting rockets: $e',
        ),
      );
    }
  }

  Future<void> getLaunchesByRocketId(String rocketId) async {
    try {
      emit(state.copyWith(launchesStatus: DataStatus.loading));
      final launches = await _launchesRepository.getLaunchesByRocketId(
        rocketId,
      );
      emit(
        state.copyWith(launches: launches, launchesStatus: DataStatus.success),
      );
    } on Exception catch (e) {
      emit(
        state.copyWith(
          launchesStatus: DataStatus.error,
          errorMessage: 'Error getting launches: $e',
        ),
      );
    }
  }

  Future<void> onRocketSelected(int index) async {
    if (state.currentImageIndex == index) return;
    emit(state.copyWith(currentImageIndex: index));
    final rocketId = state.rockets[index].rocketId;
    await getLaunchesByRocketId(rocketId);
  }
}
