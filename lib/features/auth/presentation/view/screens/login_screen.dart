import 'package:flutter/material.dart';
import 'package:games_app/features/auth/presentation/view/widgets/login_body_view.dart';


class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body:  Padding(
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width*.1,
          vertical: MediaQuery.of(context).size.height*.05
        ),
        child: const LoginBodyView(),
      ),
    );
  }
}