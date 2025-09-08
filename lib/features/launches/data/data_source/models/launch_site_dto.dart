import 'package:json_annotation/json_annotation.dart';

part 'launch_site_dto.g.dart';

@JsonSerializable()
class LaunchSiteDTO {
  LaunchSiteDTO({this.siteNameLong});

  factory LaunchSiteDTO.fromJson(Map<String, dynamic> json) =>
      _$LaunchSiteDTOFromJson(json);

  @JsonKey(name: 'site_name_long')
  final String? siteNameLong;
}
