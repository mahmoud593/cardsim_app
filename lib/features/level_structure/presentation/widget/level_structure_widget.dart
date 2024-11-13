import 'package:flutter/material.dart';
import 'package:games_app/core/constants/constants.dart';
import 'package:games_app/core/local/shared_preference/shared_preference.dart';
import 'package:games_app/styles/colors/color_manager.dart';
import 'package:games_app/styles/text_styles/text_styles.dart';

class LevelStructureWidget extends StatelessWidget {
  const LevelStructureWidget({super.key,required this.index});

  final int index;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        showDialog(context: context, builder:  (context) {
          return AlertDialog(
            actionsAlignment: MainAxisAlignment.center,
            actions: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox( height: MediaQuery.sizeOf(context).height*.02, ),
                  Image(
                    height:  MediaQuery.sizeOf(context).height*.1,
                    width: MediaQuery.sizeOf(context).height*.1,
                    image: const AssetImage('assets/images/rank.png'),
                  ),
                  SizedBox( height: MediaQuery.sizeOf(context).height*.03, ),
                  Text('المستوي : Vip 1',style: TextStyles.textStyle18Medium.copyWith(
                      color:  UserDataFromStorage.themeIsDarkMode? ColorManager.white : ColorManager.black
                  ),),
                  SizedBox( height: MediaQuery.sizeOf(context).height*.022, ),
                  Text('الهدف : 1000',style: TextStyles.textStyle18Medium.copyWith(
                      color:  UserDataFromStorage.themeIsDarkMode? ColorManager.white : ColorManager.black
                  ),),
                  SizedBox( height: MediaQuery.sizeOf(context).height*.022, ),
                  Text('نقطه الامان : 900',style: TextStyles.textStyle18Medium.copyWith(
                      color:  UserDataFromStorage.themeIsDarkMode? ColorManager.white : ColorManager.black
                  ),),
                  SizedBox( height: MediaQuery.sizeOf(context).height*.022, ),
                  Text('الخصم بنسبه % : 0',style: TextStyles.textStyle18Medium.copyWith(
                      color:  UserDataFromStorage.themeIsDarkMode? ColorManager.white : ColorManager.black
                  ),),
                ],
              ),
            ],
          );
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.sizeOf(context).height*.02,
          vertical: MediaQuery.sizeOf(context).height*.02,
        ),
        margin: EdgeInsets.symmetric(
          horizontal: MediaQuery.sizeOf(context).height*.01,
          vertical: MediaQuery.sizeOf(context).height*.003,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: UserDataFromStorage.themeIsDarkMode?  ColorManager.darkThemeBackgroundLight:ColorManager.primary.withOpacity(.8),
        ),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              Image(
                height:  MediaQuery.sizeOf(context).height*.1,
                width: MediaQuery.sizeOf(context).height*.1,
                image: const AssetImage('assets/images/rank.png'),
              ),

              SizedBox( height: MediaQuery.sizeOf(context).height*.02, ),

              Text("Vip ${index+1}",
                style: TextStyles.textStyle24Bold.copyWith(
                    color: UserDataFromStorage.themeIsDarkMode? ColorManager.white : ColorManager.white,
                    fontSize: MediaQuery.sizeOf(context).height*.025
                ),),

            ]
        ),
      ),
    );
  }
}
