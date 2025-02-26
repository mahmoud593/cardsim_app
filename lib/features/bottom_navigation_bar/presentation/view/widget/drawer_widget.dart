import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:games_app/core/helper/app_size_config.dart';
import 'package:games_app/core/helper/material_navigation.dart';
import 'package:games_app/core/local/shared_preference/shared_preference.dart';
import 'package:games_app/features/auth/presentation/controller/auth_cubit.dart';
import 'package:games_app/features/auth/presentation/view/screens/login_screen.dart';
import 'package:games_app/features/bottom_navigation_bar/presentation/cubit/bottom_nav_cubit.dart';
import 'package:games_app/features/bottom_navigation_bar/presentation/cubit/bottom_nav_state.dart';
import 'package:games_app/features/bottom_navigation_bar/presentation/view/widget/drawer_ltem.dart';
import 'package:games_app/features/bottom_navigation_bar/presentation/view/widget/more_screen.dart';
import 'package:games_app/features/call_center/presentation/view/call_center_screen.dart';
import 'package:games_app/features/clients/presentation/view/clients_screen.dart';
import 'package:games_app/features/coupons/presentation/view/coupons_screen.dart';
import 'package:games_app/features/home/presentation/controller/theme_cubit/theme_cubit.dart';
import 'package:games_app/features/notification/presentation/view/notification_screen.dart';
import 'package:games_app/features/our_agent/presentation/view/our_agent_screen.dart';
import 'package:games_app/features/payment_history/presentation/view/payment_history_screen.dart';
import 'package:games_app/features/withdraws/presentation/views/withdraws_screen.dart';
import 'package:games_app/styles/assets/asset_manager.dart';
import 'package:games_app/styles/colors/color_manager.dart';
import 'package:games_app/styles/text_styles/text_styles.dart';
import 'package:games_app/styles/widgets/loading_widget.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({super.key});

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {

  @override
  void initState() {
    super.initState();
    AuthCubit.get(context).getUserInfo(context: context);
    BottomNavCubit.get(context).getDrawerData();
  }

  @override
  Widget build(BuildContext context) {
    bool isLight = Theme.of(context).brightness == Brightness.light;
    return BlocBuilder<BottomNavCubit, BottomNavStates>(
      builder: (context, state) {
        return Container(
          height: MediaQuery.of(context).size.height,
          color: isLight ? ColorManager.primary : ColorManager.darkThemeBackground,
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Visibility(
                    visible: BottomNavCubit.get(context).drawerOpenMore== true? true : false,
                    child: Row(
                      children: [
                        SizedBox(width: MediaQuery.of(context).size.width * 0.02,),
                        IconButton(
                          onPressed: (){
                            BottomNavCubit.get(context).changeDrawerOpenMore(false);
                          },
                          icon: Icon(
                            size: SizeConfig.height * 0.025,
                            Icons.arrow_back_ios,
                            color: ColorManager.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image(
                          height: SizeConfig.height * 0.08,
                          width: SizeConfig.height * 0.08,
                          image: AssetImage(UserDataFromStorage.themeIsDarkMode ? AssetManager.logoLight : AssetManager.logoDark),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              SizedBox(height: SizeConfig.height * 0.02,),

              Visibility(
                visible: BottomNavCubit.get(context).drawerOpenMore== false? true : false,
                  child: Column(
                    children: [
                      DrawerItem(
                        icon: Icons.home_filled,
                        title: 'الرئيسية',
                        onTap: () {
                          BottomNavCubit.get(context).changeBottomNav(0);

                          // if(UserDataFromStorage.userTokenFromStorage != ''){
                          // }else{
                          //   showDialog(
                          //       context: context,
                          //       builder: (context) => BlocBuilder<ThemeCubit,ThemeState>(
                          //           builder: (context, state) {
                          //             return AlertDialog(
                          //                 backgroundColor: UserDataFromStorage.themeIsDarkMode==false? ColorManager.white: ColorManager.darkThemeBackgroundLight,
                          //                 title: Text('تنبيه',style: TextStyle(
                          //                     color: UserDataFromStorage.themeIsDarkMode==false? ColorManager.textColor :
                          //                     ColorManager.white
                          //                 ),),
                          //                 content: Text('تحتاج الي تسجيل الدخول لاستخدام التطبيق',style: TextStyle(
                          //                     color: UserDataFromStorage.themeIsDarkMode==false? ColorManager.textColor :
                          //                     ColorManager.white
                          //                 ),),
                          //                 actions: [
                          //                   TextButton(
                          //                     child:  const Text('تسجيل الدخول',style: TextStyle(
                          //                         color:ColorManager.primary
                          //                     ),),
                          //                     onPressed: () {
                          //                       Navigator.pop(context);
                          //                       customPushNavigator(context, const LoginScreen());
                          //                     },
                          //                   ),
                          //                   TextButton(
                          //                     child: const Text('الغاء',style: TextStyle(color: Colors.red),),
                          //                     onPressed: () {
                          //                       Navigator.pop(context);
                          //                     },
                          //                   ),
                          //                 ]
                          //             );
                          //           }
                          //       )
                          //   );
                          // }
                        },
                      ),
                      DrawerItem(
                        icon: Icons.shopping_cart,
                        title: 'الطلبات',
                        onTap: () {
                          if(UserDataFromStorage.userTokenFromStorage != ''){
                            BottomNavCubit.get(context).changeBottomNav(1);
                          }else{
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
                          }
                        },
                      ),

                      DrawerItem(
                        icon: Icons.notifications_active,
                        title: 'الاشعارات',
                        onTap: () {
                          if(UserDataFromStorage.userTokenFromStorage != ''){
                            customPushNavigator(context, const NotificationScreen());
                          }
                          else{
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
                          }
                        },
                      ),

                      DrawerItem(
                        icon: Icons.wallet,
                        title: 'الرصيد',
                        onTap: () {
                          if(UserDataFromStorage.userTokenFromStorage != ''){
                            BottomNavCubit.get(context).changeBottomNav(2);
                          }
                          else{
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
                          }
                        },
                      ),
                      DrawerItem(
                        icon: Icons.history,
                        title: 'سجل العمليات',
                        onTap: () {
                          if(UserDataFromStorage.userTokenFromStorage != ''){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => const PaymentHistoryScreen(),));
                          }
                          else{
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
                          }
                        },
                      ),

                      if(UserDataFromStorage.genderFromStorage=='distributor')
                        DrawerItem(
                          icon: Icons.people_alt,
                          title: 'العملاء',
                          onTap: () {
                            if(UserDataFromStorage.userTokenFromStorage != ''){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => const ClientsScreen(),));
                            }
                            else{
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
                            }
                          },
                        ),

                      if(UserDataFromStorage.genderFromStorage=='distributor')
                        DrawerItem(
                          icon: Icons.history,
                          title: 'الأرباح',
                          onTap: () {
                            if(UserDataFromStorage.userTokenFromStorage != ''){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => const WithdrawsScreen(),));
                            }
                            else{
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
                            }
                          },
                        ),

                      if(UserDataFromStorage.genderFromStorage=='distributor')
                        DrawerItem(
                          icon: Icons.card_membership,
                          title: 'القسائم',
                          onTap: () {
                            if(UserDataFromStorage.userTokenFromStorage != ''){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => const CouponsScreen(),));
                            }
                            else{
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
                            }
                          },
                        ),


                      DrawerItem(
                        icon: Icons.people,
                        title: 'وكلاؤنا',
                        onTap: () {
                          if(UserDataFromStorage.userTokenFromStorage != ''){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => const OurAgentScreen(),));
                          }
                          else{
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
                          }
                        },
                      ),
                      DrawerItem(
                        icon: Icons.support_agent,
                        title: 'الدعم الفنى',
                        onTap: () {
                          if(UserDataFromStorage.userTokenFromStorage != ''){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => const CallCenterScreen(),));
                          }
                          else{
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
                          }
                        },
                      ),
                      DrawerItem(
                        icon: Icons.settings,
                        title: 'الإعدادات',
                        onTap: () {
                          if(UserDataFromStorage.userTokenFromStorage != ''){
                            BottomNavCubit.get(context).changeBottomNav(3);
                          }
                          else{
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
                          }
                        },
                      ),
                      DrawerItem(
                        icon: Icons.logout,
                        title: 'تسجيل الخروج',
                        onTap: () async {
                          if(UserDataFromStorage.userTokenFromStorage != ''){
                            await BottomNavCubit.get(context).logout();
                            customPushAndRemoveUntil(context, const LoginScreen());
                          }
                          else{
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
                          }

                        },
                      ),
                      DrawerItem(
                        icon: Icons.delete_outline,
                        title: 'حذف الحساب',
                        onTap: () async {
                          if(UserDataFromStorage.userTokenFromStorage != ''){
                            await BottomNavCubit.get(context).deleteAccount();
                            customPushAndRemoveUntil(context, const LoginScreen());
                          }
                          else{
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
                          }

                        },
                      ),
                    ],
                  ),
              ),

              Visibility(
                visible: BottomNavCubit.get(context).drawerOpenMore == true? true : false,
                  child: Column(
                                  children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.5,
                    child: ModalProgressHUD(
                      inAsyncCall: state is GetDrawerDataLoadingState? true : false,
                      progressIndicator: const LoadingAnimationWidget(),
                      child: ListView.separated(
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: (){
                                BottomNavCubit.get(context).selectMoreValue(BottomNavCubit.get(context).drawerItems[index].title);
                                customPushNavigator(context, MoreScreen(flag: BottomNavCubit.get(context).drawerItems[index].slug,));
                              },
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * 0.01, horizontal: MediaQuery.of(context).size.height * 0.02),
                                child: Text(
                                  BottomNavCubit.get(context).drawerItems[index].title,
                                  style: TextStyles.textStyle14Medium.copyWith(color: ColorManager.white),
                                ),
                              ),
                            );
                          },
                          separatorBuilder: (context, index) {
                            return SizedBox(
                              height: MediaQuery.of(context).size.height * 0.01,
                            );
                          },
                          itemCount: BottomNavCubit.get(context).drawerItems.length,
                      ),
                    ),
                  ),
                                  ],
                                )),

              const Spacer(),

              Visibility(
                visible: BottomNavCubit.get(context).drawerOpenMore == false? true : false,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: SizeConfig.height * 0.02, horizontal:SizeConfig.height * 0.02),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {
                              BottomNavCubit.get(context).selectMoreValue("سياسة الخصوصية");
                              customPushNavigator(context, const MoreScreen(flag: 'privacy-policy',));
                            },
                            child: Text(
                              'الخصوصية',
                              style: TextStyles.textStyle14Bold.copyWith(color: ColorManager.white),
                            ),
                          ),
                          Text(
                            ' . ',
                            style: TextStyles.textStyle18Bold.copyWith(color: ColorManager.white),
                          ),
                          InkWell(
                            onTap: () {
                              BottomNavCubit.get(context).selectMoreValue("الشروط والأحكام");
                              customPushNavigator(context, const MoreScreen(flag: 'terms-conditions',));
                            },
                            child: Text(
                              'الشروط',
                              style: TextStyles.textStyle14Bold.copyWith(color: ColorManager.white),
                            ),
                          ),
                          Text(
                            ' . ',
                            style: TextStyles.textStyle18Bold.copyWith(color: ColorManager.white),
                          ),
                          InkWell(
                            onTap: (){
                              BottomNavCubit.get(context).changeDrawerOpenMore(true);
                            },
                            child: Text(
                              'المزيد',
                              style: TextStyles.textStyle14Medium.copyWith(color: ColorManager.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
