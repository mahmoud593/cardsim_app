import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:games_app/features/withdraws/presentation/controller/client_order_cubit/client_order_cubit.dart';
import 'package:games_app/features/withdraws/presentation/controller/withdraws_cubit/withdraws_cubit.dart';
import 'package:games_app/features/withdraws/presentation/views/widgets/withdraws_screen_body.dart';

import '../../../../core/services/service_locator.dart';
import '../../domain/repos/withdraws_repo.dart';

class WithdrawsScreen extends StatelessWidget {
  const WithdrawsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  MultiBlocProvider(
      providers: [
        BlocProvider<WithdrawsCubit>(
          create: (context) => WithdrawsCubit(getIt<WithdrawsRepo>())..getWithdraws(),
        ),
        BlocProvider<ClientOrderCubit>(
          create: (context) => ClientOrderCubit(getIt<WithdrawsRepo>())..getClientOrders(),
        ),

      ],
      child: Scaffold(
        body: SafeArea(child: Center(child: WithdrawsScreenBody())),
      ),
    );
  }
}
