
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:games_app/core/local/shared_preference/shared_preference.dart';
import 'package:games_app/features/level_structure/presentation/controller/level_cubit.dart';
import 'package:games_app/features/level_structure/presentation/controller/level_states.dart';
import 'package:games_app/features/level_structure/presentation/widget/level_structure_body.dart';
import 'package:games_app/features/notification/presentation/widget/notification_view_body.dart';
import 'package:games_app/styles/colors/color_manager.dart';
import 'package:games_app/styles/text_styles/text_styles.dart';

class LevelStructureScreen extends StatefulWidget {
  const LevelStructureScreen({super.key});

  @override
  State<LevelStructureScreen> createState() => _LevelStructureScreenState();
}

class _LevelStructureScreenState extends State<LevelStructureScreen> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  BlocProvider(
      create: (context) => LevelCubit()..getLevelStructure(),
      child: BlocBuilder<LevelCubit,LevelStates>(
        builder: (context,state){
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
        },
      )
    );
  }
}
