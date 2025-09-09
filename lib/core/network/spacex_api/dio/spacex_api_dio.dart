import 'package:dio/dio.dart';
import 'package:spacex_launches/core/network/spacex_api/spacex_api_base.dart';
import 'package:spacex_launches/features/launches/data/data_source/models/launches_dto.dart';
import 'package:spacex_launches/features/launches/data/data_source/models/rockets_dto.dart';

class SpaceXApiDio implements SpaceXApiBase {
  SpaceXApiDio(this.dio);

  final Dio dio;

  @override
  Future<List<LaunchesDTO>> getLaunches() async {
    try {
      final response = await dio.get<List<dynamic>>('/launches');

      final data = response.data!;

      if (data.isEmpty) {
        throw Exception('(SpaceXApiDio): No data');
      }

      final launches = data
          .map((launch) => LaunchesDTO.fromJson(launch as Map<String, dynamic>))
          .toList();
      return launches;
    } on Exception catch (e) {
      throw Exception('(SpaceXApiDio): Error getting launches: $e');
    }
  }

  @override
  Future<List<RocketsDTO>> getRockets() async {
    try {
      final response = await dio.get<List<dynamic>>('/rockets');
      final data = response.data!;

      if (data.isEmpty) {
        return [];
      }

      final rockets = data
          .map((rocket) => RocketsDTO.fromJson(rocket as Map<String, dynamic>))
          .toList();
      return rockets;
    } on Exception catch (e) {
      throw Exception('(SpaceXApiDio): Error getting rockets: $e');
    }
  }

  @override
  Future<List<LaunchesDTO>> getLaunchesByRocketId(String rocketId) async {
    try {
      final response = await dio.get<List<dynamic>>(
        '/launches',
        queryParameters: {'rocket_id': rocketId},
      );
      final data = response.data!;
      if (data.isEmpty) {
        return [];
      }
      final launches = data
          .map((launch) => LaunchesDTO.fromJson(launch as Map<String, dynamic>))
          .toList();
      return launches;
    } on Exception catch (e) {
      throw Exception('(SpaceXApiDio): Error getting launches: $e');
    }
  }
}
