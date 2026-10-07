import 'package:flutter/material.dart';
import 'package:jenan_admin/core/constants/colors/app_colors.dart';
import 'package:jenan_admin/features/dashboard/presentation/widgets/sidebar/body/sidebar_item.dart';


class Footer extends StatelessWidget {
  const Footer({
    super.key,
    required this.isExpanded,
    required this.onSettingsTap,
    required this.onLogoutTap,
  });

  final bool isExpanded;
  final VoidCallback onSettingsTap;
  final VoidCallback onLogoutTap;


  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Divider(
          color: divider,
          height: 1,
          thickness: 1,
          indent: 12,
          endIndent: 12,
        ),

        const SizedBox(height: 8),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: SidebarItem(
            icon: Icons.settings,
            label: "الإعدادات",
            isExpanded: isExpanded,
            isSelected: false,
            onTap: onSettingsTap,
          ),
        ),

        const SizedBox(height: 6),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: SidebarItem(
            icon: Icons.logout,
            label: "تسجيل الخروج",
            isExpanded: isExpanded,
            isSelected: false,
            onTap: onLogoutTap,
          ),
        ),

        const SizedBox(height: 12),
      ],
    );
  }
}