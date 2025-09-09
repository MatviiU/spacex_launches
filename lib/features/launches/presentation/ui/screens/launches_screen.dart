import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spacex_launches/features/launches/presentation/cubit/launches_cubit.dart';
import 'package:spacex_launches/features/launches/presentation/cubit/launches_state.dart';
import 'package:spacex_launches/features/launches/presentation/ui/widgets/launches_view.dart';

class LaunchesScreen extends StatelessWidget {
  const LaunchesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        elevation: 0,
        title: const Text(
          'SpaceX Launches',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
            fontSize: 24,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      body: BlocBuilder<LaunchesCubit, LaunchesState>(
        builder: (context, state) {
          return switch(state.status){
            LaunchesStatus.initial || LaunchesStatus.loading =>
            const Center(child: CircularProgressIndicator()),
            LaunchesStatus.success => const LaunchesView(),
            LaunchesStatus.error => Center(child: Text(state.errorMessage!)),
          };
        },
      ),
    );
  }
}
