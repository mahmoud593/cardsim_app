import 'package:flutter/material.dart';
import 'package:svg_flutter/svg.dart';

import '../../../../../core/constants/constants.dart';
import '../../../../../styles/colors/color_manager.dart';
import '../../../../../styles/text_styles/text_styles.dart';

class WithdrawsCarousalItem extends StatelessWidget {
  const WithdrawsCarousalItem(
      {super.key,
      required this.image,
      required this.title,
      required this.value});

  final String image;
  final String value;
  final String title;

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
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              image,
              width: 40,
              height: 40,
            ),
            ListTile(
              contentPadding: EdgeInsets.zero,
              minVerticalPadding: 0.0,
              title: Text(
                value,
                style: const TextStyle(
                  fontSize: 25,
                  height: 1,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                title,
                style: TextStyles.textStyle14Medium.copyWith(
                  color: Colors.grey,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
