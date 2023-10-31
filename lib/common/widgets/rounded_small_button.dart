import 'package:flutter/material.dart';
import 'package:twitter_clone/config/theme/theme.dart';

class RoundedSmallButton extends StatelessWidget {
  const RoundedSmallButton({
    super.key,
    required this.onTap,
    required this.label,
    required this.backgroundColor,
    required this.textColor,
    required this.isLoading,
  });

  final VoidCallback onTap;
  final String label;
  final Color backgroundColor;
  final Color textColor;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            minimumSize: const Size(90, 40),
            splashFactory: InkRipple.splashFactory,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20))),
        onPressed: isLoading ? () {} : onTap,
        child: isLoading
            ? const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 3,
                  color: Pallete.whiteColor,
                ),
              )
            : Text(
                label,
                style: TextStyle(color: textColor, fontSize: 16),
              ));
  }
}
