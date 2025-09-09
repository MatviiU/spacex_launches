import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spacex_launches/features/launches/presentation/cubit/launches_cubit.dart';
import 'package:spacex_launches/features/launches/presentation/cubit/launches_state.dart';
import 'package:spacex_launches/features/launches/presentation/ui/widgets/mission_list.dart';
import 'package:spacex_launches/features/launches/presentation/ui/widgets/slider.dart';

class LaunchesView extends StatelessWidget {
  const LaunchesView({super.key});

  @override
  Widget build(BuildContext context) {
    final rockets = context.select(
      (LaunchesCubit cubit) => cubit.state.rockets,
    );

    if (rockets.isEmpty) {
      return const Center(child: Text('No data'));
    }

    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(child: SliderWidget(rockets: rockets)),
        const SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Missions',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
          ),
        ),

        BlocBuilder<LaunchesCubit, LaunchesState>(
          builder: (context, state) {
            return switch (state.launchesStatus) {
              DataStatus.loading ||
              DataStatus.initial => const SliverFillRemaining(
                child: Center(child: CircularProgressIndicator()),
              ),
              DataStatus.error => SliverFillRemaining(
                child: Center(
                  child: Text(
                    state.errorMessage ??
                        'Error getting launches ${state.errorMessage}',
                  ),
                ),
              ),
              DataStatus.success =>
                state.launches.isEmpty
                    ? const SliverFillRemaining(
                        hasScrollBody: false,
                        child: Center(
                          child: Text(
                            'Coming Soon...',
                            style: TextStyle(color: Colors.grey, fontSize: 24),
                          ),
                        ),
                      )
                    : MissionList(launches: state.launches),
            };
          },
        ),
      ],
    );
  }
}
