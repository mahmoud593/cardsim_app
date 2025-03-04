import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:games_app/core/helper/material_navigation.dart';
import 'package:games_app/core/local/shared_preference/shared_preference.dart';
import 'package:games_app/features/auth/presentation/controller/auth_cubit.dart';
import 'package:games_app/features/auth/presentation/controller/auth_states.dart';
import 'package:games_app/features/auth/presentation/view/screens/login_screen.dart';
import 'package:games_app/features/bottom_navigation_bar/presentation/cubit/bottom_nav_cubit.dart';
import 'package:games_app/features/google_autherized/presentation/view/screens/google_auth_screen.dart';
import 'package:games_app/styles/assets/asset_manager.dart';
import 'package:games_app/styles/colors/color_manager.dart';
import 'package:games_app/styles/text_styles/text_styles.dart';
import 'package:games_app/styles/widgets/default_button.dart';
import 'package:games_app/styles/widgets/default_text_field.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class SettingsBodyView extends StatefulWidget {
  const SettingsBodyView({super.key});

  @override
  State<SettingsBodyView> createState() => _SettingsBodyViewState();
}

class _SettingsBodyViewState extends State<SettingsBodyView> {
  bool isSwitched = false;

  @override
  void initState() {
    super.initState();
    isSwitched=AuthCubit.get(context).userInfoModel!.google_2fa!;
  }

  @override
  Widget build(BuildContext context) {
    return  BlocBuilder<AuthCubit,AuthStates>(
      builder: (context, state) {
        var cubit = AuthCubit.get(context);
        return cubit.userInfoModel != null ?
        SingleChildScrollView(
          child: Column(
            children: [

              SizedBox(height: MediaQuery.of(context).size.height*.05,),

              const Image(
                image: AssetImage(AssetManager.logo),
              ),

              SizedBox(height: MediaQuery.of(context).size.height*.05,),

              DefaultTextField(
                validator: (value){
                  if(value!.isEmpty){
                    return 'الاسم مطلوب';
                  }
                },
                keyboardType: TextInputType.emailAddress ,
                fillColor: ColorManager.gray ,
                textInputAction: TextInputAction.done,
                hintText: 'الاسم الكامل',
                controller: cubit.nameProfileController,
              ),


              SizedBox(height: MediaQuery.of(context).size.height*.025,),

              DefaultTextField(
                validator: (value){
                  if(value!.isEmpty){
                    return 'البريد الالكتروني مطلوب';
                  }
                },
                keyboardType: TextInputType.emailAddress ,
                fillColor: ColorManager.gray ,
                textInputAction: TextInputAction.done,
                hintText: 'البريد الالكتروني',
                controller: cubit.emailProfileController,
              ),


              SizedBox(height: MediaQuery.of(context).size.height*.025,),

              DefaultTextField(
                validator: (value){
                  if(value!.isEmpty){
                    return 'الهاتف مطلوب';
                  }
                },
                keyboardType: TextInputType.phone ,
                fillColor: ColorManager.gray ,
                textInputAction: TextInputAction.done,
                hintText: 'الهاتف',
                controller: cubit.phoneProfileController,
              ),

              /// المصداقه الثنائيه
              // SizedBox(height: MediaQuery.of(context).size.height*.03,),
              //
              // Row(
              //   children: [
              //
              //     Switch(value: cubit.userInfoModel!.email_2fa!, onChanged: (v){}),
              //     SizedBox(height: MediaQuery.of(context).size.height*.05,),
              //
              //     Text('المصادقه الثنائيه',style: TextStyles.textStyle18Bold,),
              //
              //   ],
              // ),

              SizedBox(height: MediaQuery.of(context).size.height*.03,),

              Row(
                children: [

                  Switch(
                      value: isSwitched,
                      onChanged: (v){
                        print('google 2fa: ${isSwitched}');
                        if(isSwitched==false){
                          customPushNavigator(context, GoogleAuthScreen());
                        }else{
                          setState(() {
                            isSwitched=false;
                          });
                        }
                  }),


                  SizedBox(height: MediaQuery.of(context).size.height*.05,),

                  Text('Google Authenticator',style: TextStyles.textStyle18Bold,),

                ],
              ),

              SizedBox(height: MediaQuery.of(context).size.height*.05,),


              state is UpdateUserLoadingState?
              const Center(
                child: CircularProgressIndicator(),
              ):
              DefaultButton(
                  width: double.infinity,
                  onPressed: (){
                    cubit.updateUserInfo(
                        phone: cubit.phoneProfileController.text,
                        google_2fa: isSwitched,
                    );
                  },
                  borderRadius: BorderRadius.circular(12),
                  text: 'حفظ البيانات '
              ),

              SizedBox(height: MediaQuery.of(context).size.height*.03,),

              DefaultButton(
                  width: double.infinity,
                  onPressed: ()async{

                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            backgroundColor: UserDataFromStorage.themeIsDarkMode ?
                            ColorManager.darkThemeBackground :
                            ColorManager.gray,
                            title: const Text('حذف الحساب'),
                            content: const Text('هل تريد حذف الحساب؟'),
                            actions: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: DefaultButton(
                                        backgroundColor: Colors.red,
                                        onPressed: () async {
                                          await BottomNavCubit.get(context).deleteAccount();
                                          customPushAndRemoveUntil(context, const LoginScreen());
                                        },
                                        borderRadius: BorderRadius.circular(12),
                                        text: 'نعم'
                                    ),
                                  ),
                                  SizedBox(width: MediaQuery.of(context).size.width*.05,),
                                  Expanded(
                                    child: DefaultButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        borderRadius: BorderRadius.circular(12),
                                        text: 'لا'
                                    ),
                                  ),
                                ],
                              ),
                          ]);
                        }
                    );
                  },
                  backgroundColor: Colors.red,
                  borderRadius: BorderRadius.circular(12),
                  text: 'حذف الحساب '
              ),

            ],
          ),
        ):
        Expanded(
          child: Container(
            alignment: Alignment.center,
            child: const CupertinoActivityIndicator(
              color: ColorManager.primary,
            ),
          ),
        );
      },
    );
  }
}
