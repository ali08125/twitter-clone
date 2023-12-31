import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone/common/widgets/error_page.dart';
import 'package:twitter_clone/features/tweet/controller/tweet_controller.dart';
import 'package:twitter_clone/features/tweet/widgets/tweet_card.dart';

class TweetList extends ConsumerWidget {
  const TweetList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(getTweetsProvider).when(
      data: (tweets) {
        return ListView.builder(
          itemCount: tweets.length,
          itemBuilder: (context, index) {
            final tweet = tweets[index];
            return TweetCard(tweet: tweet);
          },
        );
      },
      error: (error, stackTrace) {
        return ErrorPage(errorMessage: error.toString());
      },
      loading: () {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
