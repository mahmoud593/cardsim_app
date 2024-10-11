import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:games_app/features/orders/presentation/cubit/orders_cubit.dart';
import 'package:games_app/features/orders/presentation/cubit/orders_state.dart';
import 'package:games_app/features/orders/presentation/view/widget/filter_list_view.dart';
import 'package:games_app/features/orders/presentation/view/widget/order_card_widget.dart';
import 'package:games_app/styles/colors/color_manager.dart';
import 'package:games_app/styles/text_styles/text_styles.dart';
import 'package:games_app/styles/widgets/custom_search_field.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    bool isLight = Theme.of(context).brightness == Brightness.light;
    return BlocConsumer<OrdersCubit, OrdersStates>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'الطلبات',
              style: TextStyles.textStyle24Medium,
            ),
            centerTitle: true,
          ),
          body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            //color: ColorManager.white,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.height * 0.02),
              child:  Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CustomSearchField(
                    hintText: "ابحث عن طلبك",
                    suffixIcon: Icons.search,
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02,),

                  const FilterListWidget(),

                  SizedBox(height: MediaQuery.of(context).size.height * 0.01,),

                  Expanded(
                    child: ListView(
                      children: const [
                        // Example of order cards
                        GameOrderCard(
                          transactionNumber: '12345',
                          product: 'لعبة PUBG',
                          playerName: 'Player1',
                          priceForOne: 0.15,
                          totalPrice: 0.60,
                          quantity: 4,
                          status: 'completed',
                          purchaseDate: '2024-10-06',
                        ),
                        GameOrderCard(
                          transactionNumber: '12346',
                          product: 'لعبة Fortnite',
                          playerName: 'Player2',
                          priceForOne: 0.15,
                          totalPrice: 0.60,
                          quantity: 4,
                          status: 'in_progress',
                          purchaseDate: '2024-10-05',
                        ),
                        GameOrderCard(
                          transactionNumber: '12347',
                          product: 'لعبة FIFA',
                          playerName: 'Player3',
                          priceForOne: 0.15,
                          totalPrice: 0.60,
                          quantity: 4,
                          status: 'pending',
                          purchaseDate: '2024-10-04',
                        ),
                        GameOrderCard(
                          transactionNumber: '12348',
                          product: 'لعبة Apex Legends',
                          playerName: 'Player4',
                          priceForOne: 0.15,
                          totalPrice: 0.60,
                          quantity: 4,
                          status: 'reject',
                          rejectReason: "لم يتم الانتهاء من العملية",
                          purchaseDate: '2024-10-03',
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
