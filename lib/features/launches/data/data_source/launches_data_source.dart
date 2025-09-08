import 'package:spacex_launches/core/network/spacex_api/spacex_api_base.dart';
import 'package:spacex_launches/features/launches/data/data_source/models/launches_dto.dart';

class LaunchesDataSource {
  LaunchesDataSource({required SpaceXApiBase spaceXApiBase})
    : _spaceXApiBase = spaceXApiBase;
  final SpaceXApiBase _spaceXApiBase;

  Future<List<LaunchesDTO>> getLaunches() {
    try {
      final launches = _spaceXApiBase.getLaunches();
      return launches;
    } on Exception catch (e) {
      throw Exception('(LaunchesDataSource): Error getting launches: $e');
    }
  }
}
