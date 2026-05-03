import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../main.dart';
import 'addEvent.dart';
import '../widgets/app_drawer.dart';

class EventsPage extends StatefulWidget {
  const EventsPage({super.key});

  @override
  State<EventsPage> createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage> {
  String _selectedFilter = 'All';
  String _searchQuery = '';
  // Swapped filters to Categories so they work immediately with your dummy data!
  final List<String> _filters = [
    'All',
    'Academic',
    'Sports',
    'Career',
    'Cultural',
    'Workshop',
  ];

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

  // NEW: Getter to filter the list based on the selected chip and search query
  List<Map<String, dynamic>> get _filteredEvents {
    var filtered = _events;

    // Filter by category
    if (_selectedFilter != 'All') {
      filtered = filtered
          .where((event) => event['category'] == _selectedFilter)
          .toList();
    }

    // Filter by search query
    if (_searchQuery.isNotEmpty) {
      filtered = filtered
          .where(
            (event) =>
                event['title'].toLowerCase().contains(
                  _searchQuery.toLowerCase(),
                ) ||
                event['description'].toLowerCase().contains(
                  _searchQuery.toLowerCase(),
                ) ||
                event['location'].toLowerCase().contains(
                  _searchQuery.toLowerCase(),
                ) ||
                event['organizer'].toLowerCase().contains(
                  _searchQuery.toLowerCase(),
                ),
          )
          .toList();
    }

    return filtered;
  }

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
              _showSearchDialog();
            },
          ),
        ],
      ),
      drawer: AppDrawer(currentRoute: eventsRoute),
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
                          backgroundColor: _selectedFilter == filter
                              ? AppColors.amberSmoke
                              : AppColors.white.withValues(alpha: 0.8),
                          selectedColor: AppColors.amberSmoke,
                          checkmarkColor: AppColors.blueMirage,
                          side: BorderSide(
                            color: _selectedFilter == filter
                                ? AppColors.amberSmoke
                                : AppColors.white.withValues(alpha: 0.6),
                            width: 1.5,
                          ),
                          labelStyle: TextStyle(
                            color: _selectedFilter == filter
                                ? AppColors.blueMirage
                                : AppColors.blueMirage,
                            fontWeight: FontWeight.w600,
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
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
            // NEW: Empty State Check & Using _filteredEvents
            child: _filteredEvents.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.event_busy,
                          size: 64,
                          color: AppColors.dividerGray,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'No events found for $_selectedFilter',
                          style: const TextStyle(
                            fontSize: 18,
                            color: AppColors.darkGray,
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: _filteredEvents.length,
                    itemBuilder: (context, index) {
                      final event = _filteredEvents[index];
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
        onPressed: () async {
          final newEvent = await Navigator.push<Map<String, dynamic>>(
            context,
            MaterialPageRoute(builder: (context) => const AddEventPage()),
          );
          if (newEvent != null && mounted) {
            // NEW: Added setState to actually update the UI list!
            setState(() {
              _events.insert(0, newEvent);
            });

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  'Event "${newEvent['title']}" created successfully!',
                ),
                duration: const Duration(seconds: 2),
                backgroundColor: AppColors.blueMirage,
              ),
            );
          }
        },
        backgroundColor:
            AppColors.amberSmoke, // Changed to amber to pop against the blue
        child: const Icon(Icons.add, color: AppColors.blueMirage),
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
                maxLines: 2, // Keeps cards uniform, truncating long text
                overflow: TextOverflow.ellipsis,
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
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(
          event['title'],
          style: const TextStyle(
            color: AppColors.blueMirage,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDetailRow(Icons.calendar_today, 'Date: ${event['date']}'),
            const SizedBox(height: 8),
            _buildDetailRow(Icons.access_time, 'Time: ${event['time']}'),
            const SizedBox(height: 8),
            _buildDetailRow(
              Icons.location_on,
              'Location: ${event['location']}',
            ),
            const SizedBox(height: 8),
            _buildDetailRow(Icons.person, 'Organizer: ${event['organizer']}'),
            const SizedBox(height: 8),
            _buildDetailRow(Icons.people, 'Attendees: ${event['attendees']}'),
            const SizedBox(height: 16),
            const Divider(),
            const SizedBox(height: 8),
            Text(event['description'], style: const TextStyle(height: 1.4)),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'Close',
              style: TextStyle(color: AppColors.blueMirage),
            ),
          ),
        ],
      ),
    );
  }

  // Helper widget for clean dialog rows
  Widget _buildDetailRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 16, color: AppColors.blueMirage),
        const SizedBox(width: 8),
        Expanded(child: Text(text, style: const TextStyle(fontSize: 14))),
      ],
    );
  }

  void _showSearchDialog() {
    final TextEditingController searchController = TextEditingController(
      text: _searchQuery,
    );

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text(
          'Search Events',
          style: TextStyle(
            color: AppColors.blueMirage,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: TextField(
          controller: searchController,
          decoration: InputDecoration(
            hintText: 'Search by title, location, organizer...',
            prefixIcon: const Icon(Icons.search, color: AppColors.blueMirage),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: AppColors.blueMirage,
                width: 2,
              ),
            ),
          ),
          onChanged: (value) {
            setState(() {
              _searchQuery = value;
            });
          },
        ),
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                _searchQuery = '';
              });
              Navigator.pop(context);
            },
            child: const Text(
              'Clear',
              style: TextStyle(color: AppColors.blueMirage),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'Close',
              style: TextStyle(color: AppColors.blueMirage),
            ),
          ),
        ],
      ),
    );
  }
}
