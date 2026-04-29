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
              // TODO: Implement search functionality
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Search functionality coming soon!'),
                ),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Filter Section
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
                          backgroundColor: AppColors.white.withOpacity(0.2),
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

          // Events List
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
          // TODO: Implement add event functionality
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
              // Event Title and Category
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

              // Event Details
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
                  Expanded(
                    child: Text(
                      event['location'],
                      style: const TextStyle(
                        fontSize: 14,
                        color: AppColors.darkGray,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              // Attendees and Organizer
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.amberSmoke,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.people,
                          size: 14,
                          color: AppColors.blueMirage,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '${event['attendees']} attending',
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: AppColors.darkGray,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    event['organizer'],
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.blueMirage,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
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
        return AppColors.success;
      case 'Career':
        return AppColors.warning;
      case 'Cultural':
        return AppColors.info;
      case 'Workshop':
        return AppColors.error;
      default:
        return AppColors.blueMirage;
    }
  }

  void _showEventDetails(Map<String, dynamic> event) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => DraggableScrollableSheet(
        expand: false,
        initialChildSize: 0.7,
        maxChildSize: 0.9,
        builder: (context, scrollController) => Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    event['title'],
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppColors.darkGray,
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // Category Badge
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: _getCategoryColor(event['category']),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  event['category'],
                  style: const TextStyle(
                    color: AppColors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Event Details
              _buildDetailRow(Icons.calendar_today, 'Date', event['date']),
              const SizedBox(height: 12),
              _buildDetailRow(Icons.access_time, 'Time', event['time']),
              const SizedBox(height: 12),
              _buildDetailRow(Icons.location_on, 'Location', event['location']),
              const SizedBox(height: 12),
              _buildDetailRow(
                Icons.people,
                'Attendees',
                '${event['attendees']} registered',
              ),
              const SizedBox(height: 12),
              _buildDetailRow(Icons.person, 'Organizer', event['organizer']),

              const SizedBox(height: 24),

              // Description
              const Text(
                'Description',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.darkGray,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                event['description'],
                style: const TextStyle(
                  fontSize: 16,
                  color: AppColors.darkGray,
                  height: 1.5,
                ),
              ),

              const Spacer(),

              // Action Buttons
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        // TODO: Implement RSVP functionality
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('RSVP functionality coming soon!'),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.blueMirage,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'RSVP',
                        style: TextStyle(
                          color: AppColors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  IconButton(
                    onPressed: () {
                      // TODO: Implement share functionality
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Share functionality coming soon!'),
                        ),
                      );
                    },
                    icon: const Icon(Icons.share, color: AppColors.blueMirage),
                    style: IconButton.styleFrom(
                      backgroundColor: AppColors.amberSmoke,
                      padding: const EdgeInsets.all(16),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 20, color: AppColors.blueMirage),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: 12,
                color: AppColors.darkGray,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              value,
              style: const TextStyle(fontSize: 16, color: AppColors.darkGray),
            ),
          ],
        ),
      ],
    );
  }
}
