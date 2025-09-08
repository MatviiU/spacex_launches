import 'package:spacex_launches/features/launches/data/data_source/models/launches_dto.dart';

abstract interface class SpaceXApiBase {
  Future<List<LaunchesDTO>> getLaunches();
}
