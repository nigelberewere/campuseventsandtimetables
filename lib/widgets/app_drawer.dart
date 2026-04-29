import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../main.dart';

class AppDrawer extends StatelessWidget {
  final String currentRoute;

  const AppDrawer({
    super.key,
    required this.currentRoute,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: AppColors.blueMirage,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.amberSmoke,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.2),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.person,
                      color: AppColors.blueMirage,
                      size: 32,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Nigel Berewere',
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Computer Science',
                  style: TextStyle(
                    color: AppColors.amberSmoke,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          _buildDrawerItem(
            icon: Icons.home_rounded,
            title: 'Home',
            route: homeRoute,
            currentRoute: currentRoute,
            context: context,
          ),
          _buildDrawerItem(
            icon: Icons.calendar_today_rounded,
            title: 'Events',
            route: eventsRoute,
            currentRoute: currentRoute,
            context: context,
          ),
          _buildDrawerItem(
            icon: Icons.schedule_rounded,
            title: 'Timetable',
            route: timetablesRoute,
            currentRoute: currentRoute,
            context: context,
          ),
          _buildDrawerItem(
            icon: Icons.notifications_rounded,
            title: 'Notifications',
            route: notificationsRoute,
            currentRoute: currentRoute,
            context: context,
          ),
          _buildDrawerItem(
            icon: Icons.person_rounded,
            title: 'Profile',
            route: profileRoute,
            currentRoute: currentRoute,
            context: context,
          ),
          const Divider(
            color: AppColors.dividerGray,
            height: 1,
            thickness: 1,
          ),
          _buildDrawerItem(
            icon: Icons.admin_panel_settings_rounded,
            title: 'Admin Panel',
            route: adminRoute,
            currentRoute: currentRoute,
            context: context,
          ),
          _buildDrawerItem(
            icon: Icons.explore_rounded,
            title: 'Landing',
            route: landingRoute,
            currentRoute: currentRoute,
            context: context,
          ),
          const Spacer(),
          const Divider(
            color: AppColors.dividerGray,
            height: 1,
            thickness: 1,
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: FilledButton.icon(
              onPressed: () {
                Navigator.of(context).pushNamedAndRemoveUntil(
                  loginRoute,
                  (route) => false,
                );
              },
              icon: const Icon(Icons.logout_rounded),
              label: const Text('Logout'),
              style: FilledButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: AppColors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem({
    required IconData icon,
    required String title,
    required String route,
    required String currentRoute,
    required BuildContext context,
  }) {
    final isSelected = currentRoute == route;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: isSelected ? AppColors.blueMirage.withValues(alpha: 0.1) : null,
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        leading: Icon(
          icon,
          color: isSelected ? AppColors.blueMirage : AppColors.darkGray,
          size: 24,
        ),
        title: Text(
          title,
          style: TextStyle(
            color: isSelected ? AppColors.blueMirage : AppColors.darkGray,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
          ),
        ),
        onTap: isSelected
            ? null
            : () {
                Navigator.of(context).pop(); // Close drawer
                Navigator.of(context).pushNamedAndRemoveUntil(
                  route,
                  (route) => false,
                );
              },
      ),
    );
  }
}
