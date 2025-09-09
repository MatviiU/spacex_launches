import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spacex_launches/core/di/get_it.dart' as di;
import 'package:spacex_launches/features/launches/presentation/cubit/launches_cubit.dart';
import 'package:spacex_launches/features/launches/presentation/ui/screens/launches_screen.dart';

void main() {
  di.setupDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          di.getIt<LaunchesCubit>()..getRocketsAndInitialLaunches(),
      child: const MaterialApp(
        title: 'SpaceX launches',
        home: LaunchesScreen(),
      ),
    );
  }
}
