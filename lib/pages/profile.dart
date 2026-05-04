import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../main.dart';
import '../widgets/app_drawer.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool _notificationsEnabled = true;
  bool _emailDigest = true;
  bool _eventReminders = true;

  // Edit mode state
  bool _isEditing = false;

  // User information state
  String _name = 'Nigel Berewere';
  final String _studentId = 'CSC2024001';
  String _email = 'n024212345@nust.students.ac.zw';
  String _phone = '+263 700 000 000';
  String _department = 'Faculty of Applied Science - Computer Science';
  String _year = '2nd Year (2025/2026)';

  // Controllers for text fields
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  late TextEditingController _departmentController;
  late TextEditingController _yearController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: _name);
    _emailController = TextEditingController(text: _email);
    _phoneController = TextEditingController(text: _phone);
    _departmentController = TextEditingController(text: _department);
    _yearController = TextEditingController(text: _year);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _departmentController.dispose();
    _yearController.dispose();
    super.dispose();
  }

  void _toggleEditMode() {
    setState(() {
      if (_isEditing) {
        // Save changes
        _name = _nameController.text;
        _email = _emailController.text;
        _phone = _phoneController.text;
        _department = _departmentController.text;
        _year = _yearController.text;
      } else {
        // Reset controllers to current values
        _nameController.text = _name;
        _emailController.text = _email;
        _phoneController.text = _phone;
        _departmentController.text = _department;
        _yearController.text = _year;
      }
      _isEditing = !_isEditing;
    });
  }

  void _cancelEdit() {
    setState(() {
      // Reset controllers to original values
      _nameController.text = _name;
      _emailController.text = _email;
      _phoneController.text = _phone;
      _departmentController.text = _department;
      _yearController.text = _year;
      _isEditing = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Profile',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: AppColors.white,
          ),
        ),
        backgroundColor: AppColors.blueMirage,
        elevation: 0,
        centerTitle: true,
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu, color: AppColors.white),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
      ),
      drawer: AppDrawer(currentRoute: profileRoute),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Profile Header with Avatar
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
              decoration: const BoxDecoration(
                color: AppColors.blueMirage,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(32),
                  bottomRight: Radius.circular(32),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.amberSmoke,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.2),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.person,
                        size: 56,
                        color: AppColors.blueMirage,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  _isEditing
                      ? TextField(
                          controller: _nameController,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: AppColors.white,
                          ),
                          textAlign: TextAlign.center,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            filled: true,
                            fillColor: AppColors.white,
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 8,
                            ),
                          ),
                        )
                      : Text(
                          _name,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: AppColors.white,
                          ),
                        ),
                  const SizedBox(height: 8),
                  Text(
                    'Student ID: $_studentId',
                    style: const TextStyle(
                      fontSize: 14,
                      color: AppColors.amberSmoke,
                    ),
                  ),
                  const SizedBox(height: 4),
                  _isEditing
                      ? TextField(
                          controller: _departmentController,
                          style: const TextStyle(
                            fontSize: 14,
                            color: AppColors.amberSmoke,
                          ),
                          textAlign: TextAlign.center,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            filled: true,
                            fillColor: AppColors.white,
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 8,
                            ),
                          ),
                        )
                      : Text(
                          _department.split(' - ').last,
                          style: const TextStyle(
                            fontSize: 14,
                            color: AppColors.amberSmoke,
                          ),
                        ),
                ],
              ),
            ),

            // Profile Information Section
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Account Information',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.darkGray,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildInfoCard(
                    icon: Icons.email_rounded,
                    label: 'Email',
                    value: _email,
                    controller: _emailController,
                    isEditing: _isEditing,
                  ),
                  const SizedBox(height: 12),
                  _buildInfoCard(
                    icon: Icons.phone_rounded,
                    label: 'Phone',
                    value: _phone,
                    controller: _phoneController,
                    isEditing: _isEditing,
                  ),
                  const SizedBox(height: 12),
                  _buildInfoCard(
                    icon: Icons.location_city_rounded,
                    label: 'Department',
                    value: _department,
                    controller: _departmentController,
                    isEditing: _isEditing,
                  ),
                  const SizedBox(height: 12),
                  _buildInfoCard(
                    icon: Icons.calendar_today_rounded,
                    label: 'Year',
                    value: _year,
                    controller: _yearController,
                    isEditing: _isEditing,
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Preferences',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.darkGray,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildPreferenceToggle(
                    title: 'Enable Notifications',
                    subtitle: 'Receive alerts about new events and updates',
                    value: _notificationsEnabled,
                    onChanged: (value) {
                      setState(() {
                        _notificationsEnabled = value;
                      });
                    },
                  ),
                  const SizedBox(height: 12),
                  _buildPreferenceToggle(
                    title: 'Email Digest',
                    subtitle: 'Weekly summary of campus events',
                    value: _emailDigest,
                    onChanged: (value) {
                      setState(() {
                        _emailDigest = value;
                      });
                    },
                  ),
                  const SizedBox(height: 12),
                  _buildPreferenceToggle(
                    title: 'Event Reminders',
                    subtitle: 'Get notified before events start',
                    value: _eventReminders,
                    onChanged: (value) {
                      setState(() {
                        _eventReminders = value;
                      });
                    },
                  ),
                  const SizedBox(height: 32),
                  if (_isEditing) ...[
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: _cancelEdit,
                            icon: const Icon(Icons.cancel_rounded),
                            label: const Text('Cancel'),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: AppColors.blueMirage,
                              side: const BorderSide(
                                color: AppColors.blueMirage,
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 14),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: FilledButton.icon(
                            onPressed: _toggleEditMode,
                            icon: const Icon(Icons.save_rounded),
                            label: const Text('Save'),
                            style: FilledButton.styleFrom(
                              backgroundColor: AppColors.blueMirage,
                              foregroundColor: AppColors.white,
                              padding: const EdgeInsets.symmetric(vertical: 14),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ] else ...[
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton.tonalIcon(
                        onPressed: _toggleEditMode,
                        icon: const Icon(Icons.edit_rounded),
                        label: const Text('Edit Profile'),
                        style: FilledButton.styleFrom(
                          backgroundColor: AppColors.blueMirage,
                          foregroundColor: AppColors.white,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                        ),
                      ),
                    ),
                  ],
                  const SizedBox(height: 32),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton.icon(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text('Logout'),
                            content: const Text(
                              'Are you sure you want to logout?',
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text('Cancel'),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                  Navigator.of(context).pushNamedAndRemoveUntil(
                                    '/login',
                                    (route) => false,
                                  );
                                },
                                style: TextButton.styleFrom(
                                  foregroundColor: Colors.red,
                                ),
                                child: const Text('Logout'),
                              ),
                            ],
                          ),
                        );
                      },
                      icon: const Icon(Icons.logout_rounded),
                      label: const Text('Logout'),
                      style: FilledButton.styleFrom(
                        backgroundColor: Colors.red,
                        foregroundColor: AppColors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Center(
                    child: Text(
                      'App Version 1.0.0',
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.darkGray.withValues(alpha: 0.6),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard({
    required IconData icon,
    required String label,
    required String value,
    TextEditingController? controller,
    bool isEditing = false,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.lightGray,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.dividerGray),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: AppColors.blueMirage.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Icon(icon, color: AppColors.blueMirage, size: 24),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.darkGray,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                isEditing && controller != null
                    ? TextField(
                        controller: controller,
                        style: const TextStyle(
                          fontSize: 14,
                          color: AppColors.darkGray,
                          fontWeight: FontWeight.w500,
                        ),
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          isDense: true,
                        ),
                      )
                    : Text(
                        value,
                        style: const TextStyle(
                          fontSize: 14,
                          color: AppColors.darkGray,
                          fontWeight: FontWeight.w500,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPreferenceToggle({
    required String title,
    required String subtitle,
    required bool value,
    required Function(bool) onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.lightGray,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.dividerGray),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.darkGray,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.darkGray,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Switch(
            value: value,
            onChanged: onChanged,
            activeThumbColor: AppColors.blueMirage,
            inactiveThumbColor: AppColors.darkGray,
          ),
        ],
      ),
    );
  }
}
