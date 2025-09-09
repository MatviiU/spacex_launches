import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:spacex_launches/core/network/spacex_api/dio/spacex_api_dio.dart';
import 'package:spacex_launches/core/network/spacex_api/spacex_api_base.dart';
import 'package:spacex_launches/features/launches/data/data_source/launches_data_source.dart';
import 'package:spacex_launches/features/launches/data/repository/launches_repository.dart';
import 'package:spacex_launches/features/launches/presentation/cubit/launches_cubit.dart';

final getIt = GetIt.instance;

void setupDependencies() {
  getIt
    ..registerSingleton<Dio>(
      Dio(BaseOptions(baseUrl: 'https://api.spacexdata.com/v3')),
    )
    ..registerLazySingleton<SpaceXApiBase>(() => SpaceXApiDio(getIt<Dio>()))
    ..registerLazySingleton<LaunchesDataSource>(
      () => LaunchesDataSource(spaceXApiBase: getIt<SpaceXApiBase>()),
    )
    ..registerLazySingleton<LaunchesRepository>(
      () =>
          LaunchesRepository(launchesDataSource: getIt<LaunchesDataSource>()),
    )
    ..registerFactory<LaunchesCubit>(
      () => LaunchesCubit(launchesRepository: getIt<LaunchesRepository>()),
    );
}
