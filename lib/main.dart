import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:games_app/bloc_observer.dart';
import 'package:games_app/core/local/cashe_helper/cashe_helper.dart';
import 'package:games_app/core/local/shared_preference/shared_preference.dart';
import 'package:games_app/core/services/service_locator.dart';
import 'package:games_app/features/auth/presentation/controller/auth_cubit.dart';
import 'package:games_app/features/auth/presentation/view/screens/login_screen.dart';
import 'package:games_app/features/balance/presentation/cubit/balance_cubit.dart';
import 'package:games_app/features/bottom_navigation_bar/presentation/cubit/bottom_nav_cubit.dart';
import 'package:games_app/features/clients/presentation/cubit/client_cubit.dart';
import 'package:games_app/features/coupons/presentation/cubit/coupons_cubit.dart';
import 'package:games_app/features/orders/presentation/cubit/orders_cubit.dart';
import 'package:games_app/features/our_agent/presentation/cubit/our_agent_cubit.dart';
import 'package:games_app/features/payment_history/presentation/cubit/payment_history_cubit.dart';
import 'package:games_app/features/settings/presentation/cubit/settings_cubit.dart';
import 'package:games_app/features/splash/preentation/view/screen/splash_screen.dart';
import 'package:games_app/features/withdraws/data/repos/withdraws_repo_imp.dart';
import 'package:games_app/features/withdraws/presentation/views/withdraws_screen.dart';
import 'package:games_app/firebase_options.dart';
import 'package:games_app/styles/theme_manger/theme_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'features/home/domain/repos/home_repo.dart';
import 'features/home/presentation/controller/categories_cubit/categories_cubit.dart';
import 'features/home/presentation/controller/companies_cubit/companies_cubit.dart';
import 'features/home/presentation/controller/theme_cubit/theme_cubit.dart';
import 'features/withdraws/data/api/withdraws_api_services.dart';
import 'generated/l10n.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Bloc.observer = MyBlocObserver();
  ServiceLocator().setup();
  CashHelper.init();
  await SharedPreferences.getInstance();
  await UserDataFromStorage.getData();
  //await HomeRepoImp(ApiServices()).createOrder(6, 1, 'test');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => BottomNavCubit()..getUserInfo()),
        BlocProvider(create: (context) => OrdersCubit()..getOrders(search: "", status: "")),
        BlocProvider(create: (context) => BalanceCubit()),
        BlocProvider(create: (context) => AuthCubit()..getUserInfo()),
        BlocProvider(create: (context) => SettingsCubit()),
        BlocProvider(create: (context) => PaymentHistoryCubit()),
        BlocProvider(create: (context) => OurAgentCubit()),
        BlocProvider(create: (context) => CouponsCubit()),
        BlocProvider(create: (context) => ClientCubit()),
        BlocProvider(
          create: (context) =>
              CompaniesCubit(getIt.get<HomeRepo>())..getCompanies(),
        ),
        BlocProvider(
            create: (context) =>
                CategoriesCubit(getIt.get<HomeRepo>())..getCategories()),
        BlocProvider(create: (context) => ThemeCubit()),
      ],
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, themeState) {
          return MaterialApp(
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
            darkTheme: getDarkTheme(context),
            themeMode: UserDataFromStorage.themeIsDarkMode
                ? ThemeMode.dark
                : ThemeMode.light,
            home: const SplashScreen(),
          );
        },
      ),
    );
  }
}
