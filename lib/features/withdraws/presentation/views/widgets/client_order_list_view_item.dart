import 'package:flutter/material.dart';
import 'package:games_app/features/withdraws/domain/entities/client_order_entity.dart';

import '../../../domain/entities/orders_client_entity.dart';

class ClientOrderListViewItem extends StatelessWidget {
  const ClientOrderListViewItem({
    super.key,
    required this.clientOrderEntity,
    required this.index,
  });

  final OrdersClientEntity clientOrderEntity;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Expanded(
            child: Center(
          child: Text(
            clientOrderEntity.tracking,
          ),
        )),
        Expanded(
            child: Center(
          child: Text(
            clientOrderEntity.orderTotal.toString(),
          ),
        )),
        Expanded(
            child: Center(
              child: Text(
                clientOrderEntity.profit.toString(),
              ),
            )),
        Expanded(
            child: Center(
          child: Text(
            clientOrderEntity.status,
          ),
        )),
      ],
    );
  }
}
