import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:games_app/core/constants/urls.dart';
import 'package:games_app/core/local/shared_preference/shared_preference.dart';
import 'package:games_app/core/network/api_handle/http_request_handler.dart';
import 'package:games_app/core/network/api_handle/urls.dart';
import 'package:games_app/features/balance/presentation/view/balance_screen.dart';
import 'package:games_app/features/bottom_navigation_bar/data/models/drawer_model.dart';
import 'package:games_app/features/bottom_navigation_bar/data/models/more_model.dart';
import 'package:games_app/features/bottom_navigation_bar/data/more_repo_implement/more_repo_Implement.dart';
import 'package:games_app/features/bottom_navigation_bar/presentation/cubit/bottom_nav_state.dart';
import 'package:games_app/features/home/presentation/controller/currency_cubit/currency_cubit.dart';
import 'package:games_app/features/home/presentation/view/home_screen.dart';
import 'package:games_app/features/orders/presentation/view/orders_screen.dart';
import 'package:games_app/features/settings/presentation/view/screens/settings_screen.dart';
import 'package:games_app/styles/colors/color_manager.dart';
import 'package:google_sign_in/google_sign_in.dart';

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


  bool drawerOpenMore = false;

  void changeDrawerOpenMore(bool value){
    drawerOpenMore = value;
    emit(ChangeDrawerOpenMoreState());
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
      await GoogleSignIn().signOut();
      await GoogleSignIn().disconnect();
      await FirebaseAuth.instance.signOut();
      print('Logout Successfully');
      emit(LogoutSuccessState());
    }catch(error){
      print('error in logout is $error');
      emit(LogoutErrorState());
    }


  }

  Future<void> deleteAccount()async {

    emit(DeleteAccountLoadingState());
    try{
      var response = await httpHelper.callService(
        responseType: ResponseType.post,
        url: deleteAccountUrl,
        authorization: true,
      );
      UserDataFromStorage.setUserTokenFromStorage('');

      print('Response: ${response.toString()}');
      customToast(title: response['message'], color: ColorManager.primary);
      emit(DeleteAccountSuccessState());
    }catch(e){
      print('Error in deleteAccount: ${e.toString()}');
      emit(DeleteAccountErrorState());
    }
  }

  String moreScreenSelected = "سياسة الخصوصية";
  List<String> moreScreenList = [];

  void selectMoreValue(String value) {
    print('Previous selected: $moreScreenSelected'); // Debug print
    print('New selected: $value'); // Debug print
    moreScreenSelected = value;
    emit(SelectMoreValueState());
  }

  MoreModel moreModel = MoreModel(status: false, data: Data(title: '', slug: '', description: ''));

  getMoreData({required String key}) async{
    emit(GetMoreDataLoadingState());

    try{
      moreModel = await MoreRepoImplement().getMoreData(key: key);
      emit(GetMoreDataSuccessState());
    }catch(e){
      print('Error in getMoreData =============> ${e.toString()}');
      emit(GetMoreDataErrorState());
    }

  }

  List<DrawerModel> drawerItems= [];

  getDrawerData () async {
    emit(GetDrawerDataLoadingState());

    try{
      drawerItems = await MoreRepoImplement().getDrawerData();
      moreScreenSelected = drawerItems[0].title;
      for(var item in drawerItems){
        moreScreenList.add(item.title);
      }
      emit(GetDrawerDataSuccessState());
    }catch(e){
      debugPrint("Error when get drawer data ========> ${e.toString()}");
      emit(GetDrawerDataErrorState());
    }
    
  }



}