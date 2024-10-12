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
    return BlocBuilder<OrdersCubit, OrdersStates>(
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
                switch (OrdersCubit.get(context).selectedCategory) {
                  case "الكل":
                    OrdersCubit.get(context).getOrders(search: "", status: "");
                    break;

                  case "قيد التنفيذ":
                    OrdersCubit.get(context)
                        .getOrders(search: "", status: "processing");
                    break;

                  case "مكتمل":
                    OrdersCubit.get(context)
                        .getOrders(search: "", status: "completed");
                    break;

                  case "مرفوضة":
                    OrdersCubit.get(context)
                        .getOrders(search: "", status: "reject");
                    break;

                  case "قيد الإنتظار":
                    OrdersCubit.get(context)
                        .getOrders(search: "", status: "pending");
                    break;
                  default:
                    OrdersCubit.get(context).getOrders(search: "", status: "");
                    break;
                }
              },
            );
          }).toList(),
        );
      },
    );
  }
}
