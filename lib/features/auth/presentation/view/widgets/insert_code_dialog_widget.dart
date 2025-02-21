import 'package:flutter/material.dart';
import 'package:games_app/core/local/shared_preference/shared_preference.dart';
import 'package:games_app/styles/colors/color_manager.dart';
import 'package:games_app/styles/text_styles/text_styles.dart';
import 'package:games_app/styles/widgets/default_button.dart';
import 'package:games_app/styles/widgets/default_text_field.dart';

Future<dynamic> insertCodeDialogWidget({
  required BuildContext context,
  required TextEditingController controller
}){ {
  return showDialog(
      context: context,
      builder: (context) => AlertDialog(
          backgroundColor:  UserDataFromStorage.themeIsDarkMode ?
          ColorManager.darkThemeBackgroundLight :
          ColorManager.secondPrimary,
          title:  Text(
            'Insert Code',
            style: TextStyles.textStyle18Bold,
          ),
        content:  Container(
          child: Column(
            children: [
              DefaultTextField(
                  controller: controller,
                  hintText: 'Enter Code',
                  validator: (value) {

                  },
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.done,
                  fillColor: ColorManager.gray
              ),
            ],
          ) ,
        ) ,
        actions: [
           DefaultButton(
               onPressed: (){},
               borderRadius: BorderRadius.circular(10),
               text: 'Insert',
           ),
          DefaultButton(
            onPressed: (){},
            borderRadius: BorderRadius.circular(10),
            text: 'Exit',
          ),
        ],
      ),
  );
}
}