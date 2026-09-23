part of 'auth_bloc.dart';

@immutable
sealed class AuthState extends Equatable{
  const AuthState();
  @override
  List<Object?> get props => [];

}

final class AuthInitial extends AuthState {
  const AuthInitial();
}

final class AuthCheckingSession extends AuthState { // التحقق من الجلسة السابقة
  const AuthCheckingSession();
}

final class AuthLoading extends AuthState {
  const AuthLoading();
}

final class AuthAuthenticated extends AuthState {
  final AdminUser adminUser;
  const AuthAuthenticated(this.adminUser);
  @override
  List<Object?> get props => [adminUser];
}

final class AuthFailure extends AuthState {
  const AuthFailure(this.message);
  final String message;
  @override
  List<Object?> get props => [message];

}

final class AuthUnauthenticated extends AuthState {
  const AuthUnauthenticated();
}

