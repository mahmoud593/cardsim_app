import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:games_app/core/constants/urls.dart';
import 'package:games_app/core/local/shared_preference/shared_preference.dart';
import 'package:games_app/core/network/api_handle/http_request_handler.dart';
import 'package:games_app/features/balance/presentation/view/balance_screen.dart';
import 'package:games_app/features/bottom_navigation_bar/presentation/cubit/bottom_nav_state.dart';
import 'package:games_app/features/home/presentation/controller/currency_cubit/currency_cubit.dart';
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
  Future<void> getUserInfo({
    required context
  }) async {
    emit(GetUserLoadingState());
    userInfoModel = await AuthRepoImplement().getUser(context: context);
    if (userInfoModel != null && userInfoModel!.name != null) {
      AppSession.userInfoModel = userInfoModel;
      print('get user info');
      UserDataFromStorage.setFullName(userInfoModel!.name!);
      UserDataFromStorage.setPhoneNumber(userInfoModel!.phone??'');
      UserDataFromStorage.setEmail(userInfoModel!.email!);
      UserDataFromStorage.setDistCustomEarning(userInfoModel!.dist_custom_earning!);
      print('Value of custom dist: ${userInfoModel!.dist_custom_earning}');
      UserDataFromStorage.setBalance(double.parse(userInfoModel!.balance!.toString()));
      print('get user info');
      emit(GetUserSuccessState());
    } else {
      // customToast(title: 'حدث خطا اثناء الحصول ع البيانات', color: Colors.red);
      emit(GetUserErrorState());
    }
  }


 HttpHelper httpHelper = HttpHelper();

  Future <void> logout()async{

    emit(LogoutLoadingState());

    try{
      var response =  await httpHelper.callService(
        responseType: ResponseType.post,
        url: UrlConstants.logoutUrl,
        authorization: true,
      );
      UserDataFromStorage.setUserTokenFromStorage('');
      print(UserDataFromStorage.userTokenFromStorage);

      print('Logout Successfully');
      emit(LogoutSuccessState());
    }catch(error){
      print('error in logout is $error');
      emit(LogoutErrorState());
    }


  }


}