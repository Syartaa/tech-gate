import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tech_gate/models/auth_state.dart';
import 'package:tech_gate/services/auth_service.dart';

class AuthNotifier extends StateNotifier<AuthState> {
  final AuthService _authService;

  AuthNotifier(this._authService) : super(AuthState.initial());

  Future<void> login(String email, String password) async {
    state = AuthState.loading();
    try {
      final user = await _authService.login(email, password);
      state = AuthState.authenticated(user!);
    } catch (e) {
      state = AuthState.error(e.toString());
    }
  }

  Future<void> signup({
    required String firstName,
    required String lastName,
    required String email,
    required String phoneNumber,
    required String address,
    required String city,
    required String postcode,
    required String country,
    required String username,
    required String password,
  }) async {
    state = AuthState.loading();
    try {
      final user = await _authService.signup(
        firstName: firstName,
        lastName: lastName,
        email: email,
        phoneNumber: phoneNumber,
        address: address,
        city: city,
        postcode: postcode,
        country: country,
        username: username,
        password: password,
      );
      state = AuthState.authenticated(user!);
    } catch (e) {
      state = AuthState.error(e.toString());
    }
  }
}

//authservice provider
final authServiceProvider = Provider<AuthService>((ref) => AuthService());

//authnotifier provider
final authNotifierProvider = StateNotifierProvider<AuthNotifier, AuthState>(
  (ref) => AuthNotifier(ref.read(authServiceProvider)),
);
