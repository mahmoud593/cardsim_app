import 'package:flutter/material.dart';
import 'package:games_app/core/local/shared_preference/shared_preference.dart';
import 'package:games_app/features/auth/presentation/view/widgets/login_body_view.dart';
import 'package:games_app/features/google_autherized/presentation/view/widgets/google_auth_body_view.dart';
import 'package:games_app/features/google_autherized/presentation/view/widgets/insert_google_code_body_view.dart';
import 'package:games_app/styles/colors/color_manager.dart';
import 'package:games_app/styles/text_styles/text_styles.dart';


class GoogleAuthScreen extends StatelessWidget {
  const GoogleAuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: UserDataFromStorage.themeIsDarkMode ?
      ColorManager.darkThemeBackground : ColorManager.primary,
      appBar: AppBar(
        title: Text('Google Authenticator', style: TextStyles.textStyle24Medium),
        backgroundColor: UserDataFromStorage.themeIsDarkMode ?
        ColorManager.darkThemeBackground : ColorManager.primary,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body:  GoogleAuthBodyView(),
    );
  }
}