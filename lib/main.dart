import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:games_app/core/local/cashe_helper/cashe_helper.dart';
import 'package:games_app/core/local/shared_preference/shared_preference.dart';
import 'package:games_app/features/auth/presentation/view/screens/login_screen.dart';
import 'package:games_app/features/home/presentation/view/home_screen.dart';
import 'package:games_app/features/settings/presentation/view/screens/settings_screen.dart';
import 'package:games_app/features/splash/preentation/view/screen/splash_screen.dart';
import 'package:games_app/styles/theme_manger/theme_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'generated/l10n.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  CashHelper.init();
  SharedPreferences.getInstance();
  UserDataFromStorage.getData();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
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
      home:  const SettingsScreen(),
    );
  }
}


