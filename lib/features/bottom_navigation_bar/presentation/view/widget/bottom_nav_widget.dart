import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:games_app/features/bottom_navigation_bar/presentation/cubit/bottom_nav_cubit.dart';
import 'package:games_app/features/bottom_navigation_bar/presentation/cubit/bottom_nav_state.dart';
import 'package:games_app/styles/colors/color_manager.dart';

class BottomNavWidget extends StatelessWidget {
  const BottomNavWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BottomNavCubit, BottomNavStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return BottomNavigationBar(
          currentIndex: BottomNavCubit.get(context).currentIndex,
          onTap: (value) {
            BottomNavCubit.get(context).changeBottomNav(value);
          },
          showSelectedLabels: true,
          showUnselectedLabels: true,
          selectedLabelStyle: const TextStyle(
            color: ColorManager.primary,
            fontWeight: FontWeight.bold,
          ),
          selectedItemColor: ColorManager.primary,
          unselectedItemColor: ColorManager.lightGrey,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart),
              label: 'الطلبات',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.wallet),
              label: 'الرصيد',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'الإعدادات',
            ),
          ],
        );
      }
    );
  }
}
