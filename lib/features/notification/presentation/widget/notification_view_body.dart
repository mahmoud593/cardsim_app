import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:games_app/features/notification/presentation/controller/notification_cubit.dart';
import 'package:games_app/features/notification/presentation/controller/notification_states.dart';
import 'package:games_app/features/notification/presentation/widget/notification_item_widget.dart';

class NotificationViewBody extends StatelessWidget {
  const NotificationViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [

          SizedBox( height: MediaQuery.sizeOf(context).height*.02, ),

          BlocBuilder<NotificationCubit, NotificationStates>(
            builder:  (context, state) {
              var cubit = context.read<NotificationCubit>();
              return NotificationListener<ScrollNotification>(
                onNotification: (ScrollNotification scrollInfo) {
                  if(scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
                    cubit.getNotification(isLoadMore: true);
                  }
                  return true;
                },
                child: ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return  NotificationItemWidget(notificationEntity: cubit.notifications[index],);
                    },
                    separatorBuilder: (context, index) => const SizedBox( height: 10, ),
                    itemCount: cubit.notifications.length
                ),
              );
            },
          )

        ],
      ),
    );
  }
}
