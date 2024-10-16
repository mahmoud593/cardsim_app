import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:games_app/features/home/presentation/view/widgets/player_id_search_section.dart';
import 'package:games_app/features/home/presentation/view/widgets/request_order_button.dart';
import 'package:games_app/features/home/presentation/view/widgets/request_order_grid_view.dart';

import '../../../domain/entities/companies_entity.dart';
import '../../controller/products_cubit/products_cubit.dart';
import '../../controller/request_cubit/request_cubit.dart';
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
  final TextEditingController amountController = TextEditingController();
  final TextEditingController idController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
                      amountController.text =
                          (state.products[index].quantity!.min ?? 1).toString();
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
                    controller: amountController,
                  ),
                  const SizedBox(height: 24),
                  if (state.products[selectedProductIndex!].field != null)
                    PlayerIdSearchSection(
                      idController: idController,
                      productsEntity: state.products[selectedProductIndex!],
                      formKey: _formKey,
                    ),
                ],
                const SizedBox(height: 32),
                RequestOrderButton(
                  formKey: _formKey,
                  onPressed: () async {
                    var text = amountController.text;
                    var parsedQuantity = int.tryParse(text);
                    if (_formKey.currentState != null) {
                      if (_formKey.currentState!.validate()) {
                        if (state.products[selectedProductIndex!].field!
                                .fieldCheck ==
                            true) {
                          await context.read<RequestCubit>().checkIdField(
                              idController.text,
                              state.products[selectedProductIndex!].field!
                                  .fieldCheckType!);
                          if (context
                                  .read<RequestCubit>()
                                  .checkFieldEntity!
                                  .result ==
                              'success') {
                            context.read<RequestCubit>().createOrder(
                                  context: context,
                                  productId:
                                      state.products[selectedProductIndex!].id,
                                  quantity: parsedQuantity!,
                                  field: idController.text,
                                );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('من فضلك تحقق من البيانات'),
                              ),
                            );
                          }
                        } else if (state.products[selectedProductIndex!].field!
                                .fieldCheck ==
                            false) {
                          context.read<RequestCubit>().createOrder(
                                context: context,
                                productId:
                                    state.products[selectedProductIndex!].id,
                                quantity: parsedQuantity!,
                                field: idController.text,
                              );
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('من فضلك تحقق من البيانات'),
                          ),
                        );
                      }
                    } else {
                      context.read<RequestCubit>().createOrder(
                            context: context,
                            productId: state.products[selectedProductIndex!].id,
                            quantity: parsedQuantity!,
                            field: idController.text,
                          );
                    }
                  },
                ),
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
    amountController.dispose();
    super.dispose();
  }
}
