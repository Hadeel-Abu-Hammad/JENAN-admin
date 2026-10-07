import 'package:flutter/material.dart';
import 'package:jenan_admin/core/constants/colors/app_colors.dart';
import 'package:jenan_admin/features/dashboard/presentation/widgets/sidebar/show_tooltip.dart';

class SidebarItem extends StatelessWidget {
  const SidebarItem({
    super.key,
    required this.icon,
    required this.label,
    required this.isExpanded,
    required this.isSelected,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final bool isExpanded;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final itemContent = Material(
      color: isSelected ? lightGreen : transparent,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        hoverColor: hover,
        child: Container(
          height: 42,
          width: double.infinity,
          padding: EdgeInsets.symmetric(
            horizontal: isExpanded ? 12 : 0,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: isExpanded
                ? MainAxisAlignment.start
                : MainAxisAlignment.center,
            children: [

              Icon(
                icon,
                color: white,
                size: 20,
              ),

              if (isExpanded) ...[
                const SizedBox(width: 12),
                Flexible(
                  child: Text(
                    label,
                    style: const TextStyle(
                      color: white,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                    maxLines: 1,
                    textAlign: TextAlign.start,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],

            ],
          ),
        ),
      ),
    );

    if (isExpanded) {
      return itemContent;
    }

    return ShowTooltip(label: label, itemContent: itemContent);
  }
}
