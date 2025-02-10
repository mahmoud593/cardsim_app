import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:games_app/core/local/shared_preference/shared_preference.dart';
import 'package:games_app/features/auth/presentation/controller/auth_cubit.dart';
import 'package:games_app/features/auth/presentation/controller/auth_states.dart';
import 'package:games_app/features/auth/presentation/view/widgets/app_logo.dart';
import 'package:games_app/features/auth/presentation/view/widgets/create_new_account_button.dart';
import 'package:games_app/features/auth/presentation/view/widgets/forget_password_button.dart';
import 'package:games_app/features/auth/presentation/view/widgets/have_an_account.dart';
import 'package:games_app/features/auth/presentation/view/widgets/login_button.dart';
import 'package:games_app/features/auth/presentation/view/widgets/login_with_google_button.dart';
import 'package:games_app/features/auth/presentation/view/widgets/register_button.dart';
import 'package:games_app/features/splash/preentation/view/widgets/logo_image.dart';
import 'package:games_app/styles/colors/color_manager.dart';
import 'package:games_app/styles/text_styles/text_styles.dart';
import 'package:games_app/styles/widgets/default_button.dart';
import 'package:games_app/styles/widgets/default_text_field.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class RegisterViewBody extends StatelessWidget {
  const RegisterViewBody({super.key});

  @override
  Widget build(BuildContext context) {

    return BlocBuilder<AuthCubit,AuthStates>(
      builder:(context, state) {
        var cubit=AuthCubit.get(context);
        return  ModalProgressHUD(
          inAsyncCall: state is CreateAccountLoadingState,
          progressIndicator: CupertinoActivityIndicator(),
          child: Form(
            key: cubit.registerKey,
            child: Column(
              children: <Widget>[

                Container(
                    padding: EdgeInsets.zero,
                    decoration:  BoxDecoration(
                      color: UserDataFromStorage.themeIsDarkMode ? ColorManager.darkThemeBackground : ColorManager.primary,
                    ),
                    height: MediaQuery.sizeOf(context).height*.14,
                    child: const Column(
                      children: [
                        AppLogo(),
                      ],
                    )
                ),

                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width*.05,
                        vertical: MediaQuery.of(context).size.height*.02
                    ),
                    decoration:  BoxDecoration(
                        color: UserDataFromStorage.themeIsDarkMode ? ColorManager.darkThemeBackgroundLight : Colors.white,
                        borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(35),
                          topLeft: Radius.circular(35),
                        )
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(height: MediaQuery.of(context).size.height*.018,),

                          Text('انشاء حساب ', style: TextStyles.textStyle24Bold),

                          SizedBox(height: MediaQuery.of(context).size.height*.038,),

                          DefaultTextField(
                            validator: (value){
                              if(value!.isEmpty){
                                return 'الاسم مطلوب';
                              }
                            },
                            keyboardType: TextInputType.text ,
                            fillColor: ColorManager.gray ,
                            textInputAction: TextInputAction.next,
                            hintText: 'الاسم كامل',
                            controller: cubit.nameRegisterController,


                          ),

                          SizedBox(height: MediaQuery.of(context).size.height*.038,),

                          DefaultTextField(
                            validator: (value){
                              if(value!.isEmpty){
                                return 'البريد الإلكترونى مطلوب';
                              }
                            },
                            keyboardType: TextInputType.emailAddress ,
                            fillColor: ColorManager.gray ,
                            textInputAction: TextInputAction.next,
                            hintText: 'البريد الإلكترونى',
                            controller: cubit.emailRegisterController,


                          ),

                          SizedBox(height: MediaQuery.of(context).size.height*.038,),

                          DefaultTextField(
                            validator: (value){
                              if(value!.isEmpty){
                                return 'الهاتف مطلوب';
                              }
                            },
                            keyboardType: TextInputType.phone ,
                            fillColor: ColorManager.gray ,
                            textInputAction: TextInputAction.next,
                            hintText: 'الهاتف',
                            controller: cubit.phoneRegisterController,


                          ),

                          SizedBox(height: MediaQuery.of(context).size.height*.028,),

                          DefaultTextField(
                            validator: (value){
                              if(value!.isEmpty){
                                return 'كلمة المرور مطلوبه';
                              }
                            },
                            keyboardType: TextInputType.visiblePassword ,
                            fillColor: ColorManager.gray ,
                            viewPassword: true,
                            isPassword: true,
                            withSuffix: true,
                            textInputAction: TextInputAction.next,
                            hintText: 'كلمة السر',
                            controller: cubit.passwordRegisterController,
                          ),

                          SizedBox(height: MediaQuery.of(context).size.height*.028,),

                          DefaultTextField(
                            validator: (value){
                              if(value!.isEmpty){
                                return 'كلمة المرور مطلوبه';
                              }
                            },
                            keyboardType: TextInputType.visiblePassword ,
                            fillColor: ColorManager.gray ,
                            viewPassword: true,
                            isPassword: true,
                            withSuffix: true,
                            textInputAction: TextInputAction.done,
                            hintText: 'اعاده كلمة السر',
                            controller: cubit.password2RegisterController,
                          ),

                          SizedBox(height: MediaQuery.of(context).size.height*.048,),

                          const RegisterButton(),

                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02,
                          ),

                          const HaveAnAccount(),

                        ],
                      ),
                    ),
                  ),
                ),

              ],
            ),
          ),
        );
      },
    );
  }
}