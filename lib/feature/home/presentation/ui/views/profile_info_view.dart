import 'package:auth_api_app/feature/auth/presentation/manger/login_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../../core/theming/app_color.dart';
import '../../../../../../../core/theming/app_fonts.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black87,
            size: 20,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('My Profile', style: AppFonts.font16BlackW500),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined, color: Colors.black87),
            onPressed: () {},
          ),
        ],
      ),
      body: BlocBuilder<LoginCubit, LoginState>(
        builder: (context, state) {
          if (state is! LoginSuccess) {
            return const Center(child: CircularProgressIndicator());
          }

          final user = state.user;

          return SingleChildScrollView(
            child: Column(
              children: [
                // Header
                Container(
                  color: Colors.white,
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 24),
                  child: Column(
                    children: [
                      // Avatar
                      Stack(
                        children: [
                          CircleAvatar(
                            radius: 48,
                            backgroundColor: AppColors.primaryColor.withOpacity(
                              0.1,
                            ),
                            backgroundImage: user.image.isNotEmpty
                                ? NetworkImage(user.image)
                                : null,
                            child: user.image.isEmpty
                                ? Text(
                                    user.firstName[0].toUpperCase(),
                                    style: AppFonts.font24BlackW700.copyWith(
                                      color: AppColors.primaryColor,
                                      fontSize: 32,
                                    ),
                                  )
                                : null,
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              width: 24,
                              height: 24,
                              decoration: const BoxDecoration(
                                color: AppColors.primaryColor,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.check,
                                color: Colors.white,
                                size: 14,
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 12),

                      // Name
                      Text(
                        '${user.firstName} ${user.lastName}',
                        style: AppFonts.font24BlackW700,
                      ),

                      const SizedBox(height: 4),

                      // Email
                      Text(user.email, style: AppFonts.font14GreyW400),

                      const SizedBox(height: 12),

                      // Badge
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: AppColors.primaryColor.withOpacity(0.5),
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          user.gender.toUpperCase(),
                          style: AppFonts.font14PrimaryW500.copyWith(
                            fontSize: 11,
                            letterSpacing: 1,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 16),

                // Account Settings
                _SectionHeader(title: 'ACCOUNT SETTINGS'),
                _SettingsCard(
                  items: [
                    _SettingsItem(
                      icon: Icons.person_outline,
                      iconColor: AppColors.primaryColor,
                      title: 'Personal Information',
                      subtitle:
                          '${user.firstName} ${user.lastName} • ${user.email}',
                    ),
                    _SettingsItem(
                      icon: Icons.badge_outlined,
                      iconColor: Colors.purple,
                      title: 'Username',
                      subtitle: '@${user.username}',
                    ),
                    _SettingsItem(
                      icon: Icons.people_outline,
                      iconColor: Colors.orange,
                      title: 'Gender',
                      subtitle: user.gender,
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                // App Preferences
                _SectionHeader(title: 'APP PREFERENCES'),
                _SettingsCard(
                  items: [
                    _SettingsItem(
                      icon: Icons.notifications_outlined,
                      iconColor: Colors.orange,
                      title: 'Notifications',
                      subtitle: 'Order updates, promos',
                    ),
                    _SettingsItem(
                      icon: Icons.dark_mode_outlined,
                      iconColor: Colors.blueGrey,
                      title: 'Dark Mode',
                      subtitle: 'Adjust app appearance',
                      trailing: Switch(
                        value: false,
                        onChanged: (_) {},
                        activeColor: AppColors.primaryColor,
                      ),
                    ),
                    _SettingsItem(
                      icon: Icons.language_outlined,
                      iconColor: Colors.green,
                      title: 'Language',
                      subtitle: 'English (US)',
                    ),
                  ],
                ),

                const SizedBox(height: 32),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  const _SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          title,
          style: AppFonts.font14GreyW400.copyWith(
            fontSize: 12,
            letterSpacing: 0.8,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

class _SettingsCard extends StatelessWidget {
  final List<_SettingsItem> items;
  const _SettingsCard({required this.items});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: items.asMap().entries.map((entry) {
          final index = entry.key;
          final item = entry.value;
          return Column(
            children: [
              _SettingsItemTile(item: item),
              if (index < items.length - 1)
                const Divider(height: 1, indent: 56),
            ],
          );
        }).toList(),
      ),
    );
  }
}

class _SettingsItem {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String subtitle;
  final Widget? trailing;

  const _SettingsItem({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.subtitle,
    this.trailing,
  });
}

class _SettingsItemTile extends StatelessWidget {
  final _SettingsItem item;
  const _SettingsItemTile({required this.item});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: item.iconColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(item.icon, color: item.iconColor, size: 20),
      ),
      title: Text(item.title, style: AppFonts.font14BlackW500),
      subtitle: Text(
        item.subtitle,
        style: AppFonts.font14GreyW400.copyWith(fontSize: 12),
      ),
      trailing:
          item.trailing ?? const Icon(Icons.chevron_right, color: Colors.grey),
      onTap: () {},
    );
  }
}
