import 'package:tech_gate/models/user.dart';

class AuthState {
  final bool isLoading;
  final User? user;
  final String? error;

  AuthState({required this.isLoading, this.user, this.error});

  factory AuthState.initial() => AuthState(isLoading: false);
  factory AuthState.loading() => AuthState(isLoading: true);
  factory AuthState.authenticated(User user) =>
      AuthState(isLoading: false, user: user);
  factory AuthState.error(String error) =>
      AuthState(isLoading: false, error: error);

  T when<T>({
    required T Function() initial,
    required T Function(User user) authenticated,
    required T Function() loading,
    required T Function(String error) error,
  }) {
    if (isLoading) return loading();
    if (user != null) return authenticated(user!);
    if (this.error != null) return error(this.error!);
    return initial();
  }
}
