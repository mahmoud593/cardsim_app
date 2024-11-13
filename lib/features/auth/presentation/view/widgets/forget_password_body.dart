import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:games_app/features/auth/presentation/controller/auth_cubit.dart';
import 'package:games_app/features/auth/presentation/controller/auth_states.dart';
import 'package:games_app/styles/colors/color_manager.dart';
import 'package:games_app/styles/text_styles/text_styles.dart';
import 'package:games_app/styles/widgets/default_button.dart';
import 'package:games_app/styles/widgets/default_text_field.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class ForgetPasswordBody extends StatelessWidget {
  ForgetPasswordBody({super.key});

  TextEditingController emailController = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit,AuthStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AuthCubit.get(context);
        return ModalProgressHUD(
          inAsyncCall: state is ForgetPasswordLoadingState,
          progressIndicator: const CupertinoActivityIndicator(),
          child: Container(
            padding:  EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width*.05
            ),
            child: Column(
              crossAxisAlignment:  CrossAxisAlignment.start,
              children: [

                SizedBox(height: MediaQuery.sizeOf(context).height*.05),

                Text(
                  "ادخل بريدك الالكتروني لاستعادة كلمة المرور",
                  style: TextStyles.textStyle18Medium,
                ),

                SizedBox(height: MediaQuery.sizeOf(context).height*.02),

                DefaultTextField(
                  controller: emailController,
                  hintText: 'البريد الالكتروني',
                  validator: (value) {
                    if(value!.isEmpty){
                      return 'برجاء ادخال البريد الالكتروني';
                    }
                  },
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.done,
                  fillColor: ColorManager.gray ,
                ),

                SizedBox(height: MediaQuery.sizeOf(context).height*.1),

                DefaultButton(
                  onPressed: ()=>cubit.forgetPassword(email: emailController.text),
                  backgroundColor: ColorManager.primary ,
                  borderRadius: BorderRadius.circular(12) ,
                  text: 'ارسال',
                  width:  double.infinity,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
