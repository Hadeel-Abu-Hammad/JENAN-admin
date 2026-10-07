import 'package:flutter/material.dart';
import 'package:jenan_admin/core/constants/colors/app_colors.dart';

class AppDialog extends StatelessWidget {
  final String title;
  final String confirmText;
  final String cancelText;
  final IconData icon;

  const AppDialog({
    super.key,
    this.title = "تأكيد تسجيل الخروج",
    this.confirmText = "خروج",
    this.cancelText = "إلغاء",
    this.icon = Icons.logout,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: transparent,
      elevation: 0,
      insetPadding: const EdgeInsets.all(10),
      content: ConstrainedBox(
        constraints: const BoxConstraints(
          minWidth: 300,
          maxWidth: 400,
          minHeight: 200,
          maxHeight: 300,
        ),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: const BoxDecoration(
            gradient: RadialGradient(
              center: Alignment.bottomRight,
              radius: 4.5,
              colors: [darkGreen, lightGreen],
            ),
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, color: white, size: 40),
              const SizedBox(height: 16),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 44),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context, false),
                    child: Text(
                      cancelText,
                      style: const TextStyle(color: white),
                    ),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context, true),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: lightGreen,
                      foregroundColor: white,
                    ),
                    child: Text(confirmText),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}