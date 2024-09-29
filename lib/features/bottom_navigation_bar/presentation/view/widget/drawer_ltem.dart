import 'package:flutter/material.dart';
import 'package:games_app/styles/colors/color_manager.dart';
import 'package:games_app/styles/text_styles/text_styles.dart';

class DrawerItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  const DrawerItem({super.key, required this.title, required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * 0.015, horizontal: MediaQuery.of(context).size.height * 0.02),
        child: Row(
          children: [
            Icon(
              icon,
              color: ColorManager.white,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.02,
            ),
            Text(
              title,
              style: TextStyles.textStyle18Medium.copyWith(color: ColorManager.white),
            ),
          ],
        ),
      ),
    );
  }
}
