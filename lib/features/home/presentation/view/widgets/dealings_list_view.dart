import 'package:flutter/material.dart';
import 'package:games_app/features/home/presentation/view/widgets/dealings_list_view_item.dart';

class DealingsListView extends StatelessWidget {
  const DealingsListView({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return const DealingsListViewItem();
          },
          separatorBuilder: (context, index) {
            return const SizedBox(
              width: 16,
            );
          },
          itemCount: 5),
    );
  }
}
