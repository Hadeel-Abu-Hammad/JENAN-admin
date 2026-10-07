import 'package:jenan_admin/core/constants/images/image_sizes.dart';
import 'package:jenan_admin/core/constants/cloudinary/cloudinary_helper_consts.dart';

class CloudinaryHelper {
  CloudinaryHelper._();

  static String transform(
      String? originalUrl, {
        int? width,
        int? height,
        String crop = CloudinaryHelperConsts.defaultCrop,
        bool isCircular = false,
      }) {

    if (originalUrl == null || originalUrl.isEmpty) {
      return '';
    }

    if (!originalUrl.contains("cloudinary.com")) {
      return originalUrl;
    }

    if (originalUrl.contains("/upload/w_") ||
        originalUrl.contains("/upload/h_") ||
        originalUrl.contains("/upload/c_")) {
      return originalUrl;
    }

    final List<String> transformations = [];

    if (width != null) transformations.add("w_$width");
    if (height != null) transformations.add("h_$height");
    if (crop.isNotEmpty) transformations.add("c_$crop");
    if (isCircular) transformations.add(CloudinaryHelperConsts.circularRadius);

    transformations.add(CloudinaryHelperConsts.autoQuality);
    transformations.add(CloudinaryHelperConsts.autoFormat);

    final transformString = transformations.join(',');

    return originalUrl.replaceFirst(
      "/upload/",
      "/upload/$transformString/",
    );
  }

  static String avatar(String? originalUrl, {int size = ImageSizes.avatarSize}) {
    return transform(
      originalUrl,
      width: size * ImageSizes.retinaMultiplier,
      height: size * ImageSizes.retinaMultiplier,
      isCircular: true,
    );
  }

  static String productImage(String? originalUrl, {int width = ImageSizes.productImageWidth}) {
    return transform(
      originalUrl,
      width: width,
      crop: CloudinaryHelperConsts.defaultCrop,
    );
  }

  static String thumbnail(String? originalUrl, {int size = ImageSizes.thumbnailSize}) {
    return transform(
      originalUrl,
      width: size,
      height: size,
      crop: CloudinaryHelperConsts.defaultCrop,
    );
  }
}