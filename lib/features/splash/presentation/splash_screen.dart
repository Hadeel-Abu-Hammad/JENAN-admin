import 'package:flutter/material.dart';
import 'package:jenan_admin/core/constants/colors/app_colors.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkGreen,
      body: Center(
        child: const CircularProgressIndicator(
          color: white,
        ),
      ),
    );
  }
}