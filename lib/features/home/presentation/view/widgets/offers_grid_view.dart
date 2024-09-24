import 'package:flutter/material.dart';

import 'offers_grid_view_item.dart';

class OffersGridView extends StatelessWidget {
  const OffersGridView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 20,
        clipBehavior: Clip.none,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: MediaQuery.of(context).orientation.index == 0 ? 2 : 3,
          childAspectRatio: 1.4,
          mainAxisSpacing: 55,
          crossAxisSpacing: 0.0,
        ),
        itemBuilder: (context, index) {
          return const Center(child: OffersGridViewItem());
        });
  }
}
