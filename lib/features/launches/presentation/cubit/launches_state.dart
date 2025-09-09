import 'package:equatable/equatable.dart';
import 'package:spacex_launches/features/launches/data/repository/models/launch_entity.dart';
import 'package:spacex_launches/features/launches/data/repository/models/rocket_entity.dart';

enum DataStatus {initial, loading, success, error}

class LaunchesState extends Equatable {
  const LaunchesState({
    this.launches = const [],
    this.rockets = const [],
    this.selectedLaunch,
    this.flickrImages = const [],
    this.currentImageIndex = 0,
    this.launchesStatus = DataStatus.initial,
    this.rocketsStatus = DataStatus.initial,
    this.errorMessage,
  });

  final List<LaunchEntity> launches;
  final List<RocketEntity> rockets;
  final LaunchEntity? selectedLaunch;
  final List<String> flickrImages;
  final int currentImageIndex;
  final DataStatus launchesStatus;
  final DataStatus rocketsStatus;
  final String? errorMessage;

  LaunchesState copyWith({
    List<LaunchEntity>? launches,
    List<RocketEntity>? rockets,
    LaunchEntity? selectedLaunch,
    List<String>? flickrImages,
    int? currentImageIndex,
    DataStatus? launchesStatus,
    DataStatus? rocketsStatus,
    String? errorMessage,
  }) {
    return LaunchesState(
      launches: launches ?? this.launches,
      rockets: rockets ?? this.rockets,
      selectedLaunch: selectedLaunch ?? this.selectedLaunch,
      flickrImages: flickrImages ?? this.flickrImages,
      currentImageIndex: currentImageIndex ?? this.currentImageIndex,
      launchesStatus: launchesStatus ?? this.launchesStatus,
      rocketsStatus: rocketsStatus ?? this.rocketsStatus,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    launches,
    rockets,
    selectedLaunch,
    flickrImages,
    currentImageIndex,
    launchesStatus,
    rocketsStatus,
    errorMessage,
  ];
}
