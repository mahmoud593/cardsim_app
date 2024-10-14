import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:games_app/features/home/domain/entities/companies_entity.dart';
import 'package:games_app/features/home/presentation/controller/products_cubit/products_cubit.dart';
import 'package:games_app/features/home/presentation/controller/request_cubit/request_cubit.dart';
import 'package:games_app/features/home/presentation/view/widgets/request_order_screen_body.dart';

import '../../../../../core/services/service_locator.dart';
import '../../../domain/repos/home_repo.dart';

class RequestOrderScreen extends StatelessWidget {
  const RequestOrderScreen({super.key, required this.companiesEntity});

  final CompaniesEntity companiesEntity;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ProductsCubit>(
          create: (context) =>
          ProductsCubit(getIt.get<HomeRepo>())..getProducts(companiesEntity.id),
        ),
        BlocProvider<RequestCubit>(
          create: (context) =>
          RequestCubit(getIt.get<HomeRepo>()),
        ),
      ],
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: SafeArea(
              child: RequestOrderScreenBody(
            companiesEntity: companiesEntity,
          )),
        ),
      ),
    );
  }
}
