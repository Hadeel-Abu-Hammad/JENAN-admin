import 'package:jenan_admin/features/dashboard/presentation/widgets/sidebar/footer/sidebar_footer.dart';
import 'package:jenan_admin/features/dashboard/presentation/widgets/sidebar/body/sidebar_item.dart';
import 'package:jenan_admin/features/dashboard/presentation/widgets/sidebar/header/header.dart';
import 'package:jenan_admin/core/constants/sidebar/sidebar_items_const.dart';
import 'package:jenan_admin/core/constants/sidebar/sidebar_width.dart';
import 'package:jenan_admin/core/constants/colors/app_colors.dart';
import 'package:flutter/material.dart';


class Sidebar extends StatelessWidget {
  const Sidebar({
    super.key,
    required this.isExpanded,
    required this.selectedIndex,
    required this.onToggle,
    required this.onItemSelected,
    required this.onSettingsTap,
    required this.onLogoutTap,
  });

  final bool isExpanded;
  final int selectedIndex;
  final VoidCallback onToggle;
  final ValueChanged<int> onItemSelected;
  final VoidCallback onSettingsTap;
  final VoidCallback onLogoutTap;


  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: animationDuration,
      curve: Curves.easeInOutCirc,
      width: isExpanded ? expandedWidth : collapsedWidth,
      color: darkGreen,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Column(
            children: [

              Header(isExpanded: isExpanded, onToggle: onToggle),

              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 8,
                  ),
                  itemCount: sidebarItems.length,
                  itemBuilder: (context, index) {
                    final item = sidebarItems[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 6),
                      child: SidebarItem(
                        icon: item.icon,
                        label: item.label,
                        isExpanded: isExpanded,
                        isSelected: selectedIndex == index,
                        onTap: () => onItemSelected(index),
                      ),
                    );
                  },
                ),
              ),

              Footer(
                isExpanded: isExpanded,
                onSettingsTap: onSettingsTap,
                onLogoutTap: onLogoutTap,
              ),

            ],
          ),
        ],
      ),
    );
  }
}
