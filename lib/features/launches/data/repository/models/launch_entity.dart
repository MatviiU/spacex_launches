import 'package:spacex_launches/features/launches/data/data_source/models/launches_dto.dart';

class LaunchEntity {
  LaunchEntity({
    required this.flightNumber,
    required this.missionName,
    required this.launchDateLocal,
    required this.launchSite,
    required this.flickrImages,
    this.wikipedia,
  });

  factory LaunchEntity.fromDto(LaunchesDTO dto) {
    final date = DateTime.parse(dto.launchDateLocal ?? '');
    return LaunchEntity(
      flightNumber: dto.flightNumber ?? 0,
      missionName: dto.missionName ?? '',
      launchDateLocal: date,
      launchSite: dto.launchSite?.siteNameLong ?? '',
      flickrImages: dto.links?.flickrImages ?? [],
      wikipedia: dto.links?.wikipedia ?? '',
    );
  }

  final int flightNumber;
  final String missionName;
  final DateTime launchDateLocal;
  final String launchSite;
  final List<String> flickrImages;
  final String? wikipedia;
}
