import 'package:flutter/material.dart';
import 'package:jenan_admin/core/constants/colors/app_colors.dart';
import 'package:jenan_admin/core/constants/images/image_sizes.dart';

class FallbackAvatar extends StatelessWidget {
  const FallbackAvatar({super.key});


  @override
  Widget build(BuildContext context) {
    return Container(
        width: ImageSizes.avatarSize.toDouble(),
        height: ImageSizes.avatarSize.toDouble(),
        decoration: const BoxDecoration(
          color: lightGreen,
          shape: BoxShape.circle,
        ),
        child: Icon(
          Icons.person,
          color: white,
          size: ImageSizes.avatarSize * 0.6,
        ),
      );
  }
}
