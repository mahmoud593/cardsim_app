import 'package:flutter/material.dart';
import 'package:games_app/core/local/shared_preference/shared_preference.dart';
import 'package:games_app/styles/colors/color_manager.dart';
import 'package:games_app/styles/text_styles/text_styles.dart';

class NotificationItemWidget extends StatelessWidget {
  const NotificationItemWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: MediaQuery.sizeOf(context).height*.02,
        vertical: MediaQuery.sizeOf(context).height*.02,
      ),
      margin: EdgeInsets.symmetric(
        horizontal: MediaQuery.sizeOf(context).height*.02,
        vertical: MediaQuery.sizeOf(context).height*.003,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: UserDataFromStorage.themeIsDarkMode?  ColorManager.darkThemeBackgroundLight:ColorManager.gray,
      ),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("تم الاشتراك",
              style: TextStyles.textStyle24Bold.copyWith(
                  color: UserDataFromStorage.themeIsDarkMode? ColorManager.white : ColorManager.primary,
                  fontSize: MediaQuery.sizeOf(context).height*.02
              ),),
            const SizedBox( height: 10, ),
            Text("تم تاكيد عمليه الاشتراك في باكدج pubg",
              style: TextStyles.textStyle24Bold.copyWith(
                  color: UserDataFromStorage.themeIsDarkMode? ColorManager.lightGrey : ColorManager.black,
                  fontSize: MediaQuery.sizeOf(context).height*.014
              ),),

          ]
      ),
    );
  }
}
