import 'package:flutter/material.dart';
import 'package:games_app/core/helper/material_navigation.dart';
import 'package:games_app/features/auth/presentation/view/screens/login_screen.dart';
import 'package:games_app/features/auth/presentation/view/screens/register_screen.dart';
import 'package:games_app/styles/text_styles/text_styles.dart';

class HaveAnAccount extends StatelessWidget {
  const HaveAnAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return  Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
            'لديك حساب؟',
            style: TextStyles.textStyle18Regular.copyWith(
                fontSize: MediaQuery.sizeOf(context).height*.018
            )
        ),
        TextButton(
          onPressed: (){
            customPushNavigator(context,LoginScreen());
          },
          child: Text(
              'تسجيل الدخول',
              style: TextStyles.textStyle18Bold.copyWith(
                  fontSize: MediaQuery.sizeOf(context).height*.018
              )
          ),
        ),

      ],
    );
  }
}
