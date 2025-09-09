import 'package:spacex_launches/features/launches/data/data_source/launches_data_source.dart';
import 'package:spacex_launches/features/launches/data/repository/models/launch_entity.dart';
import 'package:spacex_launches/features/launches/data/repository/models/rocket_entity.dart';

class LaunchesRepository {
  LaunchesRepository({required this.launchesDataSource});

  final LaunchesDataSource launchesDataSource;

  Future<List<LaunchEntity>> getLaunches() async {
    try {
      final launches = await launchesDataSource.getLaunches();
      final entities = launches.map(LaunchEntity.fromDto).toList();
      final filteredEntities = entities
          .where((entity) => entity.flickrImages.isNotEmpty)
          .toList();
      return filteredEntities;
    } on Exception catch (e) {
      throw Exception('(LaunchesRepository): Error getting launches: $e');
    }
  }

  Future<List<RocketEntity>> getRockets() async {
    try {
      final rockets = await launchesDataSource.getRockets();
      final entities = rockets.map(RocketEntity.fromDto).toList();
      final filteredEntities = entities
          .where((entity) => entity.flickrImages.isNotEmpty)
          .toList();
      return filteredEntities;
    } on Exception catch (e) {
      throw Exception('(LaunchesRepository): Error getting rockets: $e');
    }
  }

  Future<List<LaunchEntity>> getLaunchesByRocketId(String rocketId) async {
    try {
      final launches = await launchesDataSource.getLaunchesByRocketId(rocketId);
      final entities = launches.map(LaunchEntity.fromDto).toList();
      return entities;
    } on Exception catch (e) {
      throw Exception('(LaunchesRepository): Error getting launches: $e');
    }
  }
}
