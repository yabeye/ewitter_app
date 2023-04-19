import 'dart:io';

import 'package:appwrite/appwrite.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:ewitter_app/src/apis/eweet_api.dart';
import 'package:ewitter_app/src/apis/storage_api.dart';
import 'package:ewitter_app/src/core/enums/eweet_type_enum.dart';

import '../../../utils/utils.dart';
import '../../../data/models/eweet_model.dart';
import '../../../data/models/user_model.dart';
import '../../auth/controllers/auth_controller.dart';

final eweetControllerProvider = StateNotifierProvider<EweetController, bool>(
  (ref) {
    return EweetController(
      ref: ref,
      eweetAPI: ref.watch(eweetAPIProvider),
      storageAPI: ref.watch(storageAPIProvider),
    );
  },
);

final getEweetsProvider = FutureProvider((ref) {
  final eweetController = ref.watch(eweetControllerProvider.notifier);
  return eweetController.getEweets();
});

final getRepliesToEweetsProvider = FutureProvider.family((ref, Eweet eweet) {
  final eweetController = ref.watch(eweetControllerProvider.notifier);
  return eweetController.getRepliesToEweet(eweet);
});

final getLatestEweetProvider = StreamProvider((ref) {
  final eweetAPI = ref.watch(eweetAPIProvider);
  return eweetAPI.getLatestEweet();
});

final getEweetByIdProvider = FutureProvider.family((ref, String id) async {
  final eweetController = ref.watch(eweetControllerProvider.notifier);
  return eweetController.getEweetById(id);
});

final getEweetsByHashtagProvider = FutureProvider.family((ref, String hashtag) {
  final eweetController = ref.watch(eweetControllerProvider.notifier);
  return eweetController.getEweetsByHashtag(hashtag);
});

class EweetController extends StateNotifier<bool> {
  final Ref _ref;
  final StorageAPI _storageAPI;
  final EweetAPI _eweetAPI;
  EweetController({
    required Ref ref,
    required storageAPI,
    required eweetAPI,
  })  : _ref = ref,
        _storageAPI = storageAPI,
        _eweetAPI = eweetAPI,
        super(false);

  Future<List<Eweet>> getEweets() async {
    final eweetList = await _eweetAPI.getEweets();
    final x = eweetList.map((eweet) => Eweet.fromMap(eweet.data)).toList();
    return x;
  }

  Future<Eweet> getEweetById(String id) async {
    final eweet = await _eweetAPI.getEweetById(id);
    return Eweet.fromMap(eweet.data);
  }

  void likeEweet(Eweet eweet, UserModel user) async {
    List<String> likes = eweet.likes;

    if (eweet.likes.contains(user.uid)) {
      likes.remove(user.uid);
    } else {
      likes.add(user.uid);
    }

    eweet = eweet.copyWith(likes: likes);
    final res = await _eweetAPI.likeEweet(eweet);
    res.fold((l) => toast(l.message), (r) {
      // toast("Ok!");
    });
  }

  Future<List<Eweet>> getRepliesToEweet(Eweet eweet) async {
    final documents = await _eweetAPI.getRepliesToEweet(eweet);
    return documents.map((eweet) => Eweet.fromMap(eweet.data)).toList();
  }

  Future<List<Eweet>> getEweetsByHashtag(String hashtag) async {
    final documents = await _eweetAPI.getEweetsByHashTag(hashtag);
    return documents.map((eweet) => Eweet.fromMap(eweet.data)).toList();
  }

  void shareEweet(
    BuildContext context, {
    required Eweet eweet,
    required UserModel currentUser,
  }) async {
    eweet = eweet.copyWith(
      rePostedBy: currentUser.username,
      likes: [],
      commentIds: [],
      shareCount: eweet.shareCount + 1,
    );

    final res = await _eweetAPI.updateShareCount(eweet);
    res.fold(
      (l) => toast(l.message),
      (r) async {
        eweet = eweet.copyWith(
          id: ID.unique(),
          shareCount: 0,
          postedAt: DateTime.now(),
        );
        final res2 = await _eweetAPI.postEweet(eweet);
        res2.fold(
          (l) => toast(l.message),
          (r) {
            toast('RePosted!');
          },
        );
      },
    );
  }

  void postEweet(
    context, {
    required List<File> images,
    required String text,
    required String repliedTo,
    required String repliedToUserId,
  }) {
    if (text.isEmpty) {
      toast('Please enter text');
      return;
    }

    if (images.isNotEmpty) {
      _postImageEweet(
        context,
        images: images,
        text: text,
      );
    } else {
      _postTextEweet(
        context,
        text: text,
      );
    }
  }

  void _postImageEweet(
    BuildContext context, {
    required List<File> images,
    required String text,
  }) async {
    state = true;
    final hashtags = getHashTagsFromText(text);
    String link = getLinkFromText(text);
    final user = _ref.read(currentUserDetailsProvider).value!;
    final imageLinks = await _storageAPI.uploadImage(images);

    Eweet newEweet = Eweet(
      text: text,
      hashTags: hashtags,
      link: link,
      imageLinks: imageLinks,
      uid: user.uid,
      eweetType: EweetType.image,
      postedAt: DateTime.now(),
      likes: const [],
      commentIds: const [],
      id: '',
      shareCount: 0,
      rePostedBy: '',
      repliedTo: '',
    );
    final res = await _eweetAPI.postEweet(newEweet);

    res.fold((l) {
      log(l.message);
      toast(l.message);
    }, (r) {
      toast("Shared an Eweet");
    });

    state = false;
    if (mounted) {
      Navigator.pop(context);
    }
  }

  void _postTextEweet(
    BuildContext context, {
    required String text,
  }) async {
    state = true;
    final hashtags = getHashTagsFromText(text);
    String link = getLinkFromText(text);
    final user = _ref.read(currentUserDetailsProvider).value!;
    Eweet newEweet = Eweet(
      text: text,
      hashTags: hashtags,
      link: link,
      imageLinks: const <String>[],
      uid: user.uid,
      eweetType: EweetType.text,
      postedAt: DateTime.now(),
      likes: const [],
      commentIds: const [],
      id: '',
      shareCount: 0,
      rePostedBy: '',
      repliedTo: '',
    );
    final res = await _eweetAPI.postEweet(newEweet);
    res.fold((l) {
      log(l.message);
      toast(l.message);
    }, (r) {
      toast("Shared an Eweet!");
    });
    state = false;
    if (mounted) {
      Navigator.pop(context);
    }
  }
}
