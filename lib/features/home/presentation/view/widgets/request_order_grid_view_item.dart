import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:games_app/core/helper/app_size_config.dart';
import 'package:games_app/core/local/cashe_helper/cashe_helper.dart';
import 'package:games_app/features/balance/presentation/cubit/balance_cubit.dart';
import 'package:games_app/features/balance/presentation/cubit/balance_state.dart';
import 'package:games_app/features/home/domain/entities/products_entity.dart';
import 'package:games_app/styles/colors/color_manager.dart';

class RequestOrderListViewItem extends StatelessWidget {
  const RequestOrderListViewItem({
    super.key,
    required this.productsEntity,
    required this.isSelected,
    required this.status,
    this.onTap,
  });

  final ProductsEntity productsEntity;
  final String status;
  final bool isSelected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: IntrinsicHeight(
        child: IntrinsicWidth(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Stack(
              children: [
                ColorFiltered(
                  colorFilter: productsEntity.status == 'unavailable'
                      ? const ColorFilter.mode(
                          Colors.black,
                          BlendMode.saturation,
                        )
                      :  status == 'inactive'?
                  const ColorFilter.mode(
                          Colors.grey, BlendMode.hue
                  ):
                  const ColorFilter.mode(
                      Colors.transparent, BlendMode.multiply
                  ),
                  child: Image.network(
                    productsEntity.image,
                    fit: BoxFit.cover,
                  ),
                ),
                if (!isSelected)
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.5),
                    ),
                  ),

                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: SizeConfig.height * 0.05,
                    color: Colors.black54,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          child: Text(
                             '${productsEntity.name}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                status=='inactive'?
                Positioned(
                  top: SizeConfig.height * 0.062,
                  left: SizeConfig.height*.07,
                  right: 0,
                  child: Container(
                    decoration: const BoxDecoration(
                      color: ColorManager.primary,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12),
                        bottomLeft: Radius.circular(12),
                      ),
                    ),
                    height: SizeConfig.height * 0.03,
                    padding:
                    const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          child: Text(
                            'غير متوفر',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ):Container(),

                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: 55,
                    color: Colors.black.withOpacity(0.5),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '${productsEntity.price}\$',
                          style: const TextStyle(
                              color: Colors.white, fontSize: 14),
                        ),
                        CashHelper.getData(key: 'currencyCharge')!='USD' && CashHelper.getData(key: 'currencyCharge')!=null && CashHelper.getData(key: 'numOfCharge')!=null ?
                        BlocBuilder<BalanceCubit,BalanceStates>(
                          builder: (context, state) {
                            return Text(
                              '${(double.parse(productsEntity.price)*CashHelper.getData(key: 'numOfCharge')).toStringAsFixed(2)}${CashHelper.getData(key: 'currencyCharge')}',
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 14),
                            );
                          },

                        ):Container(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
