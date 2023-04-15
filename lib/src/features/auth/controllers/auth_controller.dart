import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../apis/auth_api.dart';

final authControllerProvider =
    StateNotifierProvider<AuthController, bool>((ref) {
  return AuthController(authAPI: ref.watch(authAPIProvider));
});

class AuthController extends StateNotifier<bool> {
  final AuthAPI _authAPI;

  AuthController({required authAPI})
      : _authAPI = authAPI,
        super(false);

  void signUp({
    required String email,
    required String password,
    required String name,
  }) async {
    state = true;
    final res = await _authAPI.signUp(
      email: email,
      password: password,
      name: name,
    );
    state = false;

    res.fold(
      (l) => toast("Error ${l.message}"),
      (r) => toast("Account has created with ${r.name}"),
    );
  }

  void logIn({
    required String email,
    required String password,
  }) async {
    state = true;
    final res = await _authAPI.logIn(
      email: email,
      password: password,
    );
    state = false;

    res.fold(
      (l) => toast("Error ${l.message}"),
      (r) => toast("Successfully logged In!"),
    );
  }
}
