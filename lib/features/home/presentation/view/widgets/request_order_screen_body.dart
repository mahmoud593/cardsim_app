import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:games_app/features/home/domain/entities/companies_entity.dart';
import 'package:games_app/features/home/presentation/view/widgets/amount_section.dart';
import 'package:games_app/features/home/presentation/view/widgets/player_id_search_section.dart';
import 'package:games_app/features/home/presentation/view/widgets/request_order_blue_container.dart';
import 'package:games_app/features/home/presentation/view/widgets/request_order_button.dart';
import 'package:games_app/features/home/presentation/view/widgets/request_order_grid_view.dart';
import 'package:games_app/features/home/presentation/view/widgets/request_order_red_container.dart';

import '../../controller/products_cubit/products_cubit.dart';

class RequestOrderScreenBody extends StatelessWidget {
  const RequestOrderScreenBody({super.key, required this.companiesEntity});

  final CompaniesEntity companiesEntity;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductsCubit, ProductsState>(
      builder: (context, state) {
        if(state is ProductsSuccess) {
          return  SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const RequestOrderGridView(),
                const SizedBox(
                  height: 30,
                ),
                Text(companiesEntity.category),
                const RequestOrderBlueContainer(),
                const SizedBox(
                  height: 8,
                ),
                const RequestOrderRedContainer(),
                const SizedBox(
                  height: 12,
                ),
                AmountSection(productsEntity: state.products.first),
                const SizedBox(
                  height: 8,
                ),
                const SizedBox(
                  height: 12,
                ),
                const Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: 'رقم اللاعب',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      TextSpan(
                        text: ' (إجباري)',
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                const PlayerIdSearchSection(),
                const SizedBox(
                  height: 16,
                ),
                const RequestOrderButton()
              ],
            ),
          );
        }
        else {
          return const Center(
            child: SizedBox(),
          );
        }
      },
    );
  }
}
