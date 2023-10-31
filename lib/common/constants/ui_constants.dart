import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:twitter_clone/config/theme/pallete.dart';

import 'assets_constants.dart';

class UIConstants {
  static AppBar appBar() {
    return AppBar(
      centerTitle: true,
      title: SvgPicture.asset(
        AssetsConstants.twitterLogo,
        color: Pallete.blueColor,
        height: 30,
      ),
    );
  }

  static List<Widget> bottomTabBarPages = [
    const Text('feed screen'),
    const Text('search screen'),
    const Text('notification screen'),
  ];
}
