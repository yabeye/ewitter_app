import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:fpdart/fpdart.dart';

import '../constants/constants.dart';
import '../core/core.dart';
import '../core/type_defs.dart';

// abstract class IAuthAPI {
//   FutureEither<User> signUp({
//     required String email,
//     required String password,
//   });
// }

abstract class IAuthAPI {
  FutureEither<User> signUp({
    required String email,
    required String password,
  });
  // FutureEitherVoid logout();
}

class AuthAPI implements IAuthAPI {
  final Account _account;

  AuthAPI({required account}) : _account = account;

  @override
  FutureEither<User> signUp(
      {required String email, required String password}) async {
    try {
      final newAccount = await _account.create(
        userId: ID.unique(),
        email: email,
        password: password,
      );
      return right(newAccount);
    } on AppwriteException catch (e, st) {
      return left(Failure(e.message ?? KApp.unExpectedError, st));
    } catch (e, st) {
      return left(Failure(e.toString(), st));
    }
  }
}
