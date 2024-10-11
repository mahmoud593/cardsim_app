import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:games_app/features/orders/presentation/cubit/orders_cubit.dart';
import 'package:games_app/features/orders/presentation/cubit/orders_state.dart';
import 'package:games_app/styles/colors/color_manager.dart';

class FilterListWidget extends StatelessWidget {
  const FilterListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    bool isLight = Theme.of(context).brightness == Brightness.light;
    return BlocConsumer<OrdersCubit, OrdersStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Wrap(
          spacing: 8.0,
          children: OrdersCubit.get(context).categories.map((category) {
            return ChoiceChip(
              label: Text(category),
              labelStyle: TextStyle(
                color: OrdersCubit.get(context).selectedCategory == category
                    ? Colors.white
                    : isLight
                        ? ColorManager.black
                        : ColorManager.white,
              ),
              selected: OrdersCubit.get(context).selectedCategory == category,
              selectedColor: ColorManager.primary,
              checkmarkColor: ColorManager.white,
              backgroundColor: isLight
                  ? ColorManager.white
                  : ColorManager.darkThemeBackgroundLight,
              onSelected: (bool selected) {
                OrdersCubit.get(context).changeCategory(category);
              },
            );
          }).toList(),
        );
      },
    );
  }
}
