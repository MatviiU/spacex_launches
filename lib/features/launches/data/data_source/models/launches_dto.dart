import 'package:json_annotation/json_annotation.dart';
import 'package:spacex_launches/features/launches/data/data_source/models/launch_site_dto.dart';
import 'package:spacex_launches/features/launches/data/data_source/models/links_dto.dart';

part 'launches_dto.g.dart';

@JsonSerializable()
class LaunchesDTO {
  LaunchesDTO({
    this.flightNumber,
    this.missionName,
    this.launchDateLocal,
    this.launchSite,
    this.links,
  });

  factory LaunchesDTO.fromJson(Map<String, dynamic> json) =>
      _$LaunchesDTOFromJson(json);

  @JsonKey(name: 'flight_number')
  final int? flightNumber;
  @JsonKey(name: 'mission_name')
  final String? missionName;
  @JsonKey(name: 'launch_date_local')
  final String? launchDateLocal;
  @JsonKey(name: 'launch_site')
  final LaunchSiteDTO? launchSite;
  @JsonKey(name: 'links')
  final LinksDTO? links;
}
