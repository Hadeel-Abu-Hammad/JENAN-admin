import 'package:jenan_admin/core/models/admin_user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepo {
  AuthRepo({
    FirebaseAuth? firebaseAuth,
    FirebaseFirestore? firestore,
  })  : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firestore;

  Future<AdminUser> login({required String email, required String password,}) async {

    final credential = await _firebaseAuth.signInWithEmailAndPassword(
      email: email.trim(),
      password: password,
    );

    final user = credential.user;
    if (user == null) {
      throw AuthException("فشل تسجيل الدخول");
    }

    final isAdmin = await _checkAdminClaim(user);
    if (!isAdmin) {
      await _firebaseAuth.signOut();
      throw AuthException("هذا الحساب ليس حساب أدمن");
    }

    final admin = await _getAdminFromFirestore(user.uid);
    if (admin == null) {
      await _firebaseAuth.signOut();
      throw AuthException("لا توجد بيانات لهذا الأدمن");
    }

    if (!admin.isActive) {
      await _firebaseAuth.signOut();
      throw AuthException("هذا الحساب معطّل، تواصل مع الإدارة");
    }

    return admin;
  }

  Future<AdminUser?> getCurrentAdmin() async {
    final user = _firebaseAuth.currentUser;
    if (user == null) return null;
    final isAdmin = await _checkAdminClaim(user);
    if (!isAdmin) {
      await _firebaseAuth.signOut();
      return null;
    }
    final admin = await _getAdminFromFirestore(user.uid);
    if (admin == null || !admin.isActive) {
      await _firebaseAuth.signOut();
      return null;
    }
    return admin;
  }

  Future<void> logout() async {
    await _firebaseAuth.signOut();
  }

  Future<bool> _checkAdminClaim(User user) async {
    try {
      final idTokenResult = await user.getIdTokenResult(true);
      return idTokenResult.claims?['admin'] == true;
    } catch (e) {
      return false;
    }
  }

  Future<AdminUser?> _getAdminFromFirestore(String uid) async {
    try {
      final doc = await _firestore.collection('admins').doc(uid).get();

      if (!doc.exists) return null;

      return AdminUser.fromFirestore(doc);
    } catch (e) {
      throw AuthException("فشل جلب بيانات الأدمن: $e");
    }
  }
}

class AuthException implements Exception {
  AuthException(this.message);
  final String message;
  @override
  String toString() => message;
}