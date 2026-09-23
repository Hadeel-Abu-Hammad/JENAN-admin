import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:jenan_admin/core/models/admin_user.dart';

class AuthRepo {
  AuthRepo({
    FirebaseAuth? firebaseAuth,
    FirebaseFirestore? firestore,
  })  : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firestore;

  /// تسجيل دخول الأدمن
  Future<AdminUser> login({
    required String email,
    required String password,
  }) async {
    // 1. تسجيل الدخول عبر Firebase Auth
    final credential = await _firebaseAuth.signInWithEmailAndPassword(
      email: email.trim(),
      password: password,
    );

    final user = credential.user;
    if (user == null) {
      throw AuthException('فشل تسجيل الدخول');
    }

    // 2. التحقق من Custom Claim "admin"
    final isAdmin = await _checkAdminClaim(user);
    if (!isAdmin) {
      await _firebaseAuth.signOut();
      throw AuthException('هذا الحساب ليس حساب أدمن');
    }

    // 3. جلب بيانات الأدمن من Firestore
    final admin = await _getAdminFromFirestore(user.uid);
    if (admin == null) {
      await _firebaseAuth.signOut();
      throw AuthException('لا توجد بيانات لهذا الأدمن');
    }

    // 4. التحقق من أن الحساب مفعّل
    if (!admin.isActive) {
      await _firebaseAuth.signOut();
      throw AuthException('هذا الحساب معطّل، تواصل مع الإدارة');
    }

    return admin;
  }

  /// جلب الأدمن الحالي (عند فتح التطبيق)
  Future<AdminUser?> getCurrentAdmin() async {
    final user = _firebaseAuth.currentUser;
    if (user == null) return null;

    // 1. التحقق من Custom Claim
    final isAdmin = await _checkAdminClaim(user);
    if (!isAdmin) {
      await _firebaseAuth.signOut();
      return null;
    }

    // 2. جلب البيانات من Firestore
    final admin = await _getAdminFromFirestore(user.uid);
    if (admin == null || !admin.isActive) {
      await _firebaseAuth.signOut();
      return null;
    }

    return admin;
  }

  /// تسجيل الخروج
  Future<void> logout() async {
    await _firebaseAuth.signOut();
  }

  /// قراءة Custom Claim "admin" من رمز الهوية
  Future<bool> _checkAdminClaim(User user) async {
    try {
      // forceRefresh = true لضمان الحصول على أحدث Claims
      final idTokenResult = await user.getIdTokenResult(true);
      return idTokenResult.claims?['admin'] == true;
    } catch (e) {
      return false;
    }
  }

  /// جلب بيانات الأدمن من Firestore
  Future<AdminUser?> _getAdminFromFirestore(String uid) async {
    try {
      final doc = await _firestore.collection('admins').doc(uid).get();

      if (!doc.exists) return null;

      return AdminUser.fromFirestore(doc);
    } catch (e) {
      throw AuthException('فشل جلب بيانات الأدمن: $e');
    }
  }
}

class AuthException implements Exception {
  AuthException(this.message);

  final String message;

  @override
  String toString() => message;
}