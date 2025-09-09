import 'package:flutter/material.dart';
import 'package:spacex_launches/features/launches/data/repository/models/launch_entity.dart';
import 'package:spacex_launches/features/launches/presentation/ui/widgets/mission_item.dart';

class MissionList extends StatelessWidget {
  const MissionList({required this.launches, super.key});

  final List<LaunchEntity> launches;

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate((context, index) {
        final launch = launches[index];
        return MissionItem(launch: launch);
      }, childCount: launches.length),
    );
  }
}
