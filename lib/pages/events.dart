import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class EventsPage extends StatefulWidget {
  const EventsPage({super.key});

  @override
  State<EventsPage> createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage> {
  String _selectedFilter = 'All';
  final List<String> _filters = ['All', 'Today', 'This Week', 'This Month'];

  final List<Map<String, dynamic>> _events = [
    {
      'title': 'Tech Talk 2026: AI & Machine Learning',
      'date': 'May 10, 2026',
      'time': '2:00 PM - 4:00 PM',
      'location': 'Auditorium A',
      'attendees': 150,
      'category': 'Academic',
      'description':
          'Join us for an insightful discussion on the latest developments in AI and machine learning.',
      'organizer': 'Computer Science Department',
    },
    {
      'title': 'Annual Sports Day',
      'date': 'May 15, 2026',
      'time': '9:00 AM - 5:00 PM',
      'location': 'Sports Complex',
      'attendees': 500,
      'category': 'Sports',
      'description':
          'Celebrate athletic excellence with various sports competitions and activities.',
      'organizer': 'Sports Committee',
    },
    {
      'title': 'Career Fair 2026',
      'date': 'May 20, 2026',
      'time': '10:00 AM - 3:00 PM',
      'location': 'Main Hall',
      'attendees': 300,
      'category': 'Career',
      'description':
          'Connect with top companies and explore internship and job opportunities.',
      'organizer': 'Career Services',
    },
    {
      'title': 'Cultural Festival',
      'date': 'May 25, 2026',
      'time': '6:00 PM - 10:00 PM',
      'location': 'Campus Grounds',
      'attendees': 800,
      'category': 'Cultural',
      'description':
          'Experience diverse cultures through music, dance, and traditional performances.',
      'organizer': 'Cultural Committee',
    },
    {
      'title': 'Workshop: Mobile App Development',
      'date': 'May 28, 2026',
      'time': '1:00 PM - 5:00 PM',
      'location': 'Computer Lab 1',
      'attendees': 50,
      'category': 'Workshop',
      'description':
          'Hands-on workshop covering Flutter and cross-platform mobile development.',
      'organizer': 'Tech Club',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Events',
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
          IconButton(
            icon: const Icon(Icons.search, color: AppColors.white),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Search functionality coming soon!'),
                ),
              );
            },
          ),
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert, color: AppColors.white),
            onSelected: (value) => _openRoute(value),
            itemBuilder: (context) => const [
              PopupMenuItem(value: '/home', child: Text('Home')),
              PopupMenuItem(value: '/timetables', child: Text('Timetable')),
              PopupMenuItem(value: '/notifications', child: Text('Notifications')),
              PopupMenuItem(value: '/profile', child: Text('Profile')),
              PopupMenuItem(value: '/admin', child: Text('Admin')),
              PopupMenuItem(value: '/landing', child: Text('Landing')),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              color: AppColors.blueMirage,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Discover Events',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: AppColors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Stay updated with campus activities and events',
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(color: AppColors.amberSmoke),
                ),
                const SizedBox(height: 16),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: _filters.map((filter) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: FilterChip(
                          label: Text(filter),
                          selected: _selectedFilter == filter,
                          onSelected: (selected) {
                            setState(() {
                              _selectedFilter = filter;
                            });
                          },
                          backgroundColor: AppColors.white.withValues(alpha: 0.2),
                          selectedColor: AppColors.amberSmoke,
                          checkmarkColor: AppColors.blueMirage,
                          labelStyle: TextStyle(
                            color: _selectedFilter == filter
                                ? AppColors.blueMirage
                                : AppColors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _events.length,
              itemBuilder: (context, index) {
                final event = _events[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: _buildEventCard(event),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Add event functionality coming soon!'),
            ),
          );
        },
        backgroundColor: AppColors.blueMirage,
        child: const Icon(Icons.add, color: AppColors.white),
      ),
    );
  }

  Widget _buildEventCard(Map<String, dynamic> event) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: () => _showEventDetails(event),
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      event['title'],
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.darkGray,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: _getCategoryColor(event['category']),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      event['category'],
                      style: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: AppColors.white,
                      ),
                    ),
                  ),
                ],
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
                  Text(
                    event['date'],
                    style: const TextStyle(
                      fontSize: 14,
                      color: AppColors.darkGray,
                    ),
                  ),
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
                  Text(
                    event['time'],
                    style: const TextStyle(
                      fontSize: 14,
                      color: AppColors.darkGray,
                    ),
                  ),
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
                  Text(
                    event['location'],
                    style: const TextStyle(
                      fontSize: 14,
                      color: AppColors.darkGray,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                event['description'],
                style: const TextStyle(fontSize: 14, height: 1.4),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _getCategoryColor(String category) {
    switch (category) {
      case 'Academic':
        return AppColors.blueMirage;
      case 'Sports':
        return const Color(0xFF4CAF50);
      case 'Career':
        return const Color(0xFFFF9800);
      case 'Cultural':
        return const Color(0xFF9C27B0);
      case 'Workshop':
        return const Color(0xFFF44336);
      default:
        return AppColors.darkGray;
    }
  }

  void _showEventDetails(Map<String, dynamic> event) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(event['title']),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Date: ${event['date']}'),
            Text('Time: ${event['time']}'),
            Text('Location: ${event['location']}'),
            Text('Organizer: ${event['organizer']}'),
            Text('Attendees: ${event['attendees']}'),
            const SizedBox(height: 12),
            Text(event['description']),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _openRoute(String routeName) {
    Navigator.of(context).pushNamed(routeName);
  }
}
