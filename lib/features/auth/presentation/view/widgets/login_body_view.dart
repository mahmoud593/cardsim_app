import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:games_app/core/helper/app_size_config.dart';
import 'package:games_app/features/auth/presentation/view/widgets/create_new_account_button.dart';
import 'package:games_app/features/auth/presentation/view/widgets/forget_password_button.dart';
import 'package:games_app/features/auth/presentation/view/widgets/login_button.dart';
import 'package:games_app/features/auth/presentation/view/widgets/login_with_google_button.dart';
import 'package:games_app/features/splash/preentation/view/widgets/logo_image.dart';
import 'package:games_app/styles/assets/asset_manager.dart';
import 'package:games_app/styles/colors/color_manager.dart';
import 'package:games_app/styles/text_styles/text_styles.dart';
import 'package:games_app/styles/widets/default_button.dart';
import 'package:games_app/styles/widets/default_text_field.dart';

class LoginBodyView extends StatelessWidget {
  const LoginBodyView({super.key});

  @override
  Widget build(BuildContext context) {

    var emailController = TextEditingController();
    var passwordController = TextEditingController();

    return  SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[

          SizedBox(height: MediaQuery.of(context).size.height*.08,),

          const LogoImage(),

          SizedBox(height: MediaQuery.of(context).size.height*.018,),

          Text('تسجيل الدخول :', style: TextStyles.textStyle24Bold),

          SizedBox(height: MediaQuery.of(context).size.height*.038,),

          DefaultTextField(
            validator: (value){
              if(value!.isEmpty){
                return 'البريد الإلكترونى مطلوب';
              }
            },
            keyboardType: TextInputType.emailAddress ,
            fillColor: ColorManager.gray ,
            textInputAction: TextInputAction.done,
            hintText: 'البريد الإلكترونى',
            controller: emailController,


          ),

          SizedBox(height: MediaQuery.of(context).size.height*.028,),

          DefaultTextField(
            validator: (value){
              if(value!.isEmpty){
                return 'كلمة المرور مطلوبه';
              }
            },
            keyboardType: TextInputType.emailAddress ,
            fillColor: ColorManager.gray ,
            textInputAction: TextInputAction.done,
            hintText: 'كلمة السر',
            controller: passwordController,
          ),

          SizedBox(height: MediaQuery.of(context).size.height*.008,),

          const ForgetPasswordButton(),

          SizedBox(height: MediaQuery.of(context).size.height*.028,),

          const LoginButton(),

          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
          ),
          
          Text('او',style: TextStyles.textStyle18Bold,),

          SizedBox(
            height: MediaQuery.of(context).size.height * 0.01,
          ),

          const LoginWithGoogleButton(),

          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
          ),

          const CreateNewAccountButton(),

        ],
      ),
    );
  }
}