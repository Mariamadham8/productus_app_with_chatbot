import 'package:auth_api_app/feature/chat_bot/presentation/ui/views/chat_bot_view.dart';
import 'package:auth_api_app/feature/home/presentation/ui/views/profile_info_view.dart';
import 'package:flutter/material.dart';
import '../../../../../../../core/theming/app_color.dart';
import '../../../../../../../core/theming/app_fonts.dart';

class AppNavigationDrawer extends StatelessWidget {
  final String username;
  final String email;
  final VoidCallback onLogout;

  const AppNavigationDrawer({
    super.key,
    required this.username,
    required this.email,
    required this.onLogout,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // User info
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 28,
                    backgroundColor: AppColors.primaryColor.withOpacity(0.15),
                    child: Text(
                      username.isNotEmpty ? username[0].toUpperCase() : 'U',
                      style: AppFonts.font24BlackW700.copyWith(
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(username, style: AppFonts.font16BlackW500),
                        const SizedBox(height: 2),
                        Text(
                          email,
                          style: AppFonts.font14GreyW400,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const Divider(height: 1),
            const SizedBox(height: 8),

            // Menu items
            _DrawerItem(
              icon: Icons.person_outline,
              label: 'Profile',
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfileScreen()),
              ),
            ),
            _DrawerItem(
              icon: Icons.auto_awesome_outlined,
              label: 'Smart Assistant',
              isSelected: true,
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ChatBotScreen()),
              ),
            ),
            _DrawerItem(
              icon: Icons.shopping_bag_outlined,
              label: 'Products',
              onTap: () => Navigator.pop(context),
            ),

            const SizedBox(height: 8),
            const Divider(height: 1),
            const SizedBox(height: 8),

            // Dark mode toggle
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              child: Row(
                children: [
                  const Icon(
                    Icons.dark_mode_outlined,
                    color: Colors.grey,
                    size: 22,
                  ),
                  const SizedBox(width: 12),
                  Text('Dark Mode', style: AppFonts.font14BlackW500),
                  const Spacer(),
                  Switch(
                    value: false,
                    onChanged: (_) {},
                    activeColor: AppColors.primaryColor,
                  ),
                ],
              ),
            ),

            const Spacer(),

            // Logout
            Padding(
              padding: const EdgeInsets.all(16),
              child: GestureDetector(
                onTap: onLogout,
                child: Row(
                  children: [
                    const Icon(Icons.logout, color: Colors.red, size: 22),
                    const SizedBox(width: 12),
                    Text(
                      'Logout',
                      style: AppFonts.font14BlackW500.copyWith(
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DrawerItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool isSelected;

  const _DrawerItem({
    required this.icon,
    required this.label,
    required this.onTap,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        icon,
        color: isSelected ? AppColors.primaryColor : Colors.grey,
        size: 22,
      ),
      title: Text(
        label,
        style: AppFonts.font14BlackW500.copyWith(
          color: isSelected ? AppColors.primaryColor : Colors.black87,
          fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
        ),
      ),
      tileColor: isSelected
          ? AppColors.primaryColor.withOpacity(0.08)
          : Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
      onTap: onTap,
    );
  }
}
