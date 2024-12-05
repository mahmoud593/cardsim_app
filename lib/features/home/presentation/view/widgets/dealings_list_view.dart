import 'package:flutter/material.dart';
import 'package:games_app/core/local/shared_preference/shared_preference.dart';
import 'package:games_app/features/home/presentation/view/widgets/dealings_list_view_item.dart';

class DealingsListView extends StatelessWidget {
  const DealingsListView({super.key});

  @override
  Widget build(BuildContext context) {
    // List of items
    final items = [
      DealingsListViewItem(
          value:
              '\$ ${UserDataFromStorage.balanceFromStorage.toStringAsFixed(2)}',
          title: 'الرصيد'),
      DealingsListViewItem(
          value: '${UserDataFromStorage.orderWaiting}',
          title: 'الطلبات قيد الانتظار'),
      DealingsListViewItem(
          value: '${UserDataFromStorage.progressWaiting} ',
          title: 'عمليات مكتمله'),
      DealingsListViewItem(
          value: '${UserDataFromStorage.orderRefuse}', title: 'طلبات مرفوضه'),
      DealingsListViewItem(
          value: '${UserDataFromStorage.allOrders}', title: 'جميع الطلبات'),
    ];

    return SizedBox(
      height: 80,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        separatorBuilder: (context, index) => const SizedBox(
          width: 8,
        ),
        itemBuilder: (context, index) {
          return items[index];
        },
      ),
    );
  }
}

/*SizedBox(
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
    )*/
