import 'package:flutter/material.dart';
import 'package:games_app/core/helper/app_size_config.dart';
import 'package:games_app/styles/colors/color_manager.dart';
import 'package:games_app/styles/text_styles/text_styles.dart';

class DefaultButton extends StatelessWidget {
  const DefaultButton(
      {super.key,
      required this.onPressed,
      required this.borderRadius,
      this.backgroundColor=ColorManager.primary,
      this.foregroundColor=Colors.white,
      required this.text,
      this.textStyle,
      this.haveIcon=false,
      this.icon, this.width});

  final void Function()? onPressed;
  final BorderRadiusGeometry borderRadius;

  final Color? backgroundColor;
  final Color? foregroundColor;
  final String text;
  final TextStyle? textStyle;
  final IconData? icon;
  final bool? haveIcon;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: SizeConfig.height*.06,
      width: width,
      child: MaterialButton(
          color: backgroundColor,
          onPressed: onPressed,
          shape: RoundedRectangleBorder(
              borderRadius: borderRadius
          ),
          child: haveIcon==true?
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,color: Colors.white,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                text,
                style: TextStyles.textStyle18Bold.copyWith(
                  color: foregroundColor
                )
              ),
            ],
          ):
          Text(
          text,
          style: TextStyles.textStyle18Bold.copyWith(
              color:foregroundColor
          )
        ),
    ));
  }
}
