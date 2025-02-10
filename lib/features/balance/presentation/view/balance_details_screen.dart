import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:games_app/core/helper/app_size_config.dart';
import 'package:games_app/features/balance/data/models/get_all_transctions_model.dart';
import 'package:games_app/features/orders/data/models/orders_model.dart';
import 'package:games_app/styles/colors/color_manager.dart';
import 'package:games_app/styles/text_styles/text_styles.dart';

class BalanceDetailsScreen extends StatelessWidget {
  final Data balanceDetails;
  const BalanceDetailsScreen({super.key, required this.balanceDetails});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back),
        ),
        title: Text(
          'بيانات الطلب',
          style: TextStyles.textStyle18Bold,
        ),
        actions: [
          Text(
            getStatusText(balanceDetails.status!),
            style: TextStyles.textStyle18Bold
                .copyWith(color: ColorManager.warning),
          ),
          SizedBox(
            width: SizeConfig.height * 0.01,
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(SizeConfig.height * 0.02),
        child: Column(
          children: [
            Image(
              height:  SizeConfig.height * 0.2,
              width:  SizeConfig.height * 0.2,
              image: NetworkImage(balanceDetails.image!),
            ),
            SizedBox(
              height: SizeConfig.height * 0.02,
            ),
            balanceDetails.status != 'reject'
                ? const SizedBox()
                : Row(
                    children: [
                      Text(
                        'سبب الرفض : ',
                        style: TextStyles.textStyle18Medium,
                      ),
                      Text(
                        balanceDetails.reason!,
                        style: TextStyles.textStyle18Medium,
                      ),
                    ],
                  ),
            balanceDetails.status != 'reject'
                ? const SizedBox()
                : SizedBox(
                    height: SizeConfig.height * 0.02,
                  ),
            Row(
              children: [
                Text(
                  'تاريخ الطلب : ',
                  style: TextStyles.textStyle18Medium,
                ),
                Text(
                  balanceDetails.createdAt.toString(),
                  style: TextStyles.textStyle18Medium,
                ),
              ],
            ),
            SizedBox(
              height: SizeConfig.height * 0.02,
            ),
            Row(
              children: [
                Text(
                  'رقم الطلب : ',
                  style: TextStyles.textStyle18Medium,
                ),
                Text(
                  balanceDetails.tracking!,
                  style: TextStyles.textStyle18Medium,
                ),
              ],
            ),
            SizedBox(
              height: SizeConfig.height * 0.02,
            ),
            Row(
              children: [
                Text(
                  'وسيلة الدفع : ',
                  style: TextStyles.textStyle18Medium,
                ),
                Text(
                  balanceDetails.payment!,
                  style: TextStyles.textStyle18Medium,
                ),
              ],
            ),
            SizedBox(
              height: SizeConfig.height * 0.02,
            ),
            Row(
              children: [
                Text(
                  'المبلغ : ',
                  style: TextStyles.textStyle18Medium,
                ),
                Text(
                  balanceDetails.amount.toString(),
                  style: TextStyles.textStyle18Medium,
                ),
              ],
            ),
            SizedBox(
              height: SizeConfig.height * 0.02,
            ),
            Row(
              children: [
                Text(
                  'العموله : ',
                  style: TextStyles.textStyle18Medium,
                ),
                Text(
                  "${balanceDetails.tax}\$",
                  style: TextStyles.textStyle18Medium,
                ),
              ],
            ),
            SizedBox(
              height: SizeConfig.height * 0.01,
            ),
            Row(
              children: [
                Text(
                  'المبلغ المستلم : ',
                  style: TextStyles.textStyle18Medium,
                ),
                Text(
                  "${balanceDetails.total}\$",
                  style: TextStyles.textStyle18Medium,
                ),
              ],
            ),
            balanceDetails.notes!=null?
            SizedBox(
              height: SizeConfig.height * 0.01,
            ):const SizedBox(),
            balanceDetails.notes!=null?
            Row(
              children: [
                Text(
                  'الملاحظات : ',
                  style: TextStyles.textStyle18Medium,
                ),
                Text(
                  "${balanceDetails.notes}",
                  style: TextStyles.textStyle18Medium,
                ),
              ],
            ):const SizedBox(),
            SizedBox(
              height: SizeConfig.height * 0.01,
            ),

          ],
        ),
      ),
    );
  }

  String getStatusText(String status) {
    switch (status) {
      case 'completed':
        return 'مكتمل';
      case 'processing':
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
