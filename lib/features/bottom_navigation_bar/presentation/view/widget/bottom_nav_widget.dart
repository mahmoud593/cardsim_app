import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:games_app/core/helper/material_navigation.dart';
import 'package:games_app/core/local/shared_preference/shared_preference.dart';
import 'package:games_app/features/auth/presentation/view/screens/login_screen.dart';
import 'package:games_app/features/bottom_navigation_bar/presentation/cubit/bottom_nav_cubit.dart';
import 'package:games_app/features/bottom_navigation_bar/presentation/cubit/bottom_nav_state.dart';
import 'package:games_app/features/home/presentation/controller/theme_cubit/theme_cubit.dart';
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
            UserDataFromStorage.userTokenFromStorage != '' ?
            BottomNavCubit.get(context).changeBottomNav(value):
            showDialog(
                context: context,
                builder: (context) => BlocBuilder<ThemeCubit,ThemeState>(
                  builder: (context, state) {
                    return AlertDialog(
                        backgroundColor: UserDataFromStorage.themeIsDarkMode==false? ColorManager.white: ColorManager.darkThemeBackgroundLight,
                        title: Text('تنبيه',style: TextStyle(
                            color: UserDataFromStorage.themeIsDarkMode==false? ColorManager.textColor :
                            ColorManager.white
                        ),),
                        content: Text('تحتاج الي تسجيل الدخول لاستخدام التطبيق',style: TextStyle(
                            color: UserDataFromStorage.themeIsDarkMode==false? ColorManager.textColor :
                            ColorManager.white
                        ),),
                        actions: [
                          TextButton(
                            child:  const Text('تسجيل الدخول',style: TextStyle(
                                color:ColorManager.primary
                            ),),
                            onPressed: () {
                              Navigator.pop(context);
                              customPushNavigator(context, const LoginScreen());
                            },
                          ),
                          TextButton(
                            child: const Text('الغاء',style: TextStyle(color: Colors.red),),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ]
                    );
                  }
                )
            );
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
              label: 'الرئيسية',
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
