import 'package:flutter/material.dart';
import 'package:twitter_clone/config/theme/pallete.dart';

class HashtagText extends StatelessWidget {
  const HashtagText({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    final List<TextSpan> textSpans = [];
    text.split(' ').forEach((element) {
      if (element.startsWith('#')) {
        textSpans.add(TextSpan(
            text: '$element ',
            style: const TextStyle(
                color: Pallete.blueColor,
                fontSize: 18,
                fontWeight: FontWeight.bold)));
      } else if (element.startsWith('www.') || element.startsWith('https://')) {
        textSpans.add(TextSpan(
            text: '$element ',
            style: const TextStyle(
              color: Pallete.blueColor,
              fontSize: 18,
            )));
      } else {
        textSpans.add(TextSpan(
            text: '$element ',
            style: const TextStyle(
              fontSize: 18,
            )));
      }
    });
    return RichText(text: TextSpan(children: textSpans));
  }
}
