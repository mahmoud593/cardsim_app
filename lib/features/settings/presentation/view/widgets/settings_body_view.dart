import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:games_app/features/auth/presentation/controller/auth_cubit.dart';
import 'package:games_app/features/auth/presentation/controller/auth_states.dart';
import 'package:games_app/styles/assets/asset_manager.dart';
import 'package:games_app/styles/colors/color_manager.dart';
import 'package:games_app/styles/text_styles/text_styles.dart';
import 'package:games_app/styles/widgets/default_button.dart';
import 'package:games_app/styles/widgets/default_text_field.dart';

class SettingsBodyView extends StatelessWidget {
  const SettingsBodyView({super.key});

  @override
  Widget build(BuildContext context) {
    return  BlocBuilder<AuthCubit,AuthStates>(
      builder: (context, state) {
        var cubit = AuthCubit.get(context);
        return SingleChildScrollView(
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
                    return 'كلمة المرور مطلوبه';
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
                    return 'كلمة المرور مطلوبه';
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
                    return 'كلمة المرور مطلوبه';
                  }
                },
                keyboardType: TextInputType.emailAddress ,
                fillColor: ColorManager.gray ,
                textInputAction: TextInputAction.done,
                hintText: 'الهاتف',
                controller: cubit.phoneProfileController,
              ),

              SizedBox(height: MediaQuery.of(context).size.height*.03,),

              Row(
                children: [

                  Switch(value: cubit.userInfoModel!.email_2fa!, onChanged: (v){}),
                  SizedBox(height: MediaQuery.of(context).size.height*.05,),

                  Text('المصادقه الثنائيه',style: TextStyles.textStyle18Bold,),

                ],
              ),

              SizedBox(height: MediaQuery.of(context).size.height*.03,),

              Row(
                children: [

                  Switch(value: cubit.userInfoModel!.google_2fa!, onChanged: (v){}),
                  SizedBox(height: MediaQuery.of(context).size.height*.05,),

                  Text('Google Authenticator',style: TextStyles.textStyle18Bold,),

                ],
              ),

              SizedBox(height: MediaQuery.of(context).size.height*.05,),

              DefaultButton(
                  onPressed: (){},
                  borderRadius: BorderRadius.circular(12),
                  text: 'حفظ البيانات '
              ),

            ],
          ),
        );
      },
    );
  }
}
