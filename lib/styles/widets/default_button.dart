import 'package:flutter/material.dart';
import 'package:games_app/styles/colors/color_manager.dart';
import 'package:games_app/styles/text_styles/text_styles.dart';


class DefaultButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback onPressed;
  double? width;
  final Color buttonColor;

   DefaultButton({
    Key? key,
    required this.buttonText,
    required this.onPressed,
    this.width = double.infinity,
    required this.buttonColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Container(
      height: MediaQuery.sizeOf(context).height*0.065,
      width: MediaQuery.sizeOf(context).width*.8,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(MediaQuery.sizeOf(context).height*0.01),
        gradient: const LinearGradient(
          colors: [
            ColorManager.primary,
            ColorManager.primaryLight,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),

      child: MaterialButton(
        onPressed: onPressed,
        child: Text(
          buttonText,
          style: TextStyles.textStyle18Medium,
        ),
      ),
    );
  }
}

