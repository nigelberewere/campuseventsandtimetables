import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class ManageUsersPage extends StatefulWidget {
  const ManageUsersPage({super.key});

  @override
  State<ManageUsersPage> createState() => _ManageUsersPageState();
}

class _ManageUsersPageState extends State<ManageUsersPage> {
  final TextEditingController _searchController = TextEditingController();

  final List<Map<String, dynamic>> _users = [
    {
      'name': 'Tawanda Moyo',
      'email': 'n02412001@nust.students.ac.zw',
      'role': 'Student',
      'status': 'Active',
    },
    {
      'name': 'Rudo Ncube',
      'email': 'n02412002@nust.students.ac.zw',
      'role': 'Student',
      'status': 'Active',
    },
    {
      'name': 'Brian Dube',
      'email': 'n02412003@nust.students.ac.zw',
      'role': 'Class Rep',
      'status': 'Pending',
    },
    {
      'name': 'Admin Account',
      'email': 'admin@nust.ac.zw',
      'role': 'Admin',
      'status': 'Active',
    },
  ];

  String _searchText = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final filteredUsers = _users.where((user) {
      final query = _searchText.toLowerCase();
      return user['name'].toString().toLowerCase().contains(query) ||
          user['email'].toString().toLowerCase().contains(query) ||
          user['role'].toString().toLowerCase().contains(query);
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Manage Users',
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
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              color: AppColors.blueMirage,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(18),
                bottomRight: Radius.circular(18),
              ),
            ),
            child: TextField(
              controller: _searchController,
              onChanged: (value) => setState(() => _searchText = value),
              decoration: InputDecoration(
                hintText: 'Search by name, email, or role',
                hintStyle: TextStyle(
                  color: AppColors.darkGray.withValues(alpha: 0.6),
                ),
                prefixIcon: const Icon(Icons.search_rounded),
                filled: true,
                fillColor: AppColors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: filteredUsers.length,
              itemBuilder: (context, index) {
                final user = filteredUsers[index];
                return _UserCard(user: user);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _UserCard extends StatelessWidget {
  const _UserCard({required this.user});

  final Map<String, dynamic> user;

  @override
  Widget build(BuildContext context) {
    final isActive = user['status'] == 'Active';

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.dividerGray),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  user['name'],
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: AppColors.darkGray,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: isActive
                      ? AppColors.success.withValues(alpha: 0.14)
                      : AppColors.warning.withValues(alpha: 0.18),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  user['status'],
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: isActive ? AppColors.success : AppColors.warning,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            user['email'],
            style: const TextStyle(color: AppColors.darkGray),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(
                Icons.badge_rounded,
                size: 16,
                color: AppColors.blueMirage,
              ),
              const SizedBox(width: 6),
              Text(
                user['role'],
                style: const TextStyle(
                  color: AppColors.blueMirage,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Spacer(),
              TextButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Edit user workflow coming soon.'),
                    ),
                  );
                },
                child: const Text('Edit'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
