import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:games_app/bloc_observer.dart';
import 'package:games_app/core/local/cashe_helper/cashe_helper.dart';
import 'package:games_app/core/local/shared_preference/shared_preference.dart';
import 'package:games_app/core/services/service_locator.dart';
import 'package:games_app/features/balance/presentation/cubit/balance_cubit.dart';
import 'package:games_app/features/bottom_navigation_bar/presentation/cubit/bottom_nav_cubit.dart';
import 'package:games_app/features/home/data/repos/home_repo_imp.dart';
import 'package:games_app/features/orders/presentation/cubit/orders_cubit.dart';
import 'package:games_app/features/settings/presentation/cubit/settings_cubit.dart';
import 'package:games_app/styles/theme_manger/theme_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'features/bottom_navigation_bar/presentation/view/bottom_navigation_bar.dart';
import 'features/home/presentation/controller/categories_cubit/categories_cubit.dart';
import 'features/home/presentation/controller/companies_cubit/companies_cubit.dart';
import 'generated/l10n.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  ServiceLocator().setup();
  CashHelper.init();
  SharedPreferences.getInstance();
  UserDataFromStorage.getData();
  //await HomeRepoImp(ApiServices()).getCategories();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => BottomNavCubit()),
        BlocProvider(create: (context) => OrdersCubit()),
        BlocProvider(create: (context) => BalanceCubit()),
        BlocProvider(create: (context) => SettingsCubit()),
        BlocProvider(
          create: (context) =>
              CompaniesCubit(getIt.get<HomeRepoImp>())..getCompanies(),
        ),
        BlocProvider(
            create: (context) =>
                CategoriesCubit(getIt.get<HomeRepoImp>())..getCategories())
      ],
      child: MaterialApp(
        localizationsDelegates: const [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales,
        locale: const Locale('ar'),
        debugShowCheckedModeBanner: false,
        theme: getApplicationTheme(context),
        home: BottomNavigationScreen(),
      ),
    );
  }
}
