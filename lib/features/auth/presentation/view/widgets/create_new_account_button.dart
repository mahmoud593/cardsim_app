import 'package:flutter/material.dart';
import 'package:games_app/styles/text_styles/text_styles.dart';

class CreateNewAccountButton extends StatelessWidget {
  const CreateNewAccountButton({super.key});

  @override
  Widget build(BuildContext context) {
    return  Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
            'ليس لديك حساب؟',
            style: TextStyles.textStyle18Regular.copyWith(
                fontSize: MediaQuery.sizeOf(context).height*.018
            )
        ),
        TextButton(
          onPressed: (){

          },
          child: Text(
              'انشاء حساب جديد',
              style: TextStyles.textStyle18Bold.copyWith(
                  fontSize: MediaQuery.sizeOf(context).height*.018
              )
          ),
        ),

      ],
    );
  }
}
