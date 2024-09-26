import 'package:flutter/material.dart';
import 'package:games_app/styles/colors/color_manager.dart';

class DefaultButton extends StatelessWidget {
  const DefaultButton(
      {super.key,
      required this.onPressed,
      required this.borderRadius,
      this.backgroundColor,
      this.foregroundColor,
      required this.text,
      this.textStyle,
      this.icon});

  final void Function()? onPressed;
  final BorderRadiusGeometry borderRadius;

  final Color? backgroundColor;
  final Color? foregroundColor;
  final String text;
  final TextStyle? textStyle;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(borderRadius: borderRadius),
              backgroundColor: ColorManager.primary,
              foregroundColor: Colors.white),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 23,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                text,
                style: const TextStyle(
                  fontSize: 14,
                ),
              ),
            ],
          )),
    );
  }
}
