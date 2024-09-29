import 'package:flutter/material.dart';
import 'package:games_app/core/helper/app_size_config.dart';
import 'package:games_app/styles/assets/asset_manager.dart';
import 'package:games_app/styles/colors/color_manager.dart';
import 'package:games_app/styles/text_styles/text_styles.dart';

class LoginWithGoogleButton extends StatelessWidget {
  const LoginWithGoogleButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: SizeConfig.height*.06,
        width: double.infinity,
        child: MaterialButton(
            color: ColorManager.primary,
            onPressed: (){},
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12)
            ),
            child:  Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                Text(
                    'دخول عن طريق جوجل ',
                    style: TextStyles.textStyle18Bold.copyWith(
                        color: Colors.white
                    )
                ),
                const SizedBox(
                  width: 10,
                ),
                Image(
                  height:  MediaQuery.of(context).size.height * 0.025,
                  image: const AssetImage(AssetManager.googleIcon),
                ),
              ],
            )
        ));
  }
}
