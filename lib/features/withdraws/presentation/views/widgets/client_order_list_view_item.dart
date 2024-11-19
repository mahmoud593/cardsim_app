import 'package:flutter/material.dart';
import 'package:games_app/core/local/shared_preference/shared_preference.dart';
import 'package:games_app/features/withdraws/domain/entities/client_order_entity.dart';
import 'package:games_app/styles/colors/color_manager.dart';

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
            clientOrderEntity.tracking,style: TextStyle(
            color: UserDataFromStorage.themeIsDarkMode? ColorManager.black : ColorManager.darkGrey,

          ),
          ),
        )),
        Expanded(
            child: Center(
          child: Text(
            clientOrderEntity.orderTotal.toString(),style: TextStyle(
            color: UserDataFromStorage.themeIsDarkMode? ColorManager.black : ColorManager.darkGrey,
          ),
          ),
        )),
        Expanded(
            child: Center(
              child: Text(
                clientOrderEntity.profit.toString(),style: TextStyle(
                color: UserDataFromStorage.themeIsDarkMode? ColorManager.black : ColorManager.darkGrey,
              ),
              ),
            )),
        Expanded(
            child: Center(
          child: Text(
            clientOrderEntity.status,style: TextStyle(
            color: UserDataFromStorage.themeIsDarkMode? ColorManager.black : ColorManager.darkGrey,
          ),
          ),
        )),
      ],
    );
  }
}
