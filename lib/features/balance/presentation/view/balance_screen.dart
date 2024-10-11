import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:games_app/core/helper/app_size_config.dart';
import 'package:games_app/features/balance/presentation/cubit/balance_cubit.dart';
import 'package:games_app/features/balance/presentation/cubit/balance_state.dart';
import 'package:games_app/features/balance/presentation/view/balance_card_widget.dart';
import 'package:games_app/features/orders/presentation/cubit/orders_cubit.dart';
import 'package:games_app/features/orders/presentation/cubit/orders_state.dart';
import 'package:games_app/styles/colors/color_manager.dart';
import 'package:games_app/styles/text_styles/text_styles.dart';
import 'package:games_app/styles/widgets/custom_search_field.dart';
import 'package:games_app/styles/widgets/default_button.dart';

class BalanceScreen extends StatelessWidget {
  const BalanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BalanceCubit, BalanceStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'إضافة دفعات',
              style: TextStyles.textStyle24Medium,
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

                  const CustomSearchField(
                    hintText: "البحث...",
                    suffixIcon: Icons.search,
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02,),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      DefaultButton(
                        onPressed: (){},
                        borderRadius: BorderRadius.circular(SizeConfig.height*0.01),
                        text: "شحن الرصيد",
                        backgroundColor: ColorManager.success,
                        haveIcon: true,
                        icon: Icons.attach_money,
                        textStyle: TextStyles.textStyle14Medium.copyWith(
                          color: ColorManager.white
                        ),
                      ),
                      DefaultButton(
                        onPressed: (){},
                        borderRadius: BorderRadius.circular(SizeConfig.height*0.01),
                        text: "الشحن بقسيمة",
                        haveIcon: true,
                        icon: Icons.wallet,
                        textStyle: TextStyles.textStyle14Medium.copyWith(
                          color: ColorManager.white
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: MediaQuery.of(context).size.height * 0.02,),

                  Expanded(
                    child: ListView(
                      children: const [
                        BalanceCard(
                          proofOfPayment: 'ايصال رقم 12345',
                          transactionId: 107,
                          paymentMethod: 'Visa',
                          amount: 100.00,
                          status: 'completed',
                          transactionDate: '2023-10-05 14:30:00',
                        ),
                        BalanceCard(
                          proofOfPayment: 'ايصال رقم 67890',
                          transactionId: 108,
                          paymentMethod: 'PayPal',
                          amount: 50.75,
                          status: 'pending',
                          transactionDate: '2023-10-06 16:20:00',
                        ),
                        // Add more BalanceCard widgets here
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
