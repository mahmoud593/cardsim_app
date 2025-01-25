import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:games_app/core/helper/app_size_config.dart';
import 'package:games_app/features/orders/presentation/cubit/orders_cubit.dart';
import 'package:games_app/features/orders/presentation/cubit/orders_state.dart';
import 'package:games_app/features/orders/presentation/view/widget/filter_list_view.dart';
import 'package:games_app/features/orders/presentation/view/widget/order_card_widget.dart';
import 'package:games_app/styles/colors/color_manager.dart';
import 'package:games_app/styles/text_styles/text_styles.dart';
import 'package:games_app/styles/widgets/custom_search_field.dart';
import 'package:games_app/styles/widgets/loading_widget.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    bool isLight = Theme.of(context).brightness == Brightness.light;
    return BlocConsumer<OrdersCubit, OrdersStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'الطلبات',
              style: TextStyles.textStyle24Medium,
            ),
            centerTitle: true,
          ),
          body: RefreshIndicator(
            onRefresh: () async {
               OrdersCubit.get(context).getOrders(search: "", status: '');
            },
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,

              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.height * 0.02),
                child:  Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    SizedBox(height: SizeConfig.height * 0.01,),

                    /// Search field
                    CustomSearchField(
                      hintText: "ابحث عن طلبك",
                      suffixIcon: Icons.search,
                      controller: OrdersCubit.get(context).searchController,
                      onChanged: (value) {
                        OrdersCubit.get(context).getOrders(search: value, status: '');
                      },
                      onSubmitted: (value) {
                        OrdersCubit.get(context).getOrders(search: value, status: '');
                      },
                      onClear: () {
                        OrdersCubit.get(context).getOrders(search: "", status: '');
                      },
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.02,),

                    /// Filter list
                    const FilterListWidget(),

                    SizedBox(height: MediaQuery.of(context).size.height * 0.01,),

                    Expanded(
                      child: ModalProgressHUD(
                        inAsyncCall: state is GetOrdersLoadingState,
                        progressIndicator: const LoadingAnimationWidget(),
                        color: Colors.transparent,
                        child: state is GetOrdersLoadingState?
                        Container():
                        OrdersCubit.get(context).ordersModel.orders.isNotEmpty? ListView.builder(
                          itemCount: OrdersCubit.get(context).ordersModel.orders.length,
                            itemBuilder: (context, index){
                              return GameOrderCard(
                                transactionNumber: OrdersCubit.get(context).ordersModel.orders[index].tracking.toString(),
                                product: OrdersCubit.get(context).ordersModel.orders[index].productName,
                                playerName: OrdersCubit.get(context).ordersModel.orders[index].field.name,
                                priceForOne: OrdersCubit.get(context).ordersModel.orders[index].productPrice,
                                totalPrice: OrdersCubit.get(context).ordersModel.orders[index].orderTotal,
                                quantity: OrdersCubit.get(context).ordersModel.orders[index].quantity,
                                status: OrdersCubit.get(context).ordersModel.orders[index].status,
                                purchaseDate: OrdersCubit.get(context).ordersModel.orders[index].createdAt,
                                data: OrdersCubit.get(context).ordersModel.orders[index],
                              );
                            },
                        ) : Center(
                          child: Text(
                            'لا يوجد بيانات لعرضها',
                            style: TextStyles.textStyle18Medium,
                          ),
                        ),
                      ),
                    ),

                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
