import 'package:appwrite/models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:ewitter_app/src/apis/user_api.dart';
import 'package:ewitter_app/src/features/auth/view/login_view.dart';
import 'package:ewitter_app/src/features/home/view/home_view.dart';
import 'package:ewitter_app/src/data/models/user_model.dart';

import '../../../apis/auth_api.dart';

final authControllerProvider =
    StateNotifierProvider<AuthController, bool>((ref) {
  return AuthController(
    authAPI: ref.watch(authAPIProvider),
    userAPI: ref.watch(userAPIProvider),
  );
});

final currentUserDetailsProvider = FutureProvider((ref) {
  final currentUserId = ref.watch(currentUserAccountProvider).value!.$id;
  final userDetails = ref.watch(userDetailsProvider(currentUserId));
  return userDetails.value;
});

final userDetailsProvider = FutureProvider.family((ref, String uid) {
  final authController = ref.watch(authControllerProvider.notifier);
  return authController.getUserData(uid);
});

final currentUserAccountProvider = FutureProvider((ref) {
  final authController = ref.watch(authControllerProvider.notifier);
  return authController.currentUserAccount();
});

class AuthController extends StateNotifier<bool> {
  final AuthAPI _authAPI;
  final UserAPI _userAPI;

  AuthController({required AuthAPI authAPI, required UserAPI userAPI})
      : _authAPI = authAPI,
        _userAPI = userAPI,
        super(false);

  Future<User?> currentUserAccount() => _authAPI.getCurrentUserAccount();

  void signUp(
    context, {
    required String email,
    required String password,
    required String username,
  }) async {
    state = true;
    final signUpRes = await _authAPI.signUp(
      email: email,
      password: password,
      username: username,
    );
    state = false;

    signUpRes.fold(
      (l) => toast(l.message),
      (r) async {
        UserModel newUserData = UserModel(
          uid: r.$id,
          email: email,
          username: username,
          followers: const [],
          following: const [],
        );

        final saveUserRes = await _userAPI.saveUserData(newUserData);

        saveUserRes.fold((l) => toast(l.message), (r) {
          toast("Account Created");
          const LoginView().launch(
            context,
            isNewTask: true,
          );
        });
      },
    );
  }

  void logIn(
    context, {
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
      (l) => toast(l.message),
      (r) {
        toast(r.$id);
        const HomeView().launch(
          context,
          isNewTask: true,
        );
      },
    );
  }

  Future<UserModel> getUserData(String uid) async {
    final document = await _userAPI.getUserData(uid);

    late UserModel userData;
    try {
      // TODO: Remove this try catch block!
      userData = UserModel.fromMap(document.data);
    } catch (e) {
      toast(e.toString());
    }
    return userData;
  }
}
