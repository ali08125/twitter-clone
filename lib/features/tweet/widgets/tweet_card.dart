import 'package:any_link_preview/any_link_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone/common/constants/constants.dart';
import 'package:twitter_clone/common/enum/tweet_type_enum.dart';
import 'package:twitter_clone/common/widgets/error_page.dart';
import 'package:twitter_clone/config/theme/pallete.dart';
import 'package:twitter_clone/features/auth/controller/auth_controller.dart';
import 'package:twitter_clone/features/tweet/widgets/carousel_image.dart';
import 'package:twitter_clone/features/tweet/widgets/hashtag_text.dart';
import 'package:twitter_clone/features/tweet/widgets/tweet_icon_buttons.dart';
import 'package:twitter_clone/models/tweet_model.dart';
import 'package:timeago/timeago.dart' as timeago;

class TweetCard extends ConsumerWidget {
  const TweetCard({super.key, required this.tweet});

  final Tweet tweet;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(userDetailsProvider(tweet.uid)).when(
      data: (user) {
        return Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.all(10),
                  child: CircleAvatar(
                    radius: 35,
                    backgroundImage: user.profilePic != ''
                        ? NetworkImage(user.profilePic)
                        : null,
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // retweeted
                      Row(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(right: 5),
                            child: Text(
                              user.name,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 19),
                            ),
                          ),
                          Text(
                            '@${user.name} ${timeago.format(tweet.tweetedAt, locale: 'en_short')}',
                            style: const TextStyle(
                                color: Pallete.greyColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 17),
                          ),
                        ],
                      ),
                      HashtagText(text: tweet.text),
                      if (tweet.tweetType == TweetType.image)
                        CarouselImage(
                            imageLinks: tweet.imageLinks as List<String>),
                      if (tweet.link.isNotEmpty) ...[
                        const SizedBox(
                          height: 4,
                        ),
                        AnyLinkPreview(
                          link: 'https://${tweet.link}',
                          displayDirection: UIDirection.uiDirectionHorizontal,
                        ),
                        Container(
                          margin: const EdgeInsets.only(
                            top: 10,
                            right: 20,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TweetIconButton(
                                pathName: AssetsConstants.viewsIcon,
                                text: tweet.commentIds.length.toString(),
                                onTap: () {},
                              ),
                              TweetIconButton(
                                pathName: AssetsConstants.commentIcon,
                                text: (tweet.commentIds.length +
                                        tweet.reShareCount +
                                        tweet.likes.length)
                                    .toString(),
                                onTap: () {},
                              ),
                              TweetIconButton(
                                pathName: AssetsConstants.retweetIcon,
                                text: tweet.reShareCount.toString(),
                                onTap: () {},
                              ),
                              TweetIconButton(
                                pathName: AssetsConstants.likeOutlinedIcon,
                                text: tweet.likes.length.toString(),
                                onTap: () {},
                              ),
                              IconButton(
                                  onPressed: () {},
                                  icon: const Icon(
                                    Icons.share_outlined,
                                    size: 25,
                                    color: Pallete.greyColor,
                                  ))
                            ],
                          ),
                        )
                      ],
                      const SizedBox(
                        height: 1,
                      )
                    ],
                  ),
                )
              ],
            ),
            const Divider(
              color: Pallete.greyColor,
            )
          ],
        );
      },
      error: (error, stackTrace) {
        return ErrorPage(errorMessage: error.toString());
      },
      loading: () {
        return Container();
      },
    );
  }
}
