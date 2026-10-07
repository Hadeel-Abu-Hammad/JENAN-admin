class CloudinaryConfig {
  CloudinaryConfig._(); // ال _() تعني انه ما بقدر استدعي هاذ ال constructer من برا ال class, والهدف عشان ما اقدر اعمل instances من هاذ ال class

  static const String cloudName = "dsptbzrkd";
  static const String uploadPreset = "jenan3";

  static const String folderAdmin = "jenan/admin";
  static const String folderSeller = "jenan/seller";
  static const String folderUser = "jenan/user";
  static const String folderProduct = "jenan/product";

  static String get uploadUrl =>
      "https://api.cloudinary.com/v1_1/$cloudName/image/upload";
}
