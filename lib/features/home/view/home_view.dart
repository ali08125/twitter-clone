import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:twitter_clone/common/constants/constants.dart';
import 'package:twitter_clone/config/theme/pallete.dart';
import 'package:twitter_clone/features/tweet/view/create_tweet_view.dart';

class HomeView extends StatefulWidget {
  static route() => MaterialPageRoute(
        builder: (context) => const HomeView(),
      );

  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _page = 0;
  final appBar = UIConstants.appBar();

  void onPageChanged(int index) {
    setState(() {
      _page = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, CreateTweetView.route());
        },
        child: const Icon(
          Icons.add,
          color: Pallete.whiteColor,
          size: 28,
        ),
      ),
      body: IndexedStack(index: _page, children: UIConstants.bottomTabBarPages),
      bottomNavigationBar: CupertinoTabBar(
          currentIndex: _page,
          onTap: onPageChanged,
          backgroundColor: Pallete.backgroundColor,
          items: [
            BottomNavigationBarItem(
                icon: SvgPicture.asset(
              _page == 0
                  ? AssetsConstants.homeFilledIcon
                  : AssetsConstants.homeOutlinedIcon,
              color: Pallete.whiteColor,
            )),
            BottomNavigationBarItem(
                icon: SvgPicture.asset(
              AssetsConstants.searchIcon,
              color: Pallete.whiteColor,
            )),
            BottomNavigationBarItem(
                icon: SvgPicture.asset(
              _page == 2
                  ? AssetsConstants.notifFilledIcon
                  : AssetsConstants.notifOutlinedIcon,
              color: Pallete.whiteColor,
            )),
          ]),
    );
  }
}
