import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:ewitter_app/src/constants/constants.dart';
import 'package:ewitter_app/src/core/core.dart';

import '../data/models/eweet_model.dart';

final eweetAPIProvider = Provider((ref) {
  return EweetAPI(
    db: ref.watch(appWriteDatabaseProvider),
    realtime: ref.watch(appWriteRealtimeProvider),
  );
});

abstract class IEweetAPI {
  FutureEither<Document> postEweet(Eweet eweet);
  Future<List<Document>> getEweets();
  Stream<RealtimeMessage> getLatestEweet();
  FutureEither<Document> likeEweet(Eweet eweet);
  FutureEither<Document> updateShareCount(Eweet eweet);
  Future<List<Document>> getRepliesToEweet(Eweet eweet);
  Future<List<Document>> getUserEweets(String uid);
  Future<List<Document>> getEweetsByHashTag(String hashtag);
  Future<Document> getEweetById(String id);
}

class EweetAPI implements IEweetAPI {
  final Databases _db;
  final Realtime _realtime;
  EweetAPI({required Databases db, required Realtime realtime})
      : _db = db,
        _realtime = realtime;

  @override
  FutureEither<Document> postEweet(Eweet eweet) async {
    try {
      final document = await _db.createDocument(
        databaseId: KAppWrite.databaseId,
        collectionId: KAppWrite.eweetsCollection,
        documentId: ID.unique(),
        data: eweet.toMap(),
      );
      return right(document);
    } on AppwriteException catch (e, st) {
      return left(
        Failure(
          e.message ?? KApp.unExpectedError,
          st,
        ),
      );
    } catch (e, st) {
      return left(Failure(e.toString(), st));
    }
  }

  @override
  Future<List<Document>> getEweets() async {
    final documents = await _db.listDocuments(
      databaseId: KAppWrite.databaseId,
      collectionId: KAppWrite.eweetsCollection,
      queries: [
        Query.orderDesc('postedAt'),
      ],
    );
    return documents.documents;
  }

  @override
  Stream<RealtimeMessage> getLatestEweet() {
    return _realtime.subscribe([
      'databases.${KAppWrite.databaseId}.collections.${KAppWrite.eweetsCollection}.documents'
    ]).stream;
  }

  @override
  FutureEither<Document> likeEweet(Eweet eweet) async {
    try {
      final document = await _db.updateDocument(
        databaseId: KAppWrite.databaseId,
        collectionId: KAppWrite.eweetsCollection,
        documentId: eweet.id,
        data: {
          'likes': eweet.likes,
        },
      );
      return right(document);
    } on AppwriteException catch (e, st) {
      return left(
        Failure(
          e.message ?? 'Some unexpected error occurred',
          st,
        ),
      );
    } catch (e, st) {
      return left(Failure(e.toString(), st));
    }
  }

  @override
  FutureEither<Document> updateShareCount(Eweet eweet) async {
    try {
      final document = await _db.updateDocument(
        databaseId: KAppWrite.databaseId,
        collectionId: KAppWrite.eweetsCollection,
        documentId: eweet.id,
        data: {
          'shareCount': eweet.shareCount,
        },
      );
      return right(document);
    } on AppwriteException catch (e, st) {
      return left(
        Failure(
          e.message ?? 'Some unexpected error occurred',
          st,
        ),
      );
    } catch (e, st) {
      return left(Failure(e.toString(), st));
    }
  }

  @override
  Future<List<Document>> getRepliesToEweet(Eweet eweet) async {
    final document = await _db.listDocuments(
      databaseId: KAppWrite.databaseId,
      collectionId: KAppWrite.eweetsCollection,
      queries: [
        Query.equal('repliedTo', eweet.id),
      ],
    );
    return document.documents;
  }

  @override
  Future<Document> getEweetById(String id) async {
    return _db.getDocument(
      databaseId: KAppWrite.databaseId,
      collectionId: KAppWrite.eweetsCollection,
      documentId: id,
    );
  }

  @override
  Future<List<Document>> getUserEweets(String uid) async {
    final documents = await _db.listDocuments(
      databaseId: KAppWrite.databaseId,
      collectionId: KAppWrite.eweetsCollection,
      queries: [
        Query.equal('uid', uid),
      ],
    );
    return documents.documents;
  }

  @override
  Future<List<Document>> getEweetsByHashTag(String hashTag) async {
    final documents = await _db.listDocuments(
      databaseId: KAppWrite.databaseId,
      collectionId: KAppWrite.eweetsCollection,
      queries: [
        Query.search('hashTags', hashTag),
      ],
    );
    return documents.documents;
  }
}
