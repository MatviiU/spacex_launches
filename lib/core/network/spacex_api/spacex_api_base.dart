import 'package:spacex_launches/features/launches/data/data_source/models/launches_dto.dart';
import 'package:spacex_launches/features/launches/data/data_source/models/rockets_dto.dart';

abstract interface class SpaceXApiBase {
  Future<List<LaunchesDTO>> getLaunches();
  Future<List<RocketsDTO>> getRockets();
  Future<List<LaunchesDTO>> getLaunchesByRocketId(String rocketId);
}
