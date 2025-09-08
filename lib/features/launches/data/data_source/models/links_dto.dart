import 'package:json_annotation/json_annotation.dart';

part 'links_dto.g.dart';

@JsonSerializable()
class LinksDTO {
  const LinksDTO({this.flickrImages});

  factory LinksDTO.fromJson(Map<String, dynamic> json) =>
      _$LinksDTOFromJson(json);

  @JsonKey(name: 'flickr_images')
  final List<String>? flickrImages;
}
