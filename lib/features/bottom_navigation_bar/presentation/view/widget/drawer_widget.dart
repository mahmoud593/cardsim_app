import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:games_app/features/bottom_navigation_bar/presentation/cubit/bottom_nav_cubit.dart';
import 'package:games_app/features/bottom_navigation_bar/presentation/cubit/bottom_nav_state.dart';
import 'package:games_app/features/bottom_navigation_bar/presentation/view/widget/drawer_ltem.dart';
import 'package:games_app/styles/colors/color_manager.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BottomNavCubit, BottomNavStates>(
  listener: (context, state) {
    // TODO: implement listener
  },
  builder: (context, state) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.6,
      height: MediaQuery.of(context).size.height,
      color: ColorManager.primary,
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.1,
          ),
          DrawerItem(
            icon: Icons.home_filled,
            title: 'الرئيسية',
            onTap: () {
              BottomNavCubit.get(context).changeBottomNav(2);
            },
          ),
          DrawerItem(
            icon: Icons.shopping_cart,
            title: 'الطلبات',
            onTap: () {
              BottomNavCubit.get(context).changeBottomNav(1);
            },
          ),
          DrawerItem(
            icon: Icons.wallet,
            title: 'الرصيد',
            onTap: () {
              BottomNavCubit.get(context).changeBottomNav(3);
            },
          ),
          DrawerItem(
            icon: Icons.history,
            title: 'سجل العمليات',
            onTap: () {},
          ),
          DrawerItem(
            icon: Icons.people,
            title: 'وكلاؤنا',
            onTap: () {},
          ),
          DrawerItem(
            icon: Icons.support_agent,
            title: 'الدعم الفنى',
            onTap: () {},
          ),
          DrawerItem(
            icon: Icons.settings,
            title: 'الإعدادات',
            onTap: () {},
          ),
        ],
      ),
    );
  },
);
  }
}
