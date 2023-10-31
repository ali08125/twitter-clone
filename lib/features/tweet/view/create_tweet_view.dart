import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:twitter_clone/common/constants/assets_constants.dart';
import 'package:twitter_clone/common/utils/utils.dart';
import 'package:twitter_clone/common/widgets/rounded_small_button.dart';
import 'package:twitter_clone/config/theme/pallete.dart';
import 'package:twitter_clone/features/auth/controller/auth_controller.dart';

class CreateTweetView extends ConsumerStatefulWidget {
  static route() => MaterialPageRoute(
        builder: (context) => const CreateTweetView(),
      );

  const CreateTweetView({super.key});

  @override
  ConsumerState<CreateTweetView> createState() => _CreateTweetViewState();
}

class _CreateTweetViewState extends ConsumerState<CreateTweetView> {
  final tweetTextController = TextEditingController();
  List<File> images = [];

  @override
  void dispose() {
    tweetTextController.dispose();
    super.dispose();
  }

  void onPickImages() async {
    images = await pickImages();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = ref.watch(currentUserDetailsProvider).value;
    return Scaffold(
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
            border:
                Border(top: BorderSide(color: Pallete.greyColor, width: 0.5))),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              GestureDetector(
                  onTap: onPickImages,
                  child: SvgPicture.asset(AssetsConstants.galleryIcon)),
              const SizedBox(
                width: 24,
              ),
              SvgPicture.asset(AssetsConstants.gifIcon),
              const SizedBox(
                width: 24,
              ),
              SvgPicture.asset(AssetsConstants.emojiIcon),
            ],
          ),
        ),
      ),
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: RoundedSmallButton(
                onTap: () {},
                label: 'Tweet',
                backgroundColor: Pallete.blueColor,
                textColor: Pallete.whiteColor,
                isLoading: false),
          )
        ],
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.close,
              size: 30,
            )),
      ),
      body: currentUser == null
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Column(
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundImage: NetworkImage(currentUser.profilePic),
                          radius: 30,
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Expanded(
                          child: TextField(
                            maxLines: null,
                            controller: tweetTextController,
                            style: const TextStyle(fontSize: 22),
                            decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: "What's happening?",
                                hintStyle: TextStyle(
                                    color: Pallete.greyColor,
                                    fontSize: 22,
                                    fontWeight: FontWeight.w600)),
                          ),
                        )
                      ],
                    ),
                    if (images.isNotEmpty)
                      CarouselSlider(
                          items: images.map((file) {
                            return Image.file(
                              file,
                            );
                          }).toList(),
                          options: CarouselOptions(
                              height: 400, enableInfiniteScroll: false))
                  ],
                ),
              ),
            ),
    );
  }
}
