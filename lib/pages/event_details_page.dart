import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class EventDetailsPage extends StatelessWidget {
  final Map<String, dynamic> event;

  const EventDetailsPage({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Event Details"),
        backgroundColor: AppColors.blueMirage,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              event['title'],
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),

            Text("📅 ${event['date']}"),
            Text("⏰ ${event['time']}"),
            Text("📍 ${event['location']}"),
            Text("👤 ${event['organizer']}"),
            Text("👥 ${event['attendees']} attendees"),

            const SizedBox(height: 16),
            const Divider(),

            const SizedBox(height: 8),
            Text(event['description']),
          ],
        ),
      ),
    );
  }
}