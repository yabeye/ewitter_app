import 'package:appwrite/appwrite.dart';
import 'package:ewitter_app/src/core/core.dart';
import 'package:ewitter_app/src/models/user_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';

import '../constants/constants.dart';

final userAPIProvider = Provider((ref) {
  return UserAPI(db: ref.watch(appWriteDatabaseProvider));
});

abstract class IUserAPI {
  FutureEitherVoid saveUserData(UserModel userModel);
}

class UserAPI implements IUserAPI {
  final Databases _db;

  UserAPI({required Databases db}) : _db = db;

  @override
  FutureEitherVoid saveUserData(UserModel userModel) async {
    try {
      // KAppWrite.usersCollectionId();
      await _db.createDocument(
        databaseId: KAppWrite.databaseId,
        collectionId: KAppWrite.usersCollectionId,
        documentId: ID.unique(),
        data: userModel.toMap(),
      );

      return right(null);
    } on AppwriteException catch (e, st) {
      return left(Failure(e.message ?? KApp.unExpectedError, st));
    } catch (e, st) {
      return left(Failure(e.toString(), st));
    }
  }
}
