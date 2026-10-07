import 'package:flutter/material.dart';
import 'package:jenan_admin/core/constants/colors/app_colors.dart';

class MarketingScreen extends StatelessWidget {
  const MarketingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.campaign, size: 80, color: lightGreen),
          SizedBox(height: 20),
          Text(
            'التسويق والتنبيهات',
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}