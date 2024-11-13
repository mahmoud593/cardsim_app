import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:games_app/features/withdraws/presentation/views/widgets/client_order_list_view_item.dart';

import '../../controller/client_order_cubit/client_order_cubit.dart';
import '../../controller/withdraws_cubit/withdraws_cubit.dart';

class ClientOrderListView extends StatelessWidget {
  const ClientOrderListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ClientOrderCubit, ClientOrderState>(
      builder: (context, state) {
        if (state is ClientOrdersSuccessState) {
          if (state.clientOrders.isEmpty) {
            return const Center(
              child: Text(
                'لا يوجد بيانات لعرضها',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
            );
          }
          return ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: state.clientOrders.length,
            itemBuilder: (context, index) {
              return ClientOrderListViewItem(
                clientOrderEntity: state.clientOrders[index],
                index: index,
              );
            },
            separatorBuilder: (context, index) {
              return const SizedBox(height: 16);
            },
          );
        } else if( state is ClientOrdersLoadingState) {
          return const LinearProgressIndicator();
        } else{
          return const Center(
            child: Text(
              'حدث خطأ يرجى المحاولة مرة اخرى',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
          );
        }
      },
    );
  }
}
