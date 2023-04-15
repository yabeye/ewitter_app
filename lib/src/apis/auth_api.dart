import 'dart:async';

import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';

import '../constants/constants.dart';
import '../core/core.dart';

final authAPIProvider = Provider((ref) {
  return AuthAPI(account: ref.watch(appWriteAccountProvider));
});

abstract class IAuthAPI {
  FutureEither<User> signUp({
    required String email,
    required String password,
    required String name,
  });
  FutureEither<Session> logIn({
    required String email,
    required String password,
  });

  FutureEitherVoid logout();
}

class AuthAPI implements IAuthAPI {
  final Account _account;

  AuthAPI({required account}) : _account = account;

  @override
  FutureEither<User> signUp({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      final newAccount = await _account
          .create(
            userId: ID.unique(),
            email: email,
            password: password,
            name: name,
          )
          .timeout(KApi.apiCallTimeout);
      return right(newAccount);
    } on AppwriteException catch (e, st) {
      if (e.code == 409) {
        return left(Failure("User already exists", st));
      }
      return left(Failure(e.message ?? KApp.unExpectedError, st));
    } on TimeoutException catch (e, st) {
      return left(Failure(KApp.timeOutError, st));
    } catch (e, st) {
      return left(Failure(e.toString(), st));
    }
  }

  @override
  FutureEither<Session> logIn({
    required String email,
    required String password,
  }) async {
    try {
      final session = await _account
          .createEmailSession(
            email: email,
            password: password,
          )
          .timeout(KApi.apiCallTimeout);
      ;
      return right(session);
    } on AppwriteException catch (e, st) {
      return left(Failure(e.message ?? KApp.unExpectedError, st));
    } on TimeoutException catch (e, st) {
      return left(Failure(KApp.timeOutError, st));
    } catch (e, st) {
      return left(Failure(e.toString(), st));
    }
  }

  @override
  FutureEitherVoid logout() async {
    try {
      await _account.deleteSession(sessionId: 'current');
      return right(null);
    } on AppwriteException catch (e, st) {
      return left(Failure(e.message ?? KApp.unExpectedError, st));
    } catch (e, st) {
      return left(Failure(e.toString(), st));
    }
  }
}
