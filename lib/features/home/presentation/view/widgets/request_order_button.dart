import 'package:flutter/material.dart';
import 'package:games_app/styles/widgets/default_button.dart';

class RequestOrderButton extends StatelessWidget {
  const RequestOrderButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: DefaultButton(
          onPressed: () {},
          haveIcon: true ,
          borderRadius: BorderRadius.circular(12),
          icon: Icons.shopping_cart_outlined,
          text: 'إنشاء الطلب'),
    );
  }
}
