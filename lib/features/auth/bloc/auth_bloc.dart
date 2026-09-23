import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:jenan_admin/core/models/admin_user.dart';
import 'package:jenan_admin/features/auth/data/repos/auth_repo.dart';
import 'package:meta/meta.dart';
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepo _authRepo;
  AuthBloc({required AuthRepo authRepo})
    : _authRepo = authRepo,
      super(AuthInitial()) {
    on<AuthCheckEvent>(_onAuthCheck);
    on<AuthLoginEvent>(_onLogin);
    on<AuthLogoutEvent>(_onLogout);
  }

  Future<void> _onAuthCheck(AuthCheckEvent event, Emitter<AuthState> emit) async {
    emit(AuthCheckingSession());
    try {
      final admin = await _authRepo.getCurrentAdmin();
      if (admin != null) {
        emit(AuthAuthenticated(admin));
      } else {
        emit(AuthUnauthenticated());
      }
    } catch (e) {
      emit(AuthUnauthenticated());
    }
  }

  Future<void> _onLogin(
      AuthLoginEvent event,
      Emitter<AuthState> emit
      ) async{
    emit(AuthLoading());
    try {
      final admin = await _authRepo.login(
          email: event.email, password: event.password);
      emit(AuthAuthenticated(admin));
    }
    on AuthException catch(e){
      emit(AuthFailure(e.message));
    }
    on FirebaseAuthException catch(e){
      emit(AuthFailure(_mapFirebaseError(e.code)));
    }
    catch(e){
      emit(AuthFailure("خطأ غير متوقع, الرجاء المحاولة مرة أخرى"));
    }
  }

  Future<void> _onLogout(
      AuthLogoutEvent event,
      Emitter<AuthState> emit
      ) async{
    emit(AuthLoading());
    try{
      await _authRepo.logout();
      emit(AuthUnauthenticated());
    }catch(e){
      emit(AuthFailure("فشل تسجيل الخروج"));
    }
  }


  String _mapFirebaseError(String code) {
    switch (code) {
      case 'user-not-found':
        return 'لا يوجد حساب بهذا الإيميل';
      case 'wrong-password':
        return 'كلمة المرور غير صحيحة';
      case 'invalid-email':
        return 'صيغة الإيميل غير صحيحة';
      case 'user-disabled':
        return 'هذا الحساب معطّل';
      case 'too-many-requests':
        return 'محاولات كثيرة، حاول لاحقاً';
      case 'network-request-failed':
        return 'تحقق من اتصال الإنترنت';
      case 'invalid-credential':
        return 'الإيميل أو كلمة المرور غير صحيحة';
      default:
        return 'حدث خطأ في تسجيل الدخول، حاول مرة أخرى';
    }
  }


}
