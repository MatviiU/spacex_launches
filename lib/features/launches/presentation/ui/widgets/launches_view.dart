import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spacex_launches/features/launches/presentation/cubit/launches_cubit.dart';
import 'package:spacex_launches/features/launches/presentation/ui/widgets/mission_item.dart';
import 'package:spacex_launches/features/launches/presentation/ui/widgets/slider.dart';

class LaunchesView extends StatelessWidget {
  const LaunchesView({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<LaunchesCubit>().state;
    if (state.launches.isEmpty) {
      return const Center(child: Text('No data'));
    }

    return CustomScrollView(
      slivers: [
        const SliverToBoxAdapter(child: SizedBox(height: 16)),
        SliverToBoxAdapter(
          child: SliderWidget(flickrImages: state.flickrImages),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 24)),
        if (state.selectedLaunch != null)
          SliverToBoxAdapter(child: MissionItem(launch: state.selectedLaunch!))
        else
          const SliverToBoxAdapter(
            child: Center(
              child: Text(
                'No mission selected',
                style: TextStyle(color: Colors.grey),
              ),
            ),
          ),
      ],
    );
  }
}
