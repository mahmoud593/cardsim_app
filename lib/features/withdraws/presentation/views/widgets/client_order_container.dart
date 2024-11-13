import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:games_app/features/withdraws/presentation/controller/withdraws_cubit/withdraws_cubit.dart';
import 'package:games_app/features/withdraws/presentation/views/widgets/client_order_list_view.dart';
import 'package:svg_flutter/svg.dart';

import '../../../../../generated/assets.dart';
import '../../../../../styles/colors/color_manager.dart';
import '../../controller/client_order_cubit/client_order_cubit.dart';

class ClientOrderContainer extends StatelessWidget {
  const ClientOrderContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ClientOrderCubit, ClientOrderState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(12.0),
          child: Card(
            color: Colors.white,
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          SvgPicture.asset(
                            Assets.imagesDeviceTablet,
                            width: 30,
                            height: 30,
                          ),
                          const SizedBox(width: 8),
                          const Text(
                            'العمليات',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                 /* const SizedBox(height: 16),
                  TextFormField(
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.only(right: 10),
                      filled: true,
                      fillColor: Colors.grey.shade50,
                      suffixIcon: const Icon(
                        Icons.search,
                        color: Colors.grey,
                      ),
                      hintText: 'البحث...',
                      hintStyle: const TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.grey.shade200),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            const BorderSide(color: ColorManager.primary),
                      ),
                    ),
                  ),*/
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    decoration: BoxDecoration(
                      color: ColorManager.primary,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                          child: Text(
                            'الطلب',
                            style: TextStyle(color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            'الإجمالي',
                            style: TextStyle(color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            'الربح',
                            style: TextStyle(color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            'الحاله',
                            style: TextStyle(color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),
                  Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const ClientOrderListView()
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
