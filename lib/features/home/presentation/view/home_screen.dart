import 'package:flutter/material.dart';
import 'package:games_app/features/bottom_navigation_bar/presentation/view/widget/drawer_widget.dart';
import 'package:games_app/features/home/presentation/view/widgets/home_screen_body.dart';
import 'package:games_app/styles/text_styles/text_styles.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return   Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          titleSpacing: 0.0,
          title:  Text('مساء الخير, Mazen Gamal !',style: TextStyles.textStyle18Bold.copyWith(),),
        ),
        drawer: Drawer(
          child: DrawerWidget(),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12),
          child: HomeScreenBody(),
        ),
    );
  }
}
