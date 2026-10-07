import 'package:flutter/material.dart';
import 'package:jenan_admin/core/utils/cloudinary_helper.dart';
import 'package:jenan_admin/core/constants/images/image_sizes.dart';
import 'package:jenan_admin/features/dashboard/presentation/widgets/sidebar/header/fallback_avatar.dart';
import 'package:jenan_admin/features/dashboard/presentation/widgets/sidebar/header/loading_avatar.dart';

class Avatar extends StatelessWidget {
  const Avatar({super.key, required this.onToggle, required this.photoUrl});

  final String? photoUrl;
  final VoidCallback onToggle;


  @override
  Widget build(BuildContext context) {
    final optimizedUrl = CloudinaryHelper.avatar(photoUrl, size: ImageSizes.avatarSize.toInt());
    return (photoUrl == null || photoUrl!.isEmpty) ?
    FallbackAvatar()
        :AnimatedContainer(
      curve: Curves.easeInOut,
      duration: const Duration(milliseconds: 700),
      child: InkWell(
        onTap: onToggle,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(ImageSizes.avatarSize / 2),
          child: Image.network(
            optimizedUrl,
            width: ImageSizes.avatarSize.toDouble(),
            height: ImageSizes.avatarSize.toDouble(),
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => FallbackAvatar(),
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return LoadingAvatar();
            },
          ),
        ),
      ),
    );
  }
}



