import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:games_app/features/auth/presentation/controller/auth_cubit.dart';
import 'package:games_app/features/auth/presentation/controller/auth_states.dart';
import 'package:games_app/features/auth/presentation/view/widgets/forget_password_body.dart';
import 'package:games_app/styles/colors/color_manager.dart';
import 'package:games_app/styles/text_styles/text_styles.dart';
import 'package:games_app/styles/widgets/default_button.dart';
import 'package:games_app/styles/widgets/default_text_field.dart';

class ForgetPassword extends StatelessWidget {
   ForgetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("نسيت كلمة المرور",style: TextStyles.textStyle18Medium,),
        centerTitle: true,),
      body: ForgetPasswordBody()
    );
  }
}
