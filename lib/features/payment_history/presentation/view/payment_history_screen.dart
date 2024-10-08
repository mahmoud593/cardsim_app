import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:games_app/features/payment_history/presentation/cubit/payment_history_cubit.dart';
import 'package:games_app/features/payment_history/presentation/cubit/payment_history_state.dart';
import 'package:games_app/features/payment_history/presentation/view/widget/payment_history_widget.dart';
import 'package:games_app/styles/colors/color_manager.dart';
import 'package:games_app/styles/text_styles/text_styles.dart';

class PaymentHistoryScreen extends StatelessWidget {
  const PaymentHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PaymentHistoryCubit, PaymentHistoryStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'سجل العمليات',
              style: TextStyles.textStyle24Medium,
            ),
            leading: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(
                Icons.arrow_back,
                color: ColorManager.black,
              ),
            ),
            centerTitle: true,
          ),
          body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: ColorManager.white,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.height * 0.02),
              child:  Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Expanded(
                    child: ListView(
                      children: const [
                        PaymentHistoryCard(
                          transactionAmount: 100.0,
                          balanceBefore: 500.0,
                          balanceAfter: 400.0,
                          transactionDate: '2022-01-01',
                          transactionType: 'الشحن بقسيمة',
                          transactionId: "123456789",
                        ),

                        PaymentHistoryCard(
                          transactionAmount: 200.0,
                          balanceBefore: 500.0,
                          balanceAfter: 300.0,
                          transactionDate: '2022-01-01',
                          transactionType: 'تعويض على طلبية',
                          transactionId: "123456789",
                        ),

                        PaymentHistoryCard(
                          transactionAmount: 300.0,
                          balanceBefore: 500.0,
                          balanceAfter: 200.0,
                          transactionDate: '2022-01-01',
                          transactionType: 'طلب جديد',
                          transactionId: "123456789",
                        ),
                      ],
                    ),
                  ),

                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
