import 'package:flutter/material.dart';
import 'package:games_app/core/local/shared_preference/shared_preference.dart';
import 'package:games_app/features/home/domain/entities/notification_entity.dart';
import 'package:games_app/styles/colors/color_manager.dart';
import 'package:games_app/styles/text_styles/text_styles.dart';

class NotificationItemWidget extends StatelessWidget {
  const NotificationItemWidget({super.key,required this.notificationEntity});

  final NotificationEntity notificationEntity ;

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
      child: Row(
        children: [

          Stack(
            children: [
              CircleAvatar(
                radius:  MediaQuery.sizeOf(context).height*.03,
                backgroundImage: NetworkImage(notificationEntity.data.image),
              ),
              notificationEntity.data.status=='rejected'?
              const Positioned(
                bottom: 0,
                child: Image(
                  height: 20,
                  color: Colors.red,
                  image: AssetImage('assets/images/dislike.png'),
                ),
              ): const Positioned(
                bottom: 0,
                child: Image(
                  height: 20,
                  color: Colors.green,
                  image: AssetImage('assets/images/like.png'),
                ),
              )
            ],
          ),
          SizedBox(width: MediaQuery.sizeOf(context).height*.02,),
          Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(notificationEntity.data.title,
                  style: TextStyles.textStyle24Bold.copyWith(
                      color: UserDataFromStorage.themeIsDarkMode? ColorManager.white : ColorManager.primary,
                      fontSize: MediaQuery.sizeOf(context).height*.02
                  ),),
                const SizedBox( height: 10, ),
                Text(notificationEntity.data.data,
                  style: TextStyles.textStyle24Bold.copyWith(
                      color: UserDataFromStorage.themeIsDarkMode? ColorManager.lightGrey : ColorManager.black,
                      fontSize: MediaQuery.sizeOf(context).height*.014
                  ),),
                const SizedBox( height: 10, ),
              ]
          ),
        ],
      ),
    );
  }
}
