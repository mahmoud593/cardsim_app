import 'package:flutter/material.dart';
import 'package:games_app/core/constants/constants.dart';
import 'package:games_app/features/level_structure/presentation/widget/level_structure_widget.dart';
import 'package:games_app/features/notification/presentation/widget/notification_item_widget.dart';
import 'package:games_app/styles/colors/color_manager.dart';
import 'package:games_app/styles/text_styles/text_styles.dart';

class LevelStructureBody extends StatelessWidget {
  const LevelStructureBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [

          SizedBox( height: MediaQuery.sizeOf(context).height*.015, ),

          ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return  Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.sizeOf(context).height*.02,
                  ),
                  child: Text('${index+1}- ${Constants.levelTitles[index]}',
                    style: TextStyles.textStyle18Medium.copyWith(color: ColorManager.black),
                  ),
                );
              },
              separatorBuilder: (context, index) => const SizedBox( height: 10, ),
              itemCount: 4
          ),


          SizedBox( height: MediaQuery.sizeOf(context).height*.02, ),

          GridView.count(
            shrinkWrap: true,
            childAspectRatio: 1/.9,
            mainAxisSpacing: 10,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            children: List.generate(6, (index) =>  LevelStructureWidget(index: index,) ),
          ),

          SizedBox( height: MediaQuery.sizeOf(context).height*.02, ),


        ],
      ),
    );
  }
}
