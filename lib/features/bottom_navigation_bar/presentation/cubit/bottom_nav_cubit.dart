import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:games_app/features/balance/presentation/view/balance_screen.dart';
import 'package:games_app/features/bottom_navigation_bar/presentation/cubit/bottom_nav_state.dart';
import 'package:games_app/features/home/presentation/view/home_screen.dart';
import 'package:games_app/features/orders/presentation/view/orders_screen.dart';
import 'package:games_app/features/settings/presentation/view/screens/settings_screen.dart';

class BottomNavCubit extends Cubit<BottomNavStates> {
  BottomNavCubit() : super(BottomNavInitialState());

  static BottomNavCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  NotchBottomBarController notchBottomBarController = NotchBottomBarController();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  
  List<Widget> bottomNavScreens = const [
    HomeScreen(),
    OrdersScreen(),
    BalanceScreen(),
    SettingsScreen(),
  ];

  void changeBottomNav(int index) {
    currentIndex = index;
    emit(BottomNavChangeState());
  }


}