import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class ManageNotificationsPage extends StatefulWidget {
  const ManageNotificationsPage({super.key});

  @override
  State<ManageNotificationsPage> createState() => _ManageNotificationsPageState();
}

class _ManageNotificationsPageState extends State<ManageNotificationsPage> {
  bool _pushEnabled = true;
  bool _emailEnabled = false;
  bool _smsEnabled = false;

  final List<Map<String, String>> _templates = [
    {
      'title': 'Event Reminder',
      'description': 'Sent 2 hours before event start time.',
    },
    {
      'title': 'Class Update Alert',
      'description': 'Sent when timetable entries are changed.',
    },
    {
      'title': 'Campus Broadcast',
      'description': 'High-priority notices for all students.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Manage Notifications',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: AppColors.white,
          ),
        ),
        backgroundColor: AppColors.blueMirage,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.blueMirage,
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Notification Control Center',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: AppColors.white,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Turn channels on/off and manage templates before broadcasting notices.',
                  style: TextStyle(
                    color: AppColors.amberSmoke,
                    height: 1.35,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          _buildChannelCard(
            title: 'Push Notifications',
            subtitle: 'In-app and device push alerts',
            value: _pushEnabled,
            onChanged: (v) => setState(() => _pushEnabled = v),
          ),
          _buildChannelCard(
            title: 'Email Digest',
            subtitle: 'Weekly updates and reminders',
            value: _emailEnabled,
            onChanged: (v) => setState(() => _emailEnabled = v),
          ),
          _buildChannelCard(
            title: 'SMS Alerts',
            subtitle: 'Urgent notification channel',
            value: _smsEnabled,
            onChanged: (v) => setState(() => _smsEnabled = v),
          ),
          const SizedBox(height: 16),
          const Text(
            'Templates',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: AppColors.darkGray,
            ),
          ),
          const SizedBox(height: 12),
          ..._templates.map(
            (template) => Container(
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.dividerGray),
              ),
              child: Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: AppColors.blueMirage.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(
                      Icons.mark_email_unread_rounded,
                      color: AppColors.blueMirage,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          template['title']!,
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            color: AppColors.darkGray,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          template['description']!,
                          style: const TextStyle(
                            fontSize: 12,
                            color: AppColors.darkGray,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Template editor coming soon.'),
                        ),
                      );
                    },
                    icon: const Icon(Icons.edit_rounded),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Broadcast composer coming soon.')),
          );
        },
        backgroundColor: AppColors.blueMirage,
        icon: const Icon(Icons.send_rounded, color: AppColors.white),
        label: const Text('Create Broadcast', style: TextStyle(color: AppColors.white)),
      ),
    );
  }

  Widget _buildChannelCard({
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.dividerGray),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    color: AppColors.darkGray,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(fontSize: 12, color: AppColors.darkGray),
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeThumbColor: AppColors.blueMirage,
          ),
        ],
      ),
    );
  }
}
