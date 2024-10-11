import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:games_app/features/auth/presentation/controller/auth_cubit.dart';
import 'package:games_app/features/auth/presentation/controller/auth_states.dart';
import 'package:games_app/features/auth/presentation/view/widgets/app_logo.dart';
import 'package:games_app/features/auth/presentation/view/widgets/create_new_account_button.dart';
import 'package:games_app/features/auth/presentation/view/widgets/forget_password_button.dart';
import 'package:games_app/features/auth/presentation/view/widgets/login_button.dart';
import 'package:games_app/features/auth/presentation/view/widgets/login_with_google_button.dart';
import 'package:games_app/features/splash/preentation/view/widgets/logo_image.dart';
import 'package:games_app/styles/colors/color_manager.dart';
import 'package:games_app/styles/text_styles/text_styles.dart';
import 'package:games_app/styles/widgets/default_text_field.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginBodyView extends StatelessWidget {
  const LoginBodyView({super.key});

  @override
  Widget build(BuildContext context) {

    return  BlocBuilder<AuthCubit, AuthStates>(
    builder: (context, state) {
      var cubit=AuthCubit.get(context);
      return ModalProgressHUD(
        inAsyncCall: state is LoginLoadingState || state is LoginWithGoogleLoadingState,
        progressIndicator: const CupertinoActivityIndicator(),
        child: Form(
          key: cubit.loginKey,
          child: Column(
            children: <Widget>[

              Container(
                  padding: EdgeInsets.zero,
                  decoration: const BoxDecoration(
                    color: ColorManager.primary,
                  ),
                  height: MediaQuery.sizeOf(context).height*.22,
                  child: Column(
                    children: [
                      SizedBox(height: MediaQuery.of(context).size.height*.06,),
                      const AppLogo(),
                    ],
                  )
              ),

              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width*.05,
                      vertical: MediaQuery.of(context).size.height*.02
                  ),
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(35),
                        topLeft: Radius.circular(35),
                      )
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(height: MediaQuery.of(context).size.height*.018,),

                        Text('تسجيل الدخول', style: TextStyles.textStyle24Bold),

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
                          controller: cubit.emailLoginController,


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
                          viewPassword: true,
                          isPassword: true,
                          withSuffix: true,
                          textInputAction: TextInputAction.done,
                          hintText: 'كلمة السر',
                          controller: cubit.passwordLoginController,
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

                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02,
                        ),

                      ],
                    ),
                  ),
                ),
              ),

            ],
          )
        ),
      );
    },
    );
  }
}