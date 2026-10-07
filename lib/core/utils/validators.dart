class Validators {
  Validators._();

  static String? email(String? value) {
    if (value == null || value.isEmpty) {
      return "البريد الإلكتروني مطلوب";
    }
    if (!value.contains('@')) {
      return "صيغة البريد غير صحيحة";
    }
    return null;
  }

  static String? password(String? value) {
    if (value == null || value.isEmpty) {
      return "كلمة المرور مطلوبة";
    }
    if (value.length < 6) {
      return "كلمة المرور قصيرة جداً";
    }
    return null;
  }

  static String? required(String? value, {String field = "هذا الحقل"}) {
    if (value == null || value.isEmpty) {
      return "$field مطلوب";
    }
    return null;
  }
}