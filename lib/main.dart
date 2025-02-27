import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:games_app/bloc_observer.dart';
import 'package:games_app/core/constants/constants.dart';
import 'package:games_app/core/helper/app_size_config.dart';
import 'package:games_app/core/local/cashe_helper/cashe_helper.dart';
import 'package:games_app/core/local/shared_preference/shared_preference.dart';
import 'package:games_app/core/network/dio_helper.dart';
import 'package:games_app/core/services/local_notification_services.dart';
import 'package:games_app/core/services/service_locator.dart';
import 'package:games_app/features/auth/presentation/controller/auth_cubit.dart';
import 'package:games_app/features/auth/presentation/view/screens/login_screen.dart';
import 'package:games_app/features/balance/presentation/cubit/balance_cubit.dart';
import 'package:games_app/features/bottom_navigation_bar/presentation/cubit/bottom_nav_cubit.dart';
import 'package:games_app/features/clients/presentation/cubit/client_cubit.dart';
import 'package:games_app/features/coupons/presentation/cubit/coupons_cubit.dart';
import 'package:games_app/features/home/presentation/controller/currency_cubit/currency_cubit.dart';
import 'package:games_app/features/orders/presentation/cubit/orders_cubit.dart';
import 'package:games_app/features/our_agent/presentation/cubit/our_agent_cubit.dart';
import 'package:games_app/features/payment_history/presentation/cubit/payment_history_cubit.dart';
import 'package:games_app/features/settings/presentation/cubit/settings_cubit.dart';
import 'package:games_app/features/splash/preentation/view/screen/splash_screen.dart';
import 'package:games_app/firebase_options.dart';
import 'package:games_app/styles/theme_manger/theme_manager.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'features/home/domain/repos/home_repo.dart';
import 'features/home/presentation/controller/categories_cubit/categories_cubit.dart';
import 'features/home/presentation/controller/companies_cubit/companies_cubit.dart';
import 'features/home/presentation/controller/image_sliders_cubit/image_sliders_cubit.dart';
import 'features/home/presentation/controller/text_slider_cubit/text_slider_cubit.dart';
import 'features/home/presentation/controller/theme_cubit/theme_cubit.dart';
import 'generated/l10n.dart';
// dae07f47-e131-4130-a4fa-a7edb578c67b



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await LocalNotificationServices.init();

  Bloc.observer = MyBlocObserver();
  ServiceLocator().setup();
  CashHelper.init();
  DioHelper.dioInit();
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
        BlocProvider(create: (context) => CurrencyCubit()..getCurrency()),
        BlocProvider(create: (context) => BottomNavCubit()..getUserInfo(context: context)..getDrawerData()..getMoreData(key: 'privacy-policy')),
        BlocProvider(create: (context) => OrdersCubit()..getOrders(search: "", status: "")),
        BlocProvider(create: (context) => BalanceCubit()),
        BlocProvider(create: (context) => AuthCubit(getIt(),getIt())),
        BlocProvider(create: (context) => SettingsCubit()),
        BlocProvider(create: (context) => PaymentHistoryCubit()..getPaymentHistory()),
        BlocProvider(create: (context) => OurAgentCubit()..getAgent()),
        BlocProvider(create: (context) => CouponsCubit()..getCoupons(search: "")),
        BlocProvider(create: (context) => ClientCubit()),
        BlocProvider(create: (context) => TextSliderCubit(getIt.get<HomeRepo>())..getTextSlider()),
        BlocProvider(create: (context) => ImageSlidersCubit(getIt.get<HomeRepo>())..getImageSlider()),
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

