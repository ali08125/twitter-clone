import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone/common/apis/storage_api.dart';
import 'package:twitter_clone/common/apis/tweet_api.dart';
import 'package:twitter_clone/common/data_state/data_state.dart';
import 'package:twitter_clone/common/enum/tweet_type_enum.dart';
import 'package:twitter_clone/common/widgets/custom_snackbar.dart';
import 'package:twitter_clone/features/auth/controller/auth_controller.dart';
import 'package:twitter_clone/models/tweet_model.dart';

final tweetControllerProvider =
    StateNotifierProvider<TweetController, bool>((ref) {
  return TweetController(
      ref: ref,
      tweetAPI: ref.watch(tweetAPIProvider),
      storageAPI: ref.watch(storageAPIProvider));
});

final getTweetsProvider = FutureProvider((ref) {
  return ref.watch(tweetControllerProvider.notifier).getTweets();
});

class TweetController extends StateNotifier<bool> {
  TweetController(
      {required Ref ref,
      required TweetAPI tweetAPI,
      required StorageAPI storageAPI})
      : _ref = ref,
        _tweetAPI = tweetAPI,
        _storageAPI = storageAPI,
        super(false);

  final Ref _ref;
  final TweetAPI _tweetAPI;
  final StorageAPI _storageAPI;

  Future<List<Tweet>> getTweets() async {
    final document = await _tweetAPI.getTweets();
    return (document).map((tweet) => Tweet.fromMap(tweet.data)).toList();
  }

  void shareTweet({
    required List<File> images,
    required String text,
    required BuildContext context,
  }) {
    if (text.isEmpty) {
      showSnackbar(context, 'Please enter a text');
      return;
    }
    state = true;

    if (images.isNotEmpty) {
      _shareImageTweet(images: images, text: text, context: context);
    } else {
      _shareTextTweet(text: text, context: context);
    }
  }

  void _shareImageTweet({
    required List<File> images,
    required String text,
    required BuildContext context,
  }) async {
    final hashtags = _getHashtagFromText(text);
    final link = _getLinkFromText(text);
    final user = _ref.read(currentUserDetailsProvider).value!;
    final imageLinks = await _storageAPI.uploadImages(images);
    final tweet = Tweet(
        text: text,
        link: link,
        hashtags: hashtags,
        imageLinks: imageLinks,
        uid: user.uid,
        tweetType: TweetType.image,
        tweetedAt: DateTime.now(),
        likes: [],
        commentIds: [],
        id: '',
        reShareCount: 0);
    final result = await _tweetAPI.shareTweet(tweet);
    if (result is DataFailed) {
      showSnackbar(context, result.error ?? 'Error');
    }
    state = false;
  }

  void _shareTextTweet({
    required String text,
    required BuildContext context,
  }) async {
    final hashtags = _getHashtagFromText(text);
    final link = _getLinkFromText(text);
    final user = _ref.read(currentUserDetailsProvider).value!;
    final tweet = Tweet(
        text: text,
        link: link,
        hashtags: hashtags,
        imageLinks: [],
        uid: user.uid,
        tweetType: TweetType.text,
        tweetedAt: DateTime.now(),
        likes: [],
        commentIds: [],
        id: '',
        reShareCount: 0);
    final result = await _tweetAPI.shareTweet(tweet);
    if (result is DataFailed) {
      showSnackbar(context, result.error ?? 'Error');
    }
    state = false;
  }

  String _getLinkFromText(String text) {
    List<String> wordsInSentences = text.split(' ');
    String link = '';
    for (String word in wordsInSentences) {
      if (word.startsWith('https//') || word.startsWith('www.')) {
        link = word;
      }
    }
    return link;
  }

  List<String> _getHashtagFromText(String text) {
    List<String> wordsInSentences = text.split(' ');
    List<String> hashtags = [];
    for (String word in wordsInSentences) {
      if (word.startsWith('#')) {
        hashtags.add(word);
      }
    }
    return hashtags;
  }
}
