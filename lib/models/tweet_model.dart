import 'package:twitter_clone/common/enum/tweet_type_enum.dart';

class Tweet {
  final String text;
  final String link;
  final List<String> hashtags;
  final List<String> imageLinks;
  final String uid;
  final TweetType tweetType;
  final DateTime tweetedAt;
  final List<String> likes;
  final List<String> commentIds;
  final String id;
  final int reShareCount;

  const Tweet({
    required this.text,
    required this.link,
    required this.hashtags,
    required this.imageLinks,
    required this.uid,
    required this.tweetType,
    required this.tweetedAt,
    required this.likes,
    required this.commentIds,
    required this.id,
    required this.reShareCount,
  });

  @override
  String toString() {
    return 'Tweet{ text: $text, link: $link, hashtags: $hashtags, imageLinks: $imageLinks, uid: $uid, tweetType: $tweetType, tweetedAt: $tweetedAt, likes: $likes, commentIds: $commentIds, id: $id, reShareCount: $reShareCount,}';
  }

  Tweet copyWith({
    String? text,
    String? link,
    List<String>? hashtags,
    List<String>? imageLinks,
    String? uid,
    TweetType? tweetType,
    DateTime? tweetedAt,
    List<String>? likes,
    List<String>? commentIds,
    String? id,
    int? reShareCount,
  }) {
    return Tweet(
      text: text ?? this.text,
      link: link ?? this.link,
      hashtags: hashtags ?? this.hashtags,
      imageLinks: imageLinks ?? this.imageLinks,
      uid: uid ?? this.uid,
      tweetType: tweetType ?? this.tweetType,
      tweetedAt: tweetedAt ?? this.tweetedAt,
      likes: likes ?? this.likes,
      commentIds: commentIds ?? this.commentIds,
      id: id ?? this.id,
      reShareCount: reShareCount ?? this.reShareCount,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'text': text,
      'link': link,
      'hashtags': hashtags,
      'imageLinks': imageLinks,
      'uid': uid,
      'tweetType': tweetType.type,
      'tweetedAt': tweetedAt.millisecondsSinceEpoch,
      'likes': likes,
      'commentIds': commentIds,
      'reShareCount': reShareCount,
    };
  }

  factory Tweet.fromMap(Map<String, dynamic> map) {
    return Tweet(
      text: map['text'] as String,
      link: map['link'] as String,
      hashtags: map['hashtags'] as List<String>,
      imageLinks: map['imageLinks'] as List<String>,
      uid: map['uid'] as String,
      tweetType: (map['tweetType'] as String).toTweetTypeEnum(),
      tweetedAt: map['tweetedAt'] as DateTime,
      likes: map['likes'] as List<String>,
      commentIds: map['commentIds'] as List<String>,
      id: map['\$id'] as String,
      reShareCount: map['reShareCount'] as int,
    );
  }

//</editor-fold>
}
