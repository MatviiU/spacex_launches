import 'package:spacex_launches/core/network/spacex_api/spacex_api_base.dart';
import 'package:spacex_launches/features/launches/data/data_source/models/launches_dto.dart';
import 'package:spacex_launches/features/launches/data/data_source/models/rockets_dto.dart';

class LaunchesDataSource {
  LaunchesDataSource({required SpaceXApiBase spaceXApiBase})
    : _spaceXApiBase = spaceXApiBase;
  final SpaceXApiBase _spaceXApiBase;

  Future<List<LaunchesDTO>> getLaunches() async{
    try {
      final launches = await _spaceXApiBase.getLaunches();
      return launches;
    } on Exception catch (e) {
      throw Exception('(LaunchesDataSource): Error getting launches: $e');
    }
  }

  Future<List<RocketsDTO>> getRockets() async{
    try {
      final rockets = await _spaceXApiBase.getRockets();
      return rockets;
    } on Exception catch (e) {
      throw Exception('(LaunchesDataSource): Error getting rockets: $e');
    }
  }

  Future<List<LaunchesDTO>> getLaunchesByRocketId(String rocketId) async{
    try {
      final launches = await _spaceXApiBase.getLaunchesByRocketId(rocketId);
      return launches;
    } on Exception catch (e) {
      throw Exception('(LaunchesDataSource): Error getting launches: $e');
    }
  }
}
