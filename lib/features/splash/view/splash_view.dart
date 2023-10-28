import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:twitter_clone/common/constants/assets_constants.dart';
import 'package:twitter_clone/config/theme/theme.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SvgPicture.asset(
          AssetsConstants.twitterLogo,
          color: Pallete.blueColor,
          width: 80,
          height: 80,
        ),
      ),
    );
  }
}
