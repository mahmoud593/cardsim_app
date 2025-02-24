
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:games_app/core/local/shared_preference/shared_preference.dart';
import 'package:games_app/core/services/service_locator.dart';
import 'package:games_app/features/home/presentation/controller/theme_cubit/theme_cubit.dart';
import 'package:games_app/features/notification/presentation/controller/notification_cubit.dart';
import 'package:games_app/features/notification/presentation/controller/notification_states.dart';
import 'package:games_app/features/notification/presentation/widget/notification_view_body.dart';
import 'package:games_app/styles/colors/color_manager.dart';
import 'package:games_app/styles/text_styles/text_styles.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  BlocProvider(
      create: (context) => NotificationCubit(getIt())..getNotification(isLoadMore: true),
      child: BlocConsumer<NotificationCubit,NotificationStates>(
        listener: (context,state){},
        builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                iconTheme: const IconThemeData(
                    color: Colors.white
                ),
                backgroundColor: UserDataFromStorage.themeIsDarkMode? ColorManager.darkThemeBackgroundLight : ColorManager.primary,
                title: Text("الاشعارات",style: TextStyles.textStyle18Bold.copyWith(color: Colors.white),),
                centerTitle: true,
              ),
              body: const NotificationViewBody(),
            );
          }
      ),
    );
  }
}
