import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spacex_launches/features/launches/data/repository/launches_repository.dart';
import 'package:spacex_launches/features/launches/data/repository/models/launch_entity.dart';
import 'package:spacex_launches/features/launches/presentation/cubit/launches_state.dart';

class LaunchesCubit extends Cubit<LaunchesState> {
  LaunchesCubit({required LaunchesRepository launchesRepository})
    : _launchesRepository = launchesRepository,
      super(const LaunchesState());

  final LaunchesRepository _launchesRepository;
  final carouselController = CarouselSliderController();
  final scrollController = ScrollController();

  final _imageIndexToLaunchMap = <int, LaunchEntity>{};

  void prepareLaunches(List<LaunchEntity> launches) {
    final allImages = <String>[];
    _imageIndexToLaunchMap.clear();
    var imageIndex = 0;

    for (final launch in launches) {
      for (final image in launch.flickrImages) {
        allImages.add(image);
        _imageIndexToLaunchMap[imageIndex] = launch;
        imageIndex++;
      }
    }

    final firstLaunchWithImages = launches.firstWhere(
      (launch) => launch.flickrImages.isNotEmpty,
      orElse: () => launches.first,
    );

    emit(
      state.copyWith(
        launches: launches,
        flickrImages: allImages,
        selectedLaunch: firstLaunchWithImages,
        currentImageIndex: 0,
      ),
    );
  }

  Future<void> getLaunches() async {
    try {
      emit(state.copyWith(status: LaunchesStatus.loading));
      final launches = await _launchesRepository.getLaunches();
      if (launches.isEmpty) {
        emit(
          state.copyWith(
            launches: [],
            status: LaunchesStatus.error,
            errorMessage: 'No launches found',
          ),
        );
        return;
      }
      final allImages = <String>[];
      _imageIndexToLaunchMap.clear();
      var imageIndex = 0;

      for (final launch in launches) {
        if (launch.flickrImages.isNotEmpty) {
          for (final image in launch.flickrImages) {
            allImages.add(image);
            _imageIndexToLaunchMap[imageIndex] = launch;
            imageIndex++;
          }
        }
      }
      emit(
        state.copyWith(
          launches: launches,
          flickrImages: allImages,
          status: LaunchesStatus.success,
          selectedLaunch: allImages.isNotEmpty
              ? _imageIndexToLaunchMap[0]
              : null,
        ),
      );
    } on Exception catch (e) {
      emit(
        state.copyWith(
          errorMessage: e.toString(),
          status: LaunchesStatus.error,
        ),
      );
    }
  }

  void onImageChanged(int newImageIndex) {
    final correspondingLaunch = _imageIndexToLaunchMap[newImageIndex];
    if (correspondingLaunch != null) {
      emit(
        state.copyWith(
          selectedLaunch: correspondingLaunch,
          currentImageIndex: newImageIndex,
        ),
      );
    }
  }

  @override
  Future<void> close() {
    scrollController.dispose();
    return super.close();
  }
}
