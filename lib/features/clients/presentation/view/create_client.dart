import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:games_app/core/helper/app_size_config.dart';
import 'package:games_app/features/clients/presentation/cubit/client_cubit.dart';
import 'package:games_app/features/clients/presentation/cubit/client_state.dart';
import 'package:games_app/features/coupons/presentation/cubit/coupons_cubit.dart';
import 'package:games_app/styles/colors/color_manager.dart';
import 'package:games_app/styles/text_styles/text_styles.dart';
import 'package:games_app/styles/widgets/default_button.dart';
import 'package:games_app/styles/widgets/default_text_field.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class CreateClient extends StatelessWidget {
  CreateClient({super.key});

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ClientCubit, ClientState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit=ClientCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'أنشاء عميل جديد',
              style: TextStyles.textStyle24Medium,
            ),
            centerTitle: true,
          ),
          body: ModalProgressHUD(
            inAsyncCall: state is AddClientLoadingState ,
            progressIndicator: const CupertinoActivityIndicator(),
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.height * 0.02),
                child:  Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: SizeConfig.height * 0.05),
              
                      DefaultTextField(
                        controller: cubit.nameController,
                        hintText: 'الاسم',
                        validator: (value) {
                          if(value!.isEmpty){
                            return "برجاء ادخال الاسم";
                          }
                        },
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        fillColor: Colors.transparent,
                      ),
              
                      SizedBox(height: SizeConfig.height * 0.025),
              
                      DefaultTextField(
                        controller: cubit.emailController,
                        hintText: 'الايميل',
                        validator: (value) {
                          if(value!.isEmpty){
                            return "برجاء ادخل الايميل";
                          }
                        },
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        fillColor: Colors.transparent,
                      ),
              
                      SizedBox(height: SizeConfig.height * 0.025),
              
                      DefaultTextField(
                        controller: cubit.phoneController,
                        hintText: 'الهاتف',
                        validator: (value) {
                          if(value!.isEmpty){
                            return "برجاء ادخال الهاتف";

                          }
                        },
                        keyboardType: TextInputType.phone,
                        textInputAction: TextInputAction.next,
                        fillColor: Colors.transparent,
                      ),
              
                      SizedBox(height: SizeConfig.height * 0.025),
              
                      DefaultTextField(
                        controller: cubit.passwordController,
                        hintText: 'الباسورد',
                        validator: (value) {
                          if(value!.isEmpty){
                            return "برجاء ادخال الباسورد";

                          }
                        },
                        keyboardType: TextInputType.visiblePassword,
                        textInputAction: TextInputAction.next,
                        isPassword: true,
                        viewPassword: true,
                        withSuffix: true,
                        fillColor: Colors.transparent,
                      ),
              
                      SizedBox(height: SizeConfig.height * 0.025),
              
                      DefaultTextField(
                        controller: cubit.earningController,
                        hintText: 'إضافة نسبة الربح %',
                        validator: (value) {
                          if(value!.isEmpty){
                            return "برجاء ادخال نسبة الربح";

                          }
                        },
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.next,
                        fillColor: Colors.transparent,
                      ),
              
                      SizedBox(height: SizeConfig.height * 0.025),
              
                      DefaultTextField(
                        controller: cubit.addressController,
                        hintText: 'العنوان (إختياري)',
                        validator: (value) {
                        },
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.done,
                        fillColor: Colors.transparent,
                      ),
              
                      SizedBox(height: SizeConfig.height * 0.025),
              
                      DefaultButton(
                        onPressed: (){
                          if(formKey.currentState!.validate()){
                             cubit.createNewClient(
                                 name: cubit.nameController.text,
                                 email: cubit.emailController.text,
                                 phone: cubit.phoneController.text,
                                 password: cubit.passwordController.text,
                                 earningDistValue: num.parse(cubit.earningController.text
                                 )
                             );
                          }
                        },
                        borderRadius: BorderRadius.circular(SizeConfig.height*0.01),
                        text: "انشاء حساب",
                        backgroundColor: ColorManager.success,
                        haveIcon: false,
                        textStyle: TextStyles.textStyle14Medium.copyWith(
                            color: ColorManager.white
                        ),
                        width: SizeConfig.width,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
