import 'package:spacex_launches/features/launches/data/data_source/models/rockets_dto.dart';

class RocketEntity {
  const RocketEntity({
    required this.rocketId,
    required this.flickrImages,
    required this.rocketName,
  });

  factory RocketEntity.fromDto(RocketsDTO dto) {
    return RocketEntity(
      rocketId: dto.rocketId ?? '',
      flickrImages: dto.flickrImages ?? [],
      rocketName: dto.rocketName ?? '',
    );
  }

  final String rocketId;
  final List<String> flickrImages;
  final String rocketName;
}
