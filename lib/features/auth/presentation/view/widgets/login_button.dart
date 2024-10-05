import 'package:flutter/material.dart';
import 'package:games_app/core/helper/material_navigation.dart';
import 'package:games_app/features/home/presentation/view/home_screen.dart';
import 'package:games_app/styles/colors/color_manager.dart';
import 'package:games_app/styles/widgets/default_button.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultButton(
      haveIcon: false,
      text: 'تسجيل الدخول',
      backgroundColor: ColorManager.primary ,
      borderRadius: BorderRadius.circular(12),
      onPressed: (){
        customPushNavigator(context, const HomeScreen());
      },
    );
  }
}
