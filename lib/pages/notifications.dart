import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../main.dart';
import '../widgets/app_drawer.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  final List<Map<String, dynamic>> _notifications = [
    {
      'title': 'New Event: AI Workshop',
      'message': 'Join us for a hands-on workshop on Artificial Intelligence',
      'time': '2 hours ago',
      'icon': Icons.school_rounded,
      'type': 'event',
      'read': false,
    },
    {
      'title': 'Timetable Updated',
      'message': 'Your class schedule has been updated for next week',
      'time': '5 hours ago',
      'icon': Icons.schedule_rounded,
      'type': 'schedule',
      'read': false,
    },
    {
      'title': 'Event Reminder: Tech Talk',
      'message': 'Tech Talk 2026 starts in 2 hours at Auditorium A',
      'time': '1 day ago',
      'icon': Icons.notifications_active_rounded,
      'type': 'reminder',
      'read': true,
    },
    {
      'title': 'Career Fair Registration',
      'message': 'Career Fair 2026 registration is now open',
      'time': '2 days ago',
      'icon': Icons.work_rounded,
      'type': 'career',
      'read': true,
    },
    {
      'title': 'Club Meeting Announcement',
      'message': 'Tech Club meeting rescheduled to Friday at 3 PM',
      'time': '3 days ago',
      'icon': Icons.groups_rounded,
      'type': 'club',
      'read': true,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Notifications',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: AppColors.white,
          ),
        ),
        backgroundColor: AppColors.blueMirage,
        elevation: 0,
        centerTitle: true,
      ),
      drawer: AppDrawer(currentRoute: notificationsRoute),
      body: Column(
        children: [
          // Header
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              color: AppColors.blueMirage,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Stay Updated',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: AppColors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Never miss important events and updates',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.amberSmoke,
                  ),
                ),
              ],
            ),
          ),
          // Notifications List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _notifications.length,
              itemBuilder: (context, index) {
                final notification = _notifications[index];
                return _buildNotificationCard(notification);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationCard(Map<String, dynamic> notification) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: notification['read'] ? AppColors.lightGray : AppColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: notification['read']
              ? AppColors.dividerGray
              : AppColors.blueMirage,
          width: notification['read'] ? 1 : 2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: AppColors.blueMirage.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Icon(
                notification['icon'] as IconData,
                color: AppColors.blueMirage,
                size: 24,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        notification['title'] as String,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppColors.darkGray,
                        ),
                      ),
                    ),
                    if (!notification['read'])
                      Container(
                        width: 10,
                        height: 10,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.blueMirage,
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  notification['message'] as String,
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppColors.darkGray,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                Text(
                  notification['time'] as String,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.darkGray,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
