import 'package:dio/dio.dart';
import 'package:spacex_launches/core/network/spacex_api/spacex_api_base.dart';
import 'package:spacex_launches/features/launches/data/data_source/models/launches_dto.dart';

class SpaceXApiDio implements SpaceXApiBase {
  SpaceXApiDio(this.dio);

  final Dio dio;

  @override
  Future<List<LaunchesDTO>> getLaunches() async {
    try {
      final response = await dio.get<List<dynamic>>(
        '/launches',
      );

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
}
