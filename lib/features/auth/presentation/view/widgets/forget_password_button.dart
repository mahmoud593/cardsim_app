
import 'package:flutter/material.dart';
import 'package:games_app/styles/text_styles/text_styles.dart';

class ForgetPasswordButton extends StatelessWidget {
  const ForgetPasswordButton({super.key});

  @override
  Widget build(BuildContext context) {
    return  Align(
      alignment: AlignmentDirectional.centerEnd,
      child: TextButton(
        onPressed: (){

        },
        child: Text(
            'نسيت كلمة السر؟',
            style: TextStyles.textStyle18Bold
        ),
      ),
    );
  }
}
