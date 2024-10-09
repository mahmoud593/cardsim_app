import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:games_app/features/home/presentation/view/widgets/notes_list_view_item.dart';
import 'package:games_app/features/home/presentation/view/widgets/player_id_search_section.dart';
import 'package:games_app/features/home/presentation/view/widgets/request_order_button.dart';
import 'package:games_app/features/home/presentation/view/widgets/request_order_grid_view.dart';

import '../../../domain/entities/companies_entity.dart';
import '../../controller/products_cubit/products_cubit.dart';
import 'amount_section.dart';
import 'notes_list_view.dart';

class RequestOrderScreenBody extends StatefulWidget {
  const RequestOrderScreenBody({super.key, required this.companiesEntity});

  final CompaniesEntity companiesEntity;

  @override
  State<RequestOrderScreenBody> createState() => _RequestOrderScreenBodyState();
}

class _RequestOrderScreenBodyState extends State<RequestOrderScreenBody> {
  int? selectedProductIndex = 0;
  final TextEditingController _amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductsCubit, ProductsState>(
      builder: (context, state) {
        if (state is ProductsSuccess) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RequestOrderGridView(
                  selectedProductIndex: selectedProductIndex,
                  onProductSelected: (index) {
                    setState(() {
                      selectedProductIndex = index;
                      _amountController.text =
                          (state.products[index].quantity?.min ?? 1).toString();
                    });
                  },
                ),
                const SizedBox(height: 30),
                if (widget.companiesEntity.notes!.isNotEmpty) ...[
                  NotesListView(widget: widget),
                ],
                const SizedBox(height: 12),
                if (selectedProductIndex != null &&
                    state.products[selectedProductIndex!].quantity != null) ...[
                  AmountSection(
                    productsEntity: state.products[selectedProductIndex!],
                    controller: _amountController,
                  ),
                  const SizedBox(height: 24),
                  if (state.products[selectedProductIndex!].field != null)
                    PlayerIdSearchSection(
                      productsEntity: state.products[selectedProductIndex!],
                    ),
                ],
                const SizedBox(height: 32),
                const RequestOrderButton(),
              ],
            ),
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }
}



