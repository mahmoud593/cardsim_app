
import 'package:flutter/material.dart';
import 'package:games_app/core/local/shared_preference/shared_preference.dart';
import 'package:games_app/styles/assets/asset_manager.dart';

class LogoImage extends StatelessWidget {
  const LogoImage({super.key});

  @override
  Widget build(BuildContext context) {
    return  Align(
      alignment: Alignment.center,
      child: Image(
        width: MediaQuery.sizeOf(context).width*.3,
        height: MediaQuery.sizeOf(context).height*.1,
        fit: BoxFit.cover,
        image:  AssetImage(
            UserDataFromStorage.themeIsDarkMode? AssetManager.logo : AssetManager.logo
        ),
      ),
    );
  }
}