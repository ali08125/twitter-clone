import 'package:flutter/material.dart';
import 'package:twitter_clone/config/theme/theme.dart';

class RoundedSmallButton extends StatelessWidget {
  const RoundedSmallButton(
      {super.key,
      required this.onTap,
      required this.label,
      required this.backgroundColor,
      required this.textColor,
      required this.isLoading});

  final VoidCallback onTap;
  final String label;
  final Color backgroundColor;
  final Color textColor;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      splashFactory: InkRipple.splashFactory,
      child: Chip(
        backgroundColor: backgroundColor,
        label: isLoading
            ? const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 3,
                  color: Pallete.whiteColor,
                ),
              )
            : Text(
                label,
                style: TextStyle(color: textColor, fontSize: 16),
              ),
        labelPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      ),
    );
  }
}
