import 'package:flutter/material.dart';
import 'package:games_app/features/notification/presentation/widget/notification_item_widget.dart';

class NotificationViewBody extends StatelessWidget {
  const NotificationViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [

          SizedBox( height: MediaQuery.sizeOf(context).height*.02, ),

          ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return const NotificationItemWidget();
              },
              separatorBuilder: (context, index) => const SizedBox( height: 10, ),
              itemCount: 25
          ),

        ],
      ),
    );
  }
}
