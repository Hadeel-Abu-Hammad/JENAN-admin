import 'package:flutter/material.dart';
import 'package:jenan_admin/core/constants/colors/app_colors.dart';
import 'package:jenan_admin/core/constants/images/image_sizes.dart';


class LoadingAvatar extends StatelessWidget {
  const LoadingAvatar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: ImageSizes.avatarSize.toDouble(),
        height: ImageSizes.avatarSize.toDouble(),
        decoration: const BoxDecoration(
          color: lightGreen,
          shape: BoxShape.circle,
        ),
        child: Center(
          child: SizedBox(
            width: ImageSizes.avatarSize * 0.4,
            height: ImageSizes.avatarSize * 0.4,
            child: const CircularProgressIndicator(
              strokeWidth: 2,
              color: white,
            ),
          ),
        ),
      );
  }
}
