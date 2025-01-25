import 'package:flutter/material.dart';
import 'package:games_app/core/helper/app_size_config.dart';
import 'package:games_app/core/helper/material_navigation.dart';
import 'package:games_app/core/local/shared_preference/shared_preference.dart';
import 'package:games_app/features/balance/presentation/view/view_transication_image.dart';
import 'package:games_app/styles/colors/color_manager.dart';
import 'package:games_app/styles/text_styles/text_styles.dart';


class BalanceCard extends StatelessWidget {
  final String proofOfPayment;
  final String transactionId;
  final String paymentMethod;
  final String amount;
  final String status;
  final String transactionDate;

  const BalanceCard({
    super.key,
    required this.proofOfPayment,
    required this.transactionId,
    required this.paymentMethod,
    required this.amount,
    required this.status,
    required this.transactionDate,
  });

  @override
  Widget build(BuildContext context) {
    final isLight = Theme.of(context).brightness == Brightness.light;
    return Card(
      elevation: 4.0,
      color: isLight? ColorManager.darkWhite: ColorManager.darkThemeBackgroundLight,
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
                  'رقم العملية: $transactionId',
                  style: TextStyles.textStyle14Medium
                ),
              ],
            ),
            const Divider(),

            // Payment method and amount
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'وسيلة الدفع: $paymentMethod',
                  style: TextStyles.textStyle14Medium,
                ),
                Text(
                  'المبلغ: \$${amount}',
                  style: TextStyles.textStyle14Medium.copyWith(
                      color: UserDataFromStorage.themeIsDarkMode? ColorManager.success:  ColorManager.secondPrimary
                  ),
                ),
              ],
            ),

            SizedBox(height: SizeConfig.height * 0.01),


            // Status and transaction date
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
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
                Text(
                  'بتاريخ: $transactionDate',
                  style: TextStyles.textStyle14Medium.copyWith(
                     color: UserDataFromStorage.themeIsDarkMode? ColorManager.lightGrey:  ColorManager.secondPrimary
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            // Button to navigate to the payment proof screen
            ElevatedButton(
              onPressed: () {
                customPushNavigator(context, ViewTransicationImage(image:proofOfPayment));
              },
              child: const Text('عرض إثبات الدفع'),
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
        return UserDataFromStorage.themeIsDarkMode? ColorManager.primary: ColorManager.secondPrimary;
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
