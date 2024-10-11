import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:games_app/core/helper/material_navigation.dart';
import 'package:games_app/features/auth/presentation/controller/auth_cubit.dart';
import 'package:games_app/features/auth/presentation/controller/auth_states.dart';
import 'package:games_app/features/bottom_navigation_bar/presentation/view/bottom_navigation_bar.dart';
import 'package:games_app/features/home/presentation/view/home_screen.dart';
import 'package:games_app/styles/colors/color_manager.dart';
import 'package:games_app/styles/widgets/default_button.dart';

class RegisterButton extends StatelessWidget {
  const RegisterButton({super.key,});
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit,AuthStates>(
      listener: (context, state) {
         if(state is CreateAccountSuccessState){
           customPushAndRemoveUntil(context, BottomNavigationScreen());
         }
      },
      builder:  (context, state) {
        var cubit=AuthCubit.get(context);
        return DefaultButton(
          haveIcon: false,
          text: 'انشاء حساب',
          backgroundColor: ColorManager.primary ,
          borderRadius: BorderRadius.circular(12),
          onPressed: (){
            if(cubit.registerKey.currentState!.validate()){
               cubit.createNewAccount(
                  email: cubit.emailRegisterController.text,
                  password: cubit.passwordRegisterController.text,
                  name: cubit.nameRegisterController.text,
                  phone: cubit.phoneRegisterController.text
              );
            }
          },
        );
      }
    );
  }
}
