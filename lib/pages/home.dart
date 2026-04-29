import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Campus Events & Timetables',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: AppColors.white,
          ),
        ),
        backgroundColor: AppColors.blueMirage,
        elevation: 0,
        centerTitle: true,
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert, color: AppColors.white),
            onSelected: (value) => _openRoute(context, value),
            itemBuilder: (context) => const [
              PopupMenuItem(value: '/events', child: Text('Events')),
              PopupMenuItem(value: '/timetables', child: Text('Timetable')),
              PopupMenuItem(value: '/notifications', child: Text('Notifications')),
              PopupMenuItem(value: '/profile', child: Text('Profile')),
              PopupMenuItem(value: '/admin', child: Text('Admin')),
              PopupMenuItem(value: '/landing', child: Text('Landing')),
            ],
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Welcome Banner
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(color: AppColors.blueMirage),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Welcome Back!',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: AppColors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Stay updated with upcoming events and your timetable',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.amberSmoke,
                    ),
                  ),
                ],
              ),
            ),

            // Quick Action Buttons
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  Expanded(
                    child: _buildQuickActionButton(
                      context,
                      'Events',
                      Icons.calendar_today,
                      AppColors.blueMirage,
                      () => _navigateToSection(0),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildQuickActionButton(
                      context,
                      'Timetable',
                      Icons.schedule,
                      AppColors.amberSmoke,
                      () => _navigateToSection(1),
                    ),
                  ),
                ],
              ),
            ),

            // Featured Events Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Featured Events',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextButton(
                        onPressed: () => _navigateToSection(0),
                        child: const Text(
                          'View All',
                          style: TextStyle(color: AppColors.blueMirage),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  _buildEventCard(
                    title: 'Tech Talk 2026',
                    date: 'May 10, 2026',
                    time: '2:00 PM',
                    location: 'Auditorium A',
                    attendees: 150,
                  ),
                  const SizedBox(height: 12),
                  _buildEventCard(
                    title: 'Annual Sports Day',
                    date: 'May 15, 2026',
                    time: '9:00 AM',
                    location: 'Sports Complex',
                    attendees: 500,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Your Timetable Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Your Timetable',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextButton(
                        onPressed: () => _navigateToSection(1),
                        child: const Text(
                          'Full View',
                          style: TextStyle(color: AppColors.blueMirage),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  _buildTimetableCard(
                    day: 'Monday',
                    classes: [
                      {
                        'time': '9:00 - 10:30',
                        'subject': 'Mathematics',
                        'room': 'B101',
                      },
                      {
                        'time': '11:00 - 12:30',
                        'subject': 'Physics',
                        'room': 'Lab 2',
                      },
                      {
                        'time': '2:00 - 3:30',
                        'subject': 'Computer Science',
                        'room': 'C305',
                      },
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Notifications Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Recent Notifications',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  _buildNotificationItem(
                    'New event added: Workshop on AI',
                    'Yesterday',
                    Icons.notification_important,
                  ),
                  const SizedBox(height: 10),
                  _buildNotificationItem(
                    'Timetable updated for next week',
                    '2 days ago',
                    Icons.update,
                  ),
                  const SizedBox(height: 10),
                  _buildNotificationItem(
                    'Event reminder: Tech Talk today at 2 PM',
                    '3 days ago',
                    Icons.info,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickActionButton(
    BuildContext context,
    String label,
    IconData icon,
    Color color,
    VoidCallback onPressed,
  ) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: 0.3),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            Icon(icon, color: AppColors.white, size: 28),
            const SizedBox(height: 8),
            Text(
              label,
              style: const TextStyle(
                color: AppColors.white,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEventCard({
    required String title,
    required String date,
    required String time,
    required String location,
    required int attendees,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        border: Border.all(color: AppColors.dividerGray),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppColors.darkGray,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              const Icon(
                Icons.calendar_today,
                size: 16,
                color: AppColors.blueMirage,
              ),
              const SizedBox(width: 8),
              Text(date, style: const TextStyle(fontSize: 12)),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(
                Icons.access_time,
                size: 16,
                color: AppColors.blueMirage,
              ),
              const SizedBox(width: 8),
              Text(time, style: const TextStyle(fontSize: 12)),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(
                Icons.location_on,
                size: 16,
                color: AppColors.blueMirage,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(location, style: const TextStyle(fontSize: 12)),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: AppColors.amberSmoke,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              '$attendees attending',
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: AppColors.darkGray,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimetableCard({
    required String day,
    required List<Map<String, String>> classes,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.lightGray,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.dividerGray),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            day,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppColors.blueMirage,
            ),
          ),
          const SizedBox(height: 12),
          ...classes.map((classItem) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppColors.blueMirage, width: 4),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          classItem['subject']!,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          classItem['time']!,
                          style: const TextStyle(
                            fontSize: 12,
                            color: AppColors.darkGray,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.amberSmoke,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        classItem['room']!,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildNotificationItem(String title, String time, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.lightGray,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(icon, color: AppColors.blueMirage, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  time,
                  style: const TextStyle(
                    fontSize: 11,
                    color: AppColors.darkGray,
                  ),
                ),
              ],
            ),
          ),
          const Icon(
            Icons.chevron_right,
            color: AppColors.blueMirage,
            size: 20,
          ),
        ],
      ),
    );
  }

  void _navigateToSection(int index) {
    Navigator.of(context).pushNamed(index == 0 ? '/events' : '/timetables');
  }

  void _openRoute(BuildContext context, String routeName) {
    Navigator.of(context).pushNamed(routeName);
  }
}
