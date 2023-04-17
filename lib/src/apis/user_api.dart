import 'dart:async';

import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:ewitter_app/src/core/core.dart';
import 'package:ewitter_app/src/data/models/user_model.dart';

import '../constants/constants.dart';

final userAPIProvider = Provider((ref) {
  return UserAPI(db: ref.watch(appWriteDatabaseProvider));
});

abstract class IUserAPI {
  FutureEitherVoid saveUserData(UserModel userModel);
  Future<Document> getUserData(String uid);
}

class UserAPI implements IUserAPI {
  final Databases _db;
  UserAPI({required Databases db}) : _db = db;

  @override
  FutureEitherVoid saveUserData(UserModel userModel) async {
    try {
      await _db
          .createDocument(
            databaseId: KAppWrite.databaseId,
            collectionId: KAppWrite.usersCollectionId,
            documentId: userModel.uid,
            data: userModel.toMap(),
          )
          .timeout(KApi.apiCallTimeout);

      return right(null);
    } on AppwriteException catch (e, st) {
      return left(Failure(e.message ?? KApp.unExpectedError, st));
    } on TimeoutException catch (e, st) {
      return left(Failure(KApp.timeOutError, st));
    } catch (e, st) {
      return left(Failure(e.toString(), st));
    }
  }

  @override
  Future<Document> getUserData(String uid) {
    return _db.getDocument(
      databaseId: KAppWrite.databaseId,
      collectionId: KAppWrite.usersCollectionId,
      documentId: uid,
    );
  }
}
