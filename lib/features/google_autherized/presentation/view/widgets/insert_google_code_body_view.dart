import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:games_app/core/helper/app_size_config.dart';
import 'package:games_app/core/helper/material_navigation.dart';
import 'package:games_app/core/local/shared_preference/shared_preference.dart';
import 'package:games_app/features/auth/presentation/controller/auth_cubit.dart';
import 'package:games_app/features/auth/presentation/controller/auth_states.dart';
import 'package:games_app/features/auth/presentation/view/screens/login_screen.dart';
import 'package:games_app/features/auth/presentation/view/widgets/app_logo.dart';
import 'package:games_app/features/auth/presentation/view/widgets/create_new_account_button.dart';
import 'package:games_app/features/auth/presentation/view/widgets/forget_password_button.dart';
import 'package:games_app/features/auth/presentation/view/widgets/login_button.dart';
import 'package:games_app/features/auth/presentation/view/widgets/login_with_google_button.dart';
import 'package:games_app/features/bottom_navigation_bar/presentation/view/bottom_navigation_bar.dart';
import 'package:games_app/features/splash/preentation/view/widgets/logo_image.dart';
import 'package:games_app/styles/assets/asset_manager.dart';
import 'package:games_app/styles/colors/color_manager.dart';
import 'package:games_app/styles/text_styles/text_styles.dart';
import 'package:games_app/styles/widgets/default_button.dart';
import 'package:games_app/styles/widgets/default_text_field.dart';
import 'package:games_app/styles/widgets/toast.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class InsertGoogleCodeBodyView extends StatelessWidget {
   InsertGoogleCodeBodyView({super.key});

  TextEditingController codeController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<AuthCubit,AuthStates>(
      builder: (context,state){
        var cubit = AuthCubit.get(context);
        return Column(
          children: <Widget>[

            Container(
                padding: EdgeInsets.zero,
                decoration:  BoxDecoration(
                  color: UserDataFromStorage.themeIsDarkMode ?
                  ColorManager.darkThemeBackground :
                  ColorManager.primary,
                ),
                height: MediaQuery.sizeOf(context).height*.22,
                child: Column(
                  children: [
                    SizedBox(height: MediaQuery.sizeOf(context).height*.04,),
                    Image(
                      image: const AssetImage(AssetManager.authenticityImage),
                      height: SizeConfig.height*.13,
                      width: SizeConfig.height*.25,
                    ),
                  ],
                )
            ),

            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width*.05,
                    vertical: MediaQuery.of(context).size.height*.02
                ),
                decoration: BoxDecoration(
                    color: UserDataFromStorage.themeIsDarkMode ?
                    ColorManager.darkThemeBackgroundLight :
                    Colors.white,
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(35),
                      topLeft: Radius.circular(35),
                    )
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: MediaQuery.of(context).size.height*.05,),

                      Text('Google Authenticator', style: TextStyles.textStyle24Bold),

                      SizedBox(height: MediaQuery.of(context).size.height*.038,),

                      DefaultTextField(
                        validator: (value){
                          if(value!.isEmpty){
                            return 'يرجى إدخال الرمز';
                          }
                        },
                        keyboardType: TextInputType.emailAddress ,
                        fillColor: ColorManager.gray ,
                        textInputAction: TextInputAction.done,
                        hintText: 'الرمز',
                        controller: codeController,


                      ),

                      SizedBox(height: MediaQuery.of(context).size.height*.1,),

                      Container(
                        width: MediaQuery.of(context).size.width*.9,
                        child: DefaultButton(
                            onPressed: () async {
                              await cubit.insertCode(code: codeController.text);
                              // await cubit.getUserInfo(context: context );
                              customPushAndRemoveUntil(context, BottomNavigationScreen());
                            },
                            borderRadius: BorderRadius.circular(12),
                            text: 'تحقق'
                        ),
                      ),

                      SizedBox(height: MediaQuery.of(context).size.height*.028,),

                      Container(
                        width: MediaQuery.of(context).size.width*.9 ,
                        child: DefaultButton(
                            onPressed: (){
                              customPushAndRemoveUntil(context, LoginScreen());
                            },
                            backgroundColor: Colors.red,
                            borderRadius: BorderRadius.circular(12),
                            text: 'تسجيل الخروج'
                        ),
                      ),

                    ],
                  ),
                ),
              ),
            ),

          ],
        );
      },
      listener: (context,state){
        if(state is InsertCodeSuccessState){
          customToast(title: 'Success ', color: ColorManager.primary);
        }
        if(state is InsertCodeErrorState){
          customToast(title: state.error, color: ColorManager.error);
        }
      },
    );
  }
}