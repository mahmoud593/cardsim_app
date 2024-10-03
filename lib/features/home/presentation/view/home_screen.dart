import 'package:flutter/material.dart';
import 'package:games_app/features/home/presentation/view/widgets/home_screen_body.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  const Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12),
          child: SafeArea(
            child: HomeScreenBody(),
          ),
        ),
    );
  }
}
