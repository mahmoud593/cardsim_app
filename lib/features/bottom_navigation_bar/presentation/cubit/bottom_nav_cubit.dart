import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:games_app/features/balance/presentation/view/balance_screen.dart';
import 'package:games_app/features/bottom_navigation_bar/presentation/cubit/bottom_nav_state.dart';
import 'package:games_app/features/home/presentation/view/home_screen.dart';
import 'package:games_app/features/orders/presentation/view/orders_screen.dart';
import 'package:games_app/features/settings/presentation/view/screens/settings_screen.dart';

class BottomNavCubit extends Cubit<BottomNavStates> {
  BottomNavCubit() : super(BottomNavInitialState());

  static BottomNavCubit get(context) => BlocProvider.of(context);

  int currentIndex = 2;

  List<Widget> bottomNavScreens = const [
    HomeScreen(),
    OrdersScreen(),
    HomeScreen(),
    BalanceScreen(),
    SettingsScreen(),
  ];

  void changeBottomNav(int index) {
    currentIndex = index;
    emit(BottomNavChangeState());
  }


}