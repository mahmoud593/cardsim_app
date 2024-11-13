
import 'package:flutter/material.dart';
import 'package:games_app/core/local/shared_preference/shared_preference.dart';
import 'package:games_app/features/level_structure/presentation/widget/level_structure_body.dart';
import 'package:games_app/features/notification/presentation/widget/notification_view_body.dart';
import 'package:games_app/styles/colors/color_manager.dart';
import 'package:games_app/styles/text_styles/text_styles.dart';

class LevelStructureScreen extends StatelessWidget {
  const LevelStructureScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
            color: Colors.white
        ),
        backgroundColor: UserDataFromStorage.themeIsDarkMode? ColorManager.darkThemeBackgroundLight : ColorManager.primary,
        title: Text("نظام المستويات",style: TextStyles.textStyle18Bold.copyWith(color: Colors.white),),
        centerTitle: true,
      ),
      body: const LevelStructureBody(),
    );
  }
}
