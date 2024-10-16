import 'package:flutter/material.dart';
import 'package:games_app/core/constants/constants.dart';
import 'package:games_app/styles/colors/color_manager.dart';
import 'package:games_app/styles/text_styles/text_styles.dart';

class CouponCardCountWidget extends StatelessWidget {
  final int count ;
  final String title;
  const CouponCardCountWidget({super.key, required this.count, required this.title});

  @override
  Widget build(BuildContext context) {
    bool isLight = Theme.of(context).brightness == Brightness.light;
    return Container(
      width: 250,
      decoration: BoxDecoration(
        color: isLight ? Colors.white : ColorManager.darkThemeBackgroundLight,
        borderRadius: BorderRadius.circular(Constants.defaultRadius),
        border: Border.all(
            color: isLight
                ? const Color(0xffE0E0E0)
                : ColorManager.darkThemeBackgroundLight,
            width: 1),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.only(right: 12),
        title: Text(
          "$count",
          style: const TextStyle(
            fontSize: 25,
            height: 1,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle:
        Text(
            title,
            style: TextStyles.textStyle16Medium,
        ),
        trailing: IconButton(
          icon: const Icon(Icons.card_membership),
          onPressed: () {},
        ),
      ),
    );
  }
}