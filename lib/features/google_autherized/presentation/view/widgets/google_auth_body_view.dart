import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:games_app/core/helper/app_size_config.dart';
import 'package:games_app/core/helper/material_navigation.dart';
import 'package:games_app/core/local/cashe_helper/cashe_helper.dart';
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
import 'package:otp/otp.dart';
import 'package:qr_flutter/qr_flutter.dart';


class GoogleAuthBodyView extends StatefulWidget {
  GoogleAuthBodyView({super.key});

  @override
  State<GoogleAuthBodyView> createState() => _GoogleAuthBodyViewState();
}

class _GoogleAuthBodyViewState extends State<GoogleAuthBodyView> {
  TextEditingController codeController = TextEditingController();

  String secretKey = CashHelper.getData(key: UserDataFromStorage.emailFromStorage);
  String accountName =  UserDataFromStorage.emailFromStorage;
  String issuer = "Cardsim"; // اسم التطبيق الخاص بك

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController randomCodeController = TextEditingController();

  String generateGoogleAuthUrl(String secretKey, String accountName, String issuer) {
    return "otpauth://totp/$issuer:$accountName?secret=$secretKey&issuer=$issuer&algorithm=SHA1&digits=6&period=30";
  }

  String otpAuthUrl='';
  @override
  void initState() {
    super.initState();
     otpAuthUrl = generateGoogleAuthUrl(secretKey, accountName, issuer);
    randomCodeController.text=secretKey;
  }


  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<AuthCubit,AuthStates>(
      builder: (context,state){
        print('state is $otpAuthUrl');
        var cubit = AuthCubit.get(context);
        return Form(
          key: formKey,
          child: Column(
            children: <Widget>[

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

                        Text('يرجي تحميل التطبيق و التقاط الرمز', style: TextStyles.textStyle24Bold),

                        SizedBox(height: MediaQuery.of(context).size.height*.02,),

                        Container(
                          clipBehavior: Clip.antiAliasWithSaveLayer ,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12)
                          ),
                          height: SizeConfig.height*.2 ,
                          child: Center(
                            child: Container(
                              padding: EdgeInsets.all(16),
                              child: QrImageView(
                                data: otpAuthUrl,
                                version: QrVersions.auto,
                                size: SizeConfig.height*.14,
                                backgroundColor: UserDataFromStorage.themeIsDarkMode? ColorManager.gray : ColorManager.gray,
                              ),
                            ),
                          ),
                        ),

                        SizedBox(height: MediaQuery.of(context).size.height*.02,),

                        Text('او', style: TextStyles.textStyle24Bold),

                        SizedBox(height: MediaQuery.of(context).size.height*.02,),

                        Row(
                          children: [

                            Expanded(
                              child: DefaultTextField(
                                  enable:false,
                                  controller: randomCodeController,
                                  hintText: '',
                                  validator: (value){
                              
                                  },
                                  keyboardType: TextInputType.text,
                                  textInputAction: TextInputAction.done,
                                  fillColor: ColorManager.gray
                              ),
                            ),

                            SizedBox(width: MediaQuery.of(context).size.width*.02,),

                            DefaultButton(
                                onPressed: (){
                                  Clipboard.setData(ClipboardData(text: secretKey));
                                  customToast(title: 'تم نسخ الرمز', color: ColorManager.primary);
                                },
                                borderRadius: BorderRadius.circular(12),
                                text: 'نسخ'
                            )
                            
                          ],
                        ),

                        SizedBox(height: MediaQuery.of(context).size.height*.05,),

                        Align(
                            alignment: Alignment.topRight,
                            child: Text('ادخال الرمز', style: TextStyles.textStyle24Bold)
                        ),

                        SizedBox(height: MediaQuery.of(context).size.height*.012,),

                        DefaultTextField(
                          validator: (value){
                            if(value!.isEmpty){
                              return 'يرجى إدخال الرمز';
                            }
                          },
                          keyboardType: TextInputType.emailAddress ,
                          fillColor: ColorManager.gray ,
                          textInputAction: TextInputAction.done,
                          hintText: 'الرمز ',
                          controller: codeController,


                        ),

                        SizedBox(height: MediaQuery.of(context).size.height*.06,),

                        Container(
                          width: MediaQuery.of(context).size.width*.9,
                          child: DefaultButton(
                              onPressed: () async {
                                if(formKey.currentState!.validate()){
                                  await cubit.enableGoogleAuth( code: codeController.text,context: context);
                                }
                              },
                              borderRadius: BorderRadius.circular(12),
                              text: 'تحقق'
                          ),
                        ),

                      ],
                    ),
                  ),
                ),
              ),

            ],
          ),
        );
      },
      listener: (context,state){
        if(state is EnableGoogleAuthSuccessState){
        }
        if(state is InsertCodeErrorState){
          customToast(title: state.error, color: ColorManager.error);
        }
      },
    );
  }
}