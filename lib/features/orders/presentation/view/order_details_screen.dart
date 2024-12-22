import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:games_app/core/helper/app_size_config.dart';
import 'package:games_app/features/orders/data/models/orders_model.dart';
import 'package:games_app/styles/colors/color_manager.dart';
import 'package:games_app/styles/text_styles/text_styles.dart';

class OrderDetailsScreen extends StatelessWidget {
  final Order orderDetails;
  const OrderDetailsScreen({super.key, required this.orderDetails});

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
            getStatusText(orderDetails.status),
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
            orderDetails.status != 'reject'
                ? const SizedBox()
                : Row(
                    children: [
                      Text(
                        'سبب الرفض : ',
                        style: TextStyles.textStyle18Medium,
                      ),
                      Text(
                        orderDetails.rejectReason,
                        style: TextStyles.textStyle18Medium,
                      ),
                    ],
                  ),
            orderDetails.status != 'reject'
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
                  orderDetails.createdAt.toString(),
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
                  orderDetails.tracking,
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
                  'المنتج : ',
                  style: TextStyles.textStyle18Medium,
                ),
                Text(
                  orderDetails.productName,
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
                  'الكمية : ',
                  style: TextStyles.textStyle18Medium,
                ),
                Text(
                  orderDetails.quantity.toString(),
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
                  'سعر الطلب : ',
                  style: TextStyles.textStyle18Medium,
                ),
                Text(
                  "${orderDetails.orderTotal}\$",
                  style: TextStyles.textStyle18Medium,
                ),
              ],
            ),
            SizedBox(
              height: SizeConfig.height * 0.01,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  orderDetails.field.name,
                  style: TextStyles.textStyle18Medium,
                ),
                Text(
                  " : ",
                  style: TextStyles.textStyle18Medium,
                ),
                Text(
                  orderDetails.field.value,
                  style: TextStyles.textStyle18Medium,
                ),
                IconButton(
                  onPressed: () {
                    Clipboard.setData(
                        ClipboardData(text: orderDetails.field.value));
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('تم نسخ البيانات'),
                    ));
                  },
                  icon: Icon(
                    size: SizeConfig.height * 0.03,
                    Icons.copy,
                    color: ColorManager.white,
                  ),
                ),
              ],
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
