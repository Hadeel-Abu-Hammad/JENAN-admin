class FirebaseErrors {
  FirebaseErrors._();
  static String firebaseErrorMap(String code) {
    switch (code) {
      case "user-not-found":
        return "لا يوجد حساب بهذا الإيميل";
      case "wrong-password":
        return "كلمة المرور غير صحيحة";
      case "invalid-email":
        return "صيغة الإيميل غير صحيحة";
      case "user-disabled":
        return "هذا الحساب معطّل";
      case "too-many-requests":
        return "محاولات كثيرة، حاول لاحقاً";
      case "network-request-failed":
        return "تحقق من اتصال الإنترنت";
      case "invalid-credential":
        return "الإيميل أو كلمة المرور غير صحيحة";
      default:
        return "حدث خطأ في تسجيل الدخول، حاول مرة أخرى";
    }
  }
}