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
        return AnimatedNotchBottomBar(
          color: ColorManager.primary,
          showBlurBottomBar: false,
          bottomBarItems: const [
            BottomBarItem(
              inActiveItem: Icon(Icons.home, color: ColorManager.white),
              activeItem: Icon(Icons.home, color: ColorManager.white),
              itemLabelWidget: Text('الرئيسية', style: TextStyle(color: ColorManager.white)),
            ),
            BottomBarItem(
              inActiveItem: Icon(Icons.shopping_cart, color: ColorManager.white),
              activeItem: Icon(Icons.shopping_cart, color: ColorManager.white),
              itemLabelWidget: Text('الطلبات', style: TextStyle(color: ColorManager.white)),
            ),
            BottomBarItem(
              inActiveItem: Icon(Icons.wallet_outlined, color: ColorManager.white),
              activeItem: Icon(Icons.wallet_outlined, color: ColorManager.white),
              itemLabelWidget: Text('الرصيد', style: TextStyle(color: ColorManager.white)),
            ),
            BottomBarItem(
              inActiveItem: Icon(Icons.settings, color: ColorManager.white),
              activeItem: Icon(Icons.settings, color: ColorManager.white),
              itemLabelWidget: Text('الإعدادات', style: TextStyle(color: ColorManager.white)),
            ),
            BottomBarItem(
              inActiveItem: Icon(Icons.menu, color: ColorManager.white),
              activeItem: Icon(Icons.menu, color: ColorManager.white),
              itemLabelWidget: Text('القائمة', style: TextStyle(color: ColorManager.white)),
            ),
          ],
          showLabel: true,
          notchColor: ColorManager.primary,
          onTap: (index) {
            if(index == 4){
              BottomNavCubit.get(context).scaffoldKey.currentState!.openDrawer();
            }else{
              BottomNavCubit.get(context).changeBottomNav(index);
            }
          },
          notchBottomBarController: BottomNavCubit.get(context).notchBottomBarController,
          kIconSize: MediaQuery.of(context).size.height * 0.024,
          kBottomRadius: MediaQuery.of(context).size.height * 0.01,
        );
      }
    );
  }
}
