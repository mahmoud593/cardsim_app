import 'package:flutter/material.dart';
import 'package:games_app/core/local/shared_preference/shared_preference.dart';
import 'package:games_app/features/withdraws/domain/entities/withdraws_entity.dart';
import 'package:games_app/styles/colors/color_manager.dart';

import '../../../domain/entities/withdraws_data_entity.dart';

class WithdrawListViewItem extends StatelessWidget {
  const WithdrawListViewItem(
      {super.key, required this.withdrawsEntity, required this.index});

  final WithdrawsDataEntity withdrawsEntity;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Expanded(
            child: Center(
              child: Text(
                withdrawsEntity.tracking,style: TextStyle(
                color: UserDataFromStorage.themeIsDarkMode? ColorManager.black : ColorManager.darkGrey,
              ),
              ),
            )),
        Expanded(
            child: Center(
              child: Text(
                withdrawsEntity.amount.toString(),style: TextStyle(
                color: UserDataFromStorage.themeIsDarkMode? ColorManager.black : ColorManager.darkGrey,
              ),
              ),
            )),
        Expanded(
            child: Center(
              child: Text(
                withdrawsEntity.status,style: TextStyle(
                color: UserDataFromStorage.themeIsDarkMode? ColorManager.black : ColorManager.darkGrey,
              ),
              ),
            )),
      ],
    );
  }
}
