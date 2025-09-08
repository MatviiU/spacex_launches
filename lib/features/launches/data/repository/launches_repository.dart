import 'package:spacex_launches/features/launches/data/data_source/launches_data_source.dart';
import 'package:spacex_launches/features/launches/data/repository/models/launch_entity.dart';

class LaunchesRepository {
  LaunchesRepository({required this.launchesDataSource});

  final LaunchesDataSource launchesDataSource;

  Future<List<LaunchEntity>> getLaunches() async {
    try {
      final launches = await launchesDataSource.getLaunches();
      return launches.map(LaunchEntity.fromDto).toList();
    } on Exception catch (e) {
      throw Exception('(LaunchesRepository): Error getting launches: $e');
    }
  }
}
