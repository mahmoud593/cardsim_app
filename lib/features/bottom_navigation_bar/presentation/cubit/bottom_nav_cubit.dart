import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:games_app/features/balance/presentation/view/balance_screen.dart';
import 'package:games_app/features/bottom_navigation_bar/presentation/cubit/bottom_nav_state.dart';
import 'package:games_app/features/home/presentation/view/home_screen.dart';
import 'package:games_app/features/orders/presentation/view/orders_screen.dart';
import 'package:games_app/features/settings/presentation/view/screens/settings_screen.dart';

import '../../../../core/constants/app_session.dart';
import '../../../../styles/widgets/toast.dart';
import '../../../auth/data/auth_repo_implement/auth_repo_implement.dart';
import '../../../auth/data/models/user_info_model.dart';

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
  UserInfoModel? userInfoModel;
  Future<void> getUserInfo() async {
    emit(GetUserLoadingState());
    userInfoModel = await AuthRepoImplement().getUser();
    if (userInfoModel != null) {
      AppSession.userInfoModel = userInfoModel;
      print('get user info');
      print(userInfoModel!.distProfit!);
      emit(GetUserSuccessState());
    } else {
      customToast(title: 'حدث خطا اثناء الحصول ع البيانات', color: Colors.red);
      emit(GetUserErrorState());
    }
  }


}