import 'package:flutter/material.dart';
import 'package:games_app/core/helper/app_size_config.dart';
import 'package:games_app/styles/colors/color_manager.dart';
import 'package:games_app/styles/text_styles/text_styles.dart';


class CouponsCard extends StatelessWidget {
  final String createdAt;
  final String coupon;
  final String username;
  final double amount;
  final String status;
  final String buyedAtDate;

  const CouponsCard({
    super.key,
    required this.coupon,
    required this.username,
    required this.amount,
    required this.status,
    required this.createdAt,
    required this.buyedAtDate,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(SizeConfig.height * 0.01)),
      child: Padding(
        padding: EdgeInsets.all(SizeConfig.height * 0.015),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'القسيمة: $coupon',
                  style: TextStyles.textStyle14Medium,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                  decoration: BoxDecoration(
                    color: getStatusColor(status),
                    borderRadius: BorderRadius.circular(SizeConfig.height * 0.01),
                  ),
                  child: Text(
                    getStatusText(status),
                    style: TextStyles.textStyle14Medium.copyWith(color: ColorManager.white),
                  ),
                ),
              ],
            ),
            const Divider(),

            // Payment method and amount
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'المستخدم: $username',
                  style: TextStyles.textStyle14Medium,
                ),
                Text(
                  'المبلغ: \$${amount.toStringAsFixed(2)}',
                  style: TextStyles.textStyle14Medium.copyWith(color: ColorManager.success),
                ),
              ],
            ),

            SizedBox(height: SizeConfig.height * 0.01),


            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [

                Text(
                  'تاريخ الشراء: $buyedAtDate',
                  style: TextStyles.textStyle14Medium.copyWith(color: ColorManager.lightGrey),
                ),
                Text(
                  'تاريخ الإنشاء: $createdAt',
                  style: TextStyles.textStyle14Medium.copyWith(color: ColorManager.lightGrey),
                ),
              ],
            ),

          ],
        ),
      ),
    );
  }

  Color getStatusColor(String status) {
    switch (status) {
      case 'completed':
        return ColorManager.success;
      case 'in_progress':
        return ColorManager.warning;
      case 'pending':
        return ColorManager.primary;
      case 'reject':
        return ColorManager.error;
      default:
        return Colors.grey;
    }
  }

  String getStatusText(String status) {
    switch (status) {
      case 'completed':
        return 'مكتمل';
      case 'in_progress':
        return 'قيد التنفيذ';
      case 'pending':
        return 'قيد الإنتظار';
      case 'reject':
        return 'مرفوض';
      default:
        return 'غير معروف';
    }
  }

}
