
import 'package:flutter/material.dart';
import 'package:games_app/features/notification/presentation/widget/notification_view_body.dart';
import 'package:games_app/styles/colors/color_manager.dart';
import 'package:games_app/styles/text_styles/text_styles.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
            color: Colors.white
        ),
        backgroundColor: ColorManager.primary,
        title: Text("الاشعارات",style: TextStyles.textStyle18Bold.copyWith(color: Colors.white),),
        centerTitle: true,
      ),
      body: const NotificationViewBody(),
    );
  }
}
