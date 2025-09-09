import 'package:equatable/equatable.dart';
import 'package:spacex_launches/features/launches/data/repository/models/launch_entity.dart';

enum LaunchesStatus {initial, loading, success, error}

class LaunchesState extends Equatable {
  const LaunchesState({
    this.launches = const [],
    this.selectedLaunch,
    this.flickrImages = const [],
    this.currentImageIndex = 0,
    this.status = LaunchesStatus.initial,
    this.errorMessage,
  });

  final List<LaunchEntity> launches;
  final LaunchEntity? selectedLaunch;
  final List<String> flickrImages;
  final int currentImageIndex;
  final LaunchesStatus status;
  final String? errorMessage;

  LaunchesState copyWith({
    List<LaunchEntity>? launches,
    LaunchEntity? selectedLaunch,
    List<String>? flickrImages,
    int? currentImageIndex,
    LaunchesStatus? status,
    String? errorMessage,
  }) {
    return LaunchesState(
      launches: launches ?? this.launches,
      selectedLaunch: selectedLaunch ?? this.selectedLaunch,
      flickrImages: flickrImages ?? this.flickrImages,
      currentImageIndex: currentImageIndex ?? this.currentImageIndex,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    launches,
    selectedLaunch,
    flickrImages,
    currentImageIndex,
    status,
    errorMessage,
  ];
}
