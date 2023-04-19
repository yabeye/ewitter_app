import 'package:flutter/foundation.dart';

import '../../core/enums/eweet_type_enum.dart';

@immutable
class Eweet {
  final String text;
  final List<String> hashTags;
  final String link;
  final List<String> imageLinks;
  final String uid;
  final EweetType eweetType;
  final DateTime postedAt;
  final List<String> likes;
  final List<String> commentIds;
  final String id;
  final int shareCount;
  final String rePostedBy;
  final String repliedTo;
  const Eweet({
    required this.text,
    required this.hashTags,
    required this.link,
    required this.imageLinks,
    required this.uid,
    required this.eweetType,
    required this.postedAt,
    required this.likes,
    required this.commentIds,
    required this.id,
    required this.shareCount,
    required this.rePostedBy,
    required this.repliedTo,
  });

  Eweet copyWith({
    String? text,
    List<String>? hashTags,
    String? link,
    List<String>? imageLinks,
    String? uid,
    EweetType? eweetType,
    DateTime? postedAt,
    List<String>? likes,
    List<String>? commentIds,
    String? id,
    int? shareCount,
    String? rePostedBy,
    String? repliedTo,
  }) {
    return Eweet(
      text: text ?? this.text,
      hashTags: hashTags ?? this.hashTags,
      link: link ?? this.link,
      imageLinks: imageLinks ?? this.imageLinks,
      uid: uid ?? this.uid,
      eweetType: eweetType ?? this.eweetType,
      postedAt: postedAt ?? this.postedAt,
      likes: likes ?? this.likes,
      commentIds: commentIds ?? this.commentIds,
      id: id ?? this.id,
      shareCount: shareCount ?? this.shareCount,
      rePostedBy: rePostedBy ?? this.rePostedBy,
      repliedTo: repliedTo ?? this.repliedTo,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'text': text});
    result.addAll({'hashTags': hashTags});
    result.addAll({'link': link});
    result.addAll({'imageLinks': imageLinks});
    result.addAll({'uid': uid});
    result.addAll({'eweetType': eweetType.name});
    result.addAll({'postedAt': postedAt.toString()});
    result.addAll({'likes': likes});
    result.addAll({'commentIds': commentIds});
    result.addAll({'shareCount': shareCount});
    result.addAll({'rePostedBy': rePostedBy});
    result.addAll({'repliedTo': repliedTo});

    return result;
  }

  factory Eweet.fromMap(Map<String, dynamic> map) {
    return Eweet(
      text: map['text'] ?? '',
      hashTags: List<String>.from(map['hashTags']),
      link: map['link'] ?? '',
      imageLinks: List<String>.from(map['imageLinks']),
      uid: map['uid'] ?? '',
      eweetType: (map['eweetType'] as String).toEweetTypeEnum(),
      postedAt: DateTime.parse(map['postedAt']),
      likes: List<String>.from(map['likes']),
      commentIds: List<String>.from(map['commentIds']),
      id: map['\$id'] ?? '',
      shareCount: map['shareCount'] ?? 0,
      rePostedBy: map['rePostedBy'] ?? '',
      repliedTo: map['repliedTo'] ?? '',
    );
  }

  @override
  String toString() {
    return 'Eweet(text: $text, hashTags: $hashTags, link: $link, imageLinks: $imageLinks, uid: $uid, eweetType: $eweetType, postedAt: $postedAt, likes: $likes, commentIds: $commentIds, id: $id, shareCount: $shareCount, rePostedBy: $rePostedBy, repliedTo: $repliedTo)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Eweet &&
        other.text == text &&
        listEquals(other.hashTags, hashTags) &&
        other.link == link &&
        listEquals(other.imageLinks, imageLinks) &&
        other.uid == uid &&
        other.eweetType == eweetType &&
        other.postedAt == postedAt &&
        listEquals(other.likes, likes) &&
        listEquals(other.commentIds, commentIds) &&
        other.id == id &&
        other.shareCount == shareCount &&
        other.rePostedBy == rePostedBy &&
        other.repliedTo == repliedTo;
  }

  @override
  int get hashCode {
    return text.hashCode ^
        hashTags.hashCode ^
        link.hashCode ^
        imageLinks.hashCode ^
        uid.hashCode ^
        eweetType.hashCode ^
        postedAt.hashCode ^
        likes.hashCode ^
        commentIds.hashCode ^
        id.hashCode ^
        shareCount.hashCode ^
        rePostedBy.hashCode ^
        repliedTo.hashCode;
  }
}
