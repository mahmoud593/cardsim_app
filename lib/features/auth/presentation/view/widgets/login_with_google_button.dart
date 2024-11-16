import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:games_app/core/helper/app_size_config.dart';
import 'package:games_app/core/helper/material_navigation.dart';
import 'package:games_app/features/auth/presentation/controller/auth_cubit.dart';
import 'package:games_app/features/auth/presentation/controller/auth_states.dart';
import 'package:games_app/features/bottom_navigation_bar/presentation/view/bottom_navigation_bar.dart';
import 'package:games_app/styles/assets/asset_manager.dart';
import 'package:games_app/styles/colors/color_manager.dart';
import 'package:games_app/styles/text_styles/text_styles.dart';

class LoginWithGoogleButton extends StatelessWidget {
  const LoginWithGoogleButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit,AuthStates>(
        listener: (context, state) {
           if (state is GetGoogleInfoState) {
             customPushAndRemoveUntil(context, const BottomNavigationScreen());
           }
        },
        builder: (context, state) {
          var cubit=AuthCubit.get(context);
          return SizedBox(
              height: SizeConfig.height*.06,
              width: double.infinity,
              child: MaterialButton(
                  color: ColorManager.primary,
                  onPressed: () async{
                     await cubit.loginWithGoogle(context: context);
                  },
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
        },
    );
  }
}
