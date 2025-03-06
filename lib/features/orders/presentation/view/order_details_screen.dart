import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:games_app/core/helper/app_size_config.dart';
import 'package:games_app/features/orders/data/models/orders_model.dart';
import 'package:games_app/styles/colors/color_manager.dart';
import 'package:games_app/styles/text_styles/text_styles.dart';
import 'package:games_app/styles/widgets/toast.dart';

class OrderDetailsScreen extends StatelessWidget {
  final Order orderDetails;
  final List<String> codes;
  const OrderDetailsScreen({super.key, required this.orderDetails,required this.codes});

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
            Align(
              alignment: Alignment.bottomRight,
              child: Text(
                'بيانات اضافيه',
                style: TextStyles.textStyle18Medium,
              ),
            ),

            Expanded(
              child: ListView.separated(
                  itemBuilder: (context, index) => Row(
                    children: [
                      Text(codes[index]),
                      SizedBox(
                        width: SizeConfig.height * 0.01,
                      ),
                      Text(' : ',style:  TextStyles.textStyle24Medium,),
                      IconButton(
                          onPressed: (){
                            Clipboard.setData(ClipboardData(text: codes[index]));
                            customToast(title: 'تم نسخ الكود', color: ColorManager.primary);
                          },
                          icon: const Icon(Icons.copy)
                      )
                    ],
                  ),
                  separatorBuilder: (context, index) =>  Container(),
                  itemCount: codes.length
              ),
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
      case 'pending':
        return 'قيد التنفيذ';
      case 'processing':
        return 'قيد الإنتظار';
      case 'reject':
        return 'مرفوض';
      default:
        return 'غير معروف';
    }
  }
}
