import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class TimetablesPage extends StatefulWidget {
  const TimetablesPage({super.key});

  @override
  State<TimetablesPage> createState() => _TimetablesPageState();
}

class _TimetablesPageState extends State<TimetablesPage> {
  late DateTime _currentWeekStart;
  String _selectedView = 'Week'; // 'Week' or 'Day'

  final List<Map<String, dynamic>> _classes = [
    {
      'subject': 'Mathematics',
      'instructor': 'Dr. Smith',
      'room': 'B101',
      'day': 'Monday',
      'startTime': '09:00',
      'endTime': '10:30',
      'credits': 3,
      'color': AppColors.blueMirage,
    },
    {
      'subject': 'Physics',
      'instructor': 'Prof. Johnson',
      'room': 'Lab 2',
      'day': 'Monday',
      'startTime': '11:00',
      'endTime': '12:30',
      'credits': 4,
      'color': Color(0xFF29B6F6),
    },
    {
      'subject': 'Computer Science',
      'instructor': 'Dr. Williams',
      'room': 'C305',
      'day': 'Monday',
      'startTime': '14:00',
      'endTime': '15:30',
      'credits': 3,
      'color': Color(0xFF26C6DA),
    },
    {
      'subject': 'English Literature',
      'instructor': 'Ms. Brown',
      'room': 'A201',
      'day': 'Tuesday',
      'startTime': '09:00',
      'endTime': '10:30',
      'credits': 2,
      'color': Color(0xFFAB47BC),
    },
    {
      'subject': 'Chemistry',
      'instructor': 'Dr. Davis',
      'room': 'Lab 1',
      'day': 'Tuesday',
      'startTime': '11:00',
      'endTime': '13:00',
      'credits': 4,
      'color': Color(0xFFEC407A),
    },
    {
      'subject': 'History',
      'instructor': 'Prof. Miller',
      'room': 'D102',
      'day': 'Wednesday',
      'startTime': '10:00',
      'endTime': '11:30',
      'credits': 2,
      'color': Color(0xFFFF7043),
    },
    {
      'subject': 'Biology',
      'instructor': 'Dr. Wilson',
      'room': 'Lab 3',
      'day': 'Wednesday',
      'startTime': '13:00',
      'endTime': '15:00',
      'credits': 4,
      'color': Color(0xFF66BB6A),
    },
    {
      'subject': 'Mathematics',
      'instructor': 'Dr. Smith',
      'room': 'B102',
      'day': 'Thursday',
      'startTime': '09:00',
      'endTime': '10:30',
      'credits': 3,
      'color': AppColors.blueMirage,
    },
    {
      'subject': 'Philosophy',
      'instructor': 'Prof. Taylor',
      'room': 'E204',
      'day': 'Thursday',
      'startTime': '14:00',
      'endTime': '15:30',
      'credits': 2,
      'color': Color(0xFFFFB74D),
    },
    {
      'subject': 'Computer Science',
      'instructor': 'Dr. Williams',
      'room': 'C306',
      'day': 'Friday',
      'startTime': '10:00',
      'endTime': '11:30',
      'credits': 3,
      'color': Color(0xFF26C6DA),
    },
  ];

  final List<String> _daysOfWeek = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
  ];

  @override
  void initState() {
    super.initState();
    _currentWeekStart = _getMonday(DateTime.now());
  }

  DateTime _getMonday(DateTime date) {
    return date.subtract(Duration(days: date.weekday - 1));
  }

  List<Map<String, dynamic>> _getClassesForDay(String day) {
    return _classes.where((cls) => cls['day'] == day).toList()..sort((a, b) {
      return a['startTime'].compareTo(b['startTime']);
    });
  }

  String _formatDate(DateTime date) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return '${date.day} ${months[date.month - 1]}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My Timetable',
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
            icon: const Icon(Icons.more_vert, color: AppColors.white),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('More options coming soon!')),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header Section
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
                    'Your Schedule',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: AppColors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Stay on top of your classes and commitments',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.amberSmoke,
                    ),
                  ),
                ],
              ),
            ),

            // View Toggle
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(
                    child: SegmentedButton<String>(
                      segments: const <ButtonSegment<String>>[
                        ButtonSegment<String>(
                          value: 'Week',
                          label: Text('Week View'),
                          icon: Icon(Icons.calendar_view_week),
                        ),
                        ButtonSegment<String>(
                          value: 'Day',
                          label: Text('Day View'),
                          icon: Icon(Icons.calendar_view_day),
                        ),
                      ],
                      selected: <String>{_selectedView},
                      onSelectionChanged: (Set<String> newSelection) {
                        setState(() {
                          _selectedView = newSelection.first;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),

            // Week Navigation
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.arrow_back,
                      color: AppColors.blueMirage,
                    ),
                    onPressed: () {
                      setState(() {
                        _currentWeekStart = _currentWeekStart.subtract(
                          const Duration(days: 7),
                        );
                      });
                    },
                  ),
                  Text(
                    'Week of ${_formatDate(_currentWeekStart)} - ${_formatDate(_currentWeekStart.add(const Duration(days: 4)))}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppColors.blueMirage,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.arrow_forward,
                      color: AppColors.blueMirage,
                    ),
                    onPressed: () {
                      setState(() {
                        _currentWeekStart = _currentWeekStart.add(
                          const Duration(days: 7),
                        );
                      });
                    },
                  ),
                ],
              ),
            ),

            // Content View
            if (_selectedView == 'Week') _buildWeekView() else _buildDayView(),

            // Summary Card
            Padding(
              padding: const EdgeInsets.all(16),
              child: _buildSummaryCard(),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Add class functionality coming soon!'),
            ),
          );
        },
        backgroundColor: AppColors.blueMirage,
        child: const Icon(Icons.add, color: AppColors.white),
      ),
    );
  }

  Widget _buildWeekView() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: _daysOfWeek.map((day) {
          final dayClasses = _getClassesForDay(day);
          return Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  day,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.blueMirage,
                  ),
                ),
                const SizedBox(height: 12),
                if (dayClasses.isEmpty)
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.lightGray,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Text(
                      'No classes scheduled',
                      style: TextStyle(
                        color: AppColors.darkGray,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  )
                else
                  Column(
                    children: dayClasses
                        .map(
                          (cls) => Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: _buildClassCard(cls),
                          ),
                        )
                        .toList(),
                  ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildDayView() {
    final today = DateTime.now();
    final currentDay = _daysOfWeek[today.weekday - 1];
    final todayClasses = _getClassesForDay(currentDay);

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.amberSmoke,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                const Icon(Icons.today, color: AppColors.blueMirage, size: 28),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Today',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: AppColors.blueMirage,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      currentDay,
                      style: const TextStyle(
                        color: AppColors.darkGray,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          if (todayClasses.isEmpty)
            Container(
              padding: const EdgeInsets.all(32),
              decoration: BoxDecoration(
                color: AppColors.lightGray,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  const Icon(
                    Icons.beach_access,
                    size: 48,
                    color: AppColors.dividerGray,
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'No classes today',
                    style: TextStyle(
                      color: AppColors.darkGray,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Enjoy your free day!',
                    style: TextStyle(
                      color: AppColors.darkGray,
                      fontSize: 14,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            )
          else
            Column(
              children: todayClasses
                  .map(
                    (cls) => Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: _buildClassCard(cls),
                    ),
                  )
                  .toList(),
            ),
        ],
      ),
    );
  }

  Widget _buildClassCard(Map<String, dynamic> classData) {
    return GestureDetector(
      onTap: () => _showClassDetails(classData),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: classData['color'] as Color, width: 4),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: (classData['color'] as Color).withValues(alpha: 0.2),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
          color: AppColors.white,
        ),
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    classData['subject'] as String,
                    style: const TextStyle(
                      fontSize: 16,
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
                    color: classData['color'] as Color,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    '${classData['credits']} credits',
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: AppColors.white,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(
                  Icons.access_time,
                  size: 14,
                  color: AppColors.blueMirage,
                ),
                const SizedBox(width: 6),
                Text(
                  '${classData['startTime']} - ${classData['endTime']}',
                  style: const TextStyle(
                    fontSize: 13,
                    color: AppColors.darkGray,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Row(
              children: [
                const Icon(
                  Icons.location_on,
                  size: 14,
                  color: AppColors.blueMirage,
                ),
                const SizedBox(width: 6),
                Text(
                  classData['room'] as String,
                  style: const TextStyle(
                    fontSize: 13,
                    color: AppColors.darkGray,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Row(
              children: [
                const Icon(Icons.person, size: 14, color: AppColors.blueMirage),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    classData['instructor'] as String,
                    style: const TextStyle(
                      fontSize: 13,
                      color: AppColors.darkGray,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryCard() {
    final totalCredits = _classes.fold<int>(
      0,
      (sum, cls) => sum + (cls['credits'] as int),
    );
    final totalClasses = _classes.length;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.blueMirage, Color(0xFF4A7BA7)],
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            children: [
              const Icon(Icons.school, color: AppColors.amberSmoke, size: 28),
              const SizedBox(height: 8),
              Text(
                '$totalClasses',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.white,
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                'Classes',
                style: TextStyle(color: AppColors.amberSmoke, fontSize: 12),
              ),
            ],
          ),
          Column(
            children: [
              const Icon(
                Icons.import_contacts,
                color: AppColors.amberSmoke,
                size: 28,
              ),
              const SizedBox(height: 8),
              Text(
                '$totalCredits',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.white,
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                'Total Credits',
                style: TextStyle(color: AppColors.amberSmoke, fontSize: 12),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showClassDetails(Map<String, dynamic> classData) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => DraggableScrollableSheet(
        expand: false,
        initialChildSize: 0.6,
        maxChildSize: 0.9,
        builder: (context, scrollController) => Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    classData['subject'] as String,
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
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: classData['color'] as Color,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '${classData['credits']} Credits',
                  style: const TextStyle(
                    color: AppColors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              _buildDetailRow(
                Icons.access_time,
                'Time',
                '${classData['startTime']} - ${classData['endTime']}',
              ),
              const SizedBox(height: 16),
              _buildDetailRow(
                Icons.location_on,
                'Room',
                classData['room'] as String,
              ),
              const SizedBox(height: 16),
              _buildDetailRow(
                Icons.person,
                'Instructor',
                classData['instructor'] as String,
              ),
              const SizedBox(height: 16),
              _buildDetailRow(
                Icons.date_range,
                'Day',
                classData['day'] as String,
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Class updated!')),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: classData['color'] as Color,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Mark as Done',
                    style: TextStyle(
                      color: AppColors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
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
