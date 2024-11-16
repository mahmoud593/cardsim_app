import 'package:flutter/material.dart';
import 'package:games_app/core/helper/app_size_config.dart';
import 'package:games_app/styles/colors/color_manager.dart';
import 'package:games_app/styles/text_styles/text_styles.dart';


class PaymentHistoryCard extends StatelessWidget {
  final String transactionId;
  final String transactionAmount;
  final String balanceBefore;
  final String balanceAfter;
  final String transactionType;

  const PaymentHistoryCard({
    super.key,
    required this.transactionId,
    required this.transactionAmount,
    required this.balanceBefore,
    required this.balanceAfter,
    required this.transactionType,
  });

  @override
  Widget build(BuildContext context) {
    bool isLight = Theme.of(context).brightness == Brightness.light;
    return Card(
      elevation: 10.0,
      color: isLight ? ColorManager.white : ColorManager.darkThemeBackgroundLight,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(SizeConfig.height * 0.015)),
      child: Padding(
        padding: EdgeInsets.all(SizeConfig.height * 0.018),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Text(
              'رقم العملية: $transactionId',
              style: TextStyles.textStyle18Bold,
            ),
            const Divider(),

            Text(
              'القيمة: \$$transactionAmount',
              style: TextStyles.textStyle14Medium.copyWith(color: ColorManager.warning),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'الرصيد قبل : \$$balanceBefore',
                  style: TextStyles.textStyle14Medium.copyWith(color: ColorManager.lightGrey),
                ),
                Text(
                  'الرصيد بعد : \$$balanceAfter',
                  style: TextStyles.textStyle14Medium.copyWith(color: ColorManager.lightGrey),
                ),
              ],
            ),

            const SizedBox(height: 10),

            Text(
              'نوع العملية: $transactionType',
              style: TextStyles.textStyle14Medium,
            ),
          ],
        ),
      ),
    );
  }

}