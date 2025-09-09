import 'package:json_annotation/json_annotation.dart';

part 'rockets_dto.g.dart';

@JsonSerializable()
class RocketsDTO {
  RocketsDTO({this.rocketId, this.flickrImages, this.rocketName});

  factory RocketsDTO.fromJson(Map<String, dynamic> json) =>
      _$RocketsDTOFromJson(json);

  @JsonKey(name: 'rocket_id')
  final String? rocketId;
  @JsonKey(name: 'flickr_images')
  final List<String>? flickrImages;
  @JsonKey(name: 'rocket_name')
  final String? rocketName;
}
