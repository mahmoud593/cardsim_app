import 'package:flutter/material.dart';
import 'package:games_app/features/home/presentation/view/widgets/request_order_grid_view_item.dart';

class RequestOrderGridView extends StatelessWidget {
  const RequestOrderGridView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 5,
          clipBehavior: Clip.none,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: MediaQuery.of(context).orientation.index == 0 ? 2 : 3,
            childAspectRatio: 1.1,
            mainAxisSpacing: 10,

          ),
          itemBuilder: (context, index) {
            return const Center(child: RequestOrderListViewItem());
          }),
    );
  }
}