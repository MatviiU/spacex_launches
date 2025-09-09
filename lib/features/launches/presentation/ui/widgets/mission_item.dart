import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:spacex_launches/features/launches/data/repository/models/launch_entity.dart';
import 'package:url_launcher/url_launcher.dart';

class MissionItem extends StatelessWidget {
  const MissionItem({required this.launch, super.key});

  final LaunchEntity launch;

  Future<void> _launchWikipedia(String? urlFromEntity) async {
    if (urlFromEntity != null && urlFromEntity.isNotEmpty) {
      final url = Uri.parse(urlFromEntity);
      if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
        throw Exception('Could not launch $url');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final dateFormater = DateFormat('dd/MM/yyyy');
    final timeFormater = DateFormat('hh:mm a');
    final hasWikipediaUrl =
        launch.wikipedia != null && launch.wikipedia!.isNotEmpty;
    return InkWell(
      onTap: hasWikipediaUrl ? () => _launchWikipedia(launch.wikipedia) : null,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFF1C1C1C),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          spacing: 20,
          children: [
            Column(
              spacing: 4,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  dateFormater.format(launch.launchDateLocal),
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                    color: Color(0xFFBAFC54),
                  ),
                ),
                Text(
                  timeFormater.format(launch.launchDateLocal),
                  style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                    color: Color(0xFFC5C5C5),
                  ),
                ),
              ],
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    launch.missionName,
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 20,
                      color: Colors.white,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    launch.launchSite,
                    style: const TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      color: Color(0xFFA5A5A5),
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
