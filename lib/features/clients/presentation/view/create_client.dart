import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:games_app/core/constants/urls.dart';
import 'package:games_app/core/helper/app_size_config.dart';
import 'package:games_app/core/local/shared_preference/shared_preference.dart';
import 'package:games_app/core/network/dio_helper.dart';
import 'package:games_app/features/clients/presentation/cubit/client_cubit.dart';
import 'package:games_app/features/clients/presentation/cubit/client_state.dart';
import 'package:games_app/features/coupons/presentation/cubit/coupons_cubit.dart';
import 'package:games_app/styles/colors/color_manager.dart';
import 'package:games_app/styles/text_styles/text_styles.dart';
import 'package:games_app/styles/widgets/default_button.dart';
import 'package:games_app/styles/widgets/default_text_field.dart';
import 'package:games_app/styles/widgets/toast.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../../../core/network/api_handle/urls.dart';

class CreateClient extends StatefulWidget {
  CreateClient({super.key});

  @override
  State<CreateClient> createState() => _CreateClientState();
}

class _CreateClientState extends State<CreateClient> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ClientCubit, ClientState>(
      listener: (context, state) {
        if(state is AddClientSuccessState){
           Navigator.pop(context);
        }
        if(state is AddClientErrorState){
          customToast(title: 'الاسم او الايميل مسجل بالفعل', color: ColorManager.error);
        }
      },
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

                      Visibility(
                          visible: UserDataFromStorage.distCustomEarning==true,
                          child: SizedBox(height: SizeConfig.height * 0.025)
                      ),

                      Visibility(
                        visible: UserDataFromStorage.distCustomEarning==true,
                        child: DefaultTextField(
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
                             setState(() {

                             });
                             createNewClient(
                                 name: cubit.nameController.text,
                                 email: cubit.emailController.text,
                                 phone: cubit.phoneController.text,
                                 password: cubit.passwordController.text,
                                 earningDistValue:cubit.earningController.text == '' ? 0 : num.parse(cubit.earningController.text),
                                 context: context
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


Future<void> createNewClient({
  required String name,
  required String email,
  required String phone,
  required String password,
  required num earningDistValue,
  required BuildContext context

}) async {


  try{

    Map<String, dynamic> parameter={};
    if(earningDistValue!=0){
      parameter =
      {
        "name" : name,
        "email" : email,
        "phone" : phone,
        "earning_dist_value": earningDistValue,
        "password" : password
      };
    }else{
      parameter =
      {
        "name" : name,
        "email" : email,
        "phone" : phone,
        "password" : password
      };
    }


    var response = await
    DioHelper.postData(
      url: 'https://cardsim.net/api/dist/clients/create',
      authorization: true,
      body: parameter
    );


    customToast(title: response.data['message_ar'], color: ColorManager.primary);

    ClientCubit.get(context).getAllClients();
    Navigator.pop(context);


  }on DioException catch(error){
    final responseData = error.response!.data;

    if (responseData is Map<String, dynamic> && responseData.containsKey('errors')) {
      final errors = responseData['errors'];

      String errorMessage = '';

      if (errors.containsKey('password')) {
        errorMessage += 'يجب أن يكون طول كلمه المرور على الأقل 8 حروفٍ/حرفًا ';
      }
      if (errors.containsKey('email')) {
        errorMessage += 'البريد الإلكتروني مستخدم من قبل.';
      }
      if (errors.containsKey('name')) {
        errorMessage += 'الاسم مستخدم من قبل.';
      }

      customToast(title: '${errorMessage.trim()}', color: Colors.red);
    } else {
      print('حدث خطأ أثناء التسجيل.');
    }
    print('Error in add clients is : ${error.response!.data!}');
  }


}


