import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:games_app/features/withdraws/presentation/views/widgets/withdraw_list_view_item.dart';

import '../../controller/withdraws_cubit/withdraws_cubit.dart';

class WithdrawsListView extends StatelessWidget {
  const WithdrawsListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WithdrawsCubit, WithdrawsState>(
      builder: (context, state) {
        if (state is WithdrawsSuccessState) {
          if (state.withdraws.isEmpty) {
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
            itemCount: state.withdraws.length,
            itemBuilder: (context, index) {
              return WithdrawListViewItem(
                withdrawsEntity: state.withdraws[index],
                index: index,
              );
            },
            separatorBuilder: (context, index) {
              return const SizedBox(height: 16);
            },
          );
        } else if (state is WithdrawsLoadingState) {
          return const LinearProgressIndicator();
        } else {
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
