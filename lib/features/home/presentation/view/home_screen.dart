import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:games_app/core/helper/app_size_config.dart';
import 'package:games_app/core/helper/material_navigation.dart';
import 'package:games_app/core/local/shared_preference/shared_preference.dart';
import 'package:games_app/features/auth/presentation/view/screens/login_screen.dart';
import 'package:games_app/features/home/presentation/controller/currency_cubit/currency_cubit.dart';
import 'package:games_app/features/home/presentation/controller/currency_cubit/currency_states.dart';
import 'package:games_app/features/home/presentation/view/widgets/CurrencyDropdown.dart';
import 'package:games_app/features/home/presentation/view/widgets/home_screen_body.dart';
import 'package:games_app/features/level_structure/presentation/view/level_structure_screen.dart';
import 'package:games_app/features/notification/presentation/view/notification_screen.dart';
import 'package:games_app/styles/assets/asset_manager.dart';
import 'package:games_app/styles/widgets/loading_widget.dart';

import '../../../../styles/text_styles/text_styles.dart';
import '../../../bottom_navigation_bar/presentation/cubit/bottom_nav_cubit.dart';
import '../../../bottom_navigation_bar/presentation/view/widget/drawer_widget.dart';
import '../controller/theme_cubit/theme_cubit.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        titleSpacing: 0.0,
        title: Text(
          ' مساء الخير, ${UserDataFromStorage.fullNameFromStorage} !',
          style: TextStyles.textStyle18Bold.copyWith(),
        ),
        actions: [
          BlocBuilder<CurrencyCubit, CurrencyStates>(
            builder: (context, state) {
              return state is GetCurrencyLoadingState ? const LoadingAnimationWidget() : CurrencyDropdown(
                initialValue: CurrencyCubit.get(context).initialCurrency,
                onCurrencyChanged: (value) async {
                  await CurrencyCubit.get(context).currencyConvert(UserDataFromStorage.appCurrencyFromStorage, value);
                },
              );
            },
          ),
          const SizedBox(width: 5.0),
          GestureDetector(
            onTap: () {
              customPushNavigator(context, const LevelStructureScreen());
            },
            child: Image(
              height: MediaQuery.of(context).size.height * 0.04,
              image: const AssetImage('assets/images/rank.png'),
            ),
          ),
          BlocBuilder<ThemeCubit, ThemeState>(
            builder: (context, themeState) {
              return IconButton(
                onPressed: () {
                  context.read<ThemeCubit>().toggleTheme();
                },
                icon: AnimatedSwitcher(
                  duration:
                      const Duration(milliseconds: 300), // Animation duration
                  transitionBuilder:
                      (Widget child, Animation<double> animation) {
                    return RotationTransition(
                      turns: child.key == const ValueKey('dark')
                          ? Tween<double>(begin: 1.0, end: 0.75)
                              .animate(animation)
                          : Tween<double>(begin: 0.75, end: 1.0)
                              .animate(animation),
                      child: FadeTransition(
                        opacity: animation,
                        child: child,
                      ),
                    );
                  },
                  child: themeState == ThemeState.dark
                      ? const Icon(Icons.light_mode,
                          key: ValueKey('dark'), size: 30)
                      : const Icon(Icons.dark_mode,
                          key: ValueKey('light'), size: 30),
                ),
              );
            },
          ),
        ],
      ),
      drawer: const Drawer(
        child: DrawerWidget(),
      ),
      body: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 12),
        child: HomeScreenBody(),
      ),
    );
  }
}
