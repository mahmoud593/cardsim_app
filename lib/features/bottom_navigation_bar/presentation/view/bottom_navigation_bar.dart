import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:games_app/features/bottom_navigation_bar/presentation/cubit/bottom_nav_cubit.dart';
import 'package:games_app/features/bottom_navigation_bar/presentation/cubit/bottom_nav_state.dart';
import 'package:games_app/features/bottom_navigation_bar/presentation/view/widget/bottom_nav_widget.dart';
import 'package:games_app/features/bottom_navigation_bar/presentation/view/widget/drawer_widget.dart';

class BottomNavigationScreen extends StatelessWidget {
  const BottomNavigationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BottomNavCubit, BottomNavStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          key: BottomNavCubit.get(context).scaffoldKey,
          body: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: BottomNavCubit.get(context).bottomNavScreens[BottomNavCubit.get(context).currentIndex],
          ),

          /// bottom nav bar
          bottomNavigationBar: const BottomNavWidget(),

        );
      },
    );
  }
}
