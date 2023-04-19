import 'dart:io';

import 'package:appwrite/appwrite.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ewitter_app/src/constants/constants.dart';

import '../core/core.dart';

final storageAPIProvider = Provider((ref) {
  return StorageAPI(
    storage: ref.watch(appWriteStorageProvider),
  );
});

class StorageAPI {
  final Storage _storage;
  StorageAPI({required Storage storage}) : _storage = storage;

  Future<List<String>> uploadImage(List<File> files) async {
    List<String> imageLinks = [];
    for (final file in files) {
      final uploadedImage = await _storage.createFile(
        bucketId: KAppWrite.imagesBucket,
        fileId: ID.unique(),
        file: InputFile.fromPath(path: file.path),
      );
      imageLinks.add(
        KAppWrite.imageUrl(uploadedImage.$id),
      );
    }
    return imageLinks;
  }
}