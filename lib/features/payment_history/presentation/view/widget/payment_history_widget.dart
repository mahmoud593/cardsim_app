import 'package:flutter/material.dart';
import 'package:games_app/core/helper/app_size_config.dart';
import 'package:games_app/styles/colors/color_manager.dart';
import 'package:games_app/styles/text_styles/text_styles.dart';


class PaymentHistoryCard extends StatelessWidget {
  final String transactionId;
  final double transactionAmount;
  final double balanceBefore;
  final double balanceAfter;
  final String transactionType;
  final String transactionDate;

  const PaymentHistoryCard({
    super.key,
    required this.transactionId,
    required this.transactionAmount,
    required this.balanceBefore,
    required this.balanceAfter,
    required this.transactionType,
    required this.transactionDate,
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

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'القيمة: \$${transactionAmount.toStringAsFixed(2)}',
                  style: TextStyles.textStyle14Medium.copyWith(color: ColorManager.warning),
                ),
                Text(
                  'بتاريخ: $transactionDate',
                  style: TextStyles.textStyle14Medium.copyWith(color: ColorManager.lightGrey),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              'الرصيد (قبل - بعد): \$${balanceBefore.toStringAsFixed(2)} - \$${balanceAfter.toStringAsFixed(2)}',
              style: TextStyles.textStyle14Medium.copyWith(color: ColorManager.lightGrey),
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